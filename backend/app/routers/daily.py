import io
import random
from pathlib import Path
from threading import Lock

from fastapi import APIRouter, Depends, Query
from fastapi.responses import FileResponse, Response
from PIL import Image

from sqlalchemy import func
from sqlalchemy.orm import Session

from app.config import settings
from app.database import get_db
from app.daily import (
    CROP_LEVELS,
    WEAPON_STATS_ORDER,
    daily_crop_position,
    daily_index,
    daily_location_image_path,
    get_today_utc,
)
from app.models import Blueprint, BlueprintMaterial, DailyCompletion, DailyGuess, Location, Material, Skill, Sound, Weapon
from app.schemas import (
    BlueprintHintsResponse,
    BlueprintIngredient,
    CompletionRequest,
    CompletionResponse,
    GuessCountItem,
    GuessRequest,
    GuessResponse,
    LocationDailyResponse,
    SkillDailyResponse,
    WeaponStat,
    WeaponStatsResponse,
)

router = APIRouter()

# Кеш обрезанных изображений локаций: (date, slug, crop) -> bytes
_location_crop_cache: dict[tuple[str, str, int], bytes] = {}
_location_crop_lock = Lock()

CROP_PERCENTS = [level["crop_percent"] for level in CROP_LEVELS if level["crop_percent"] < 100]


def _get_daily_weapon(db: Session) -> Weapon:
    count = db.query(func.count(Weapon.id)).scalar()
    idx = daily_index("weapon", get_today_utc(), count)
    return db.query(Weapon).order_by(Weapon.id).offset(idx).limit(1).one()


def _get_daily_location(db: Session) -> Location:
    count = db.query(func.count(Location.id)).scalar()
    idx = daily_index("location", get_today_utc(), count)
    return db.query(Location).order_by(Location.id).offset(idx).limit(1).one()


def _get_daily_blueprint(db: Session) -> Blueprint:
    count = db.query(func.count(Blueprint.id)).scalar()
    idx = daily_index("blueprint", get_today_utc(), count)
    return db.query(Blueprint).order_by(Blueprint.id).offset(idx).limit(1).one()


def _get_daily_sound(db: Session) -> Sound:
    count = db.query(func.count(Sound.id)).scalar()
    idx = daily_index("sound", get_today_utc(), count)
    return db.query(Sound).order_by(Sound.id).offset(idx).limit(1).one()


def _get_daily_skill(db: Session) -> Skill:
    count = db.query(func.count(Skill.id)).scalar()
    idx = daily_index("skill", get_today_utc(), count)
    return db.query(Skill).order_by(Skill.id).offset(idx).limit(1).one()


def _get_weapon_max_values(db: Session) -> dict[str, float]:
    bar_keys = ["damage", "fire_rate", "range", "stability", "agility", "stealth"]
    result = {}
    for key in bar_keys:
        col = getattr(Weapon, key)
        max_val = db.query(func.max(col)).scalar()
        result[key] = float(max_val) if max_val else 1.0
    return result


def _weapon_stat_value(weapon: Weapon, key: str):
    if key == "sell_price":
        return f"I: {weapon.sell_price_1} / II: {weapon.sell_price_2} / III: {weapon.sell_price_3} / IV: {weapon.sell_price_4}"
    return getattr(weapon, key)


# --- Weapon endpoints ---

@router.get("/weapon")
def daily_weapon_meta(db: Session = Depends(get_db)):
    return {
        "date": get_today_utc().isoformat(),
        "total_stats": len(WEAPON_STATS_ORDER),
    }


@router.get("/weapon/stats", response_model=WeaponStatsResponse)
def daily_weapon_stats(
    reveal_up_to: int = Query(1, ge=1, le=len(WEAPON_STATS_ORDER)),
    db: Session = Depends(get_db),
):
    weapon = _get_daily_weapon(db)
    max_values = _get_weapon_max_values(db)

    stats = []
    for i, stat_def in enumerate(WEAPON_STATS_ORDER[:reveal_up_to]):
        value = _weapon_stat_value(weapon, stat_def["key"])
        stats.append(WeaponStat(
            key=stat_def["key"],
            label=stat_def["label"],
            value=value,
            type=stat_def["type"],
        ))

    return WeaponStatsResponse(
        date=get_today_utc().isoformat(),
        total_stats=len(WEAPON_STATS_ORDER),
        stats=stats,
        max_values=max_values,
    )


@router.post("/weapon/guess", response_model=GuessResponse)
def guess_weapon(req: GuessRequest, db: Session = Depends(get_db)):
    today = get_today_utc()
    # Record the guess
    guess = DailyGuess(date=today, mode="weapon", guessed_slug=req.slug)
    db.add(guess)
    db.commit()

    weapon = _get_daily_weapon(db)
    correct = weapon.slug == req.slug
    if correct:
        return GuessResponse(
            correct=True,
            answer_slug=weapon.slug,
            answer_name=weapon.name,
            answer_image=weapon.image,
            answer_hq_image=weapon.hq_image,
        )
    return GuessResponse(correct=False)


@router.get("/weapon/guess-counts", response_model=list[GuessCountItem])
def weapon_guess_counts(db: Session = Depends(get_db)):
    today = get_today_utc()
    results = (
        db.query(DailyGuess.guessed_slug, func.count(DailyGuess.id).label("count"))
        .filter(DailyGuess.date == today, DailyGuess.mode == "weapon")
        .group_by(DailyGuess.guessed_slug)
        .all()
    )
    return [GuessCountItem(slug=r[0], count=r[1]) for r in results]


# --- Location endpoints ---

@router.get("/location", response_model=LocationDailyResponse)
def daily_location_meta(db: Session = Depends(get_db)):
    location = _get_daily_location(db)
    today = get_today_utc()
    crop_x, crop_y = daily_crop_position(location.slug, today)
    return LocationDailyResponse(
        date=today.isoformat(),
        crop_x=crop_x,
        crop_y=crop_y,
        crop_levels=CROP_LEVELS,
    )


def _generate_location_crops(image_path: Path, location_slug: str, today) -> None:
    """Генерирует все crop-уровни для локации и заполняет кеш. Вызывать под lock."""
    date_str = today.isoformat()
    for k in list(_location_crop_cache):
        if k[0] != date_str:
            del _location_crop_cache[k]
    img = Image.open(image_path).convert("RGB")
    w, h = img.size
    crop_x, crop_y = daily_crop_position(location_slug, today)
    for crop_pct in CROP_PERCENTS:
        key = (date_str, location_slug, crop_pct)
        if key in _location_crop_cache:
            continue
        crop_w = max(1, int(w * crop_pct / 100))
        crop_h = max(1, int(h * crop_pct / 100))
        cx = int(crop_x * w)
        cy = int(crop_y * h)
        left = max(0, min(cx - crop_w // 2, w - crop_w))
        top = max(0, min(cy - crop_h // 2, h - crop_h))
        cropped = img.crop((left, top, left + crop_w, top + crop_h))
        buf = io.BytesIO()
        cropped.save(buf, format="WEBP", quality=85)
        _location_crop_cache[key] = buf.getvalue()


@router.get("/location/image")
def daily_location_image(
    db: Session = Depends(get_db),
    crop: int | None = Query(None, ge=1, le=100),
):
    location = _get_daily_location(db)
    today = get_today_utc()
    image_path = daily_location_image_path(location.slug, today)
    if not image_path or not image_path.exists():
        return {"error": "Image not found"}
    media_type = "image/webp"
    if image_path.suffix.lower() == ".avif":
        media_type = "image/avif"
    elif image_path.suffix.lower() in (".jpg", ".jpeg"):
        media_type = "image/jpeg"
    elif image_path.suffix.lower() == ".png":
        media_type = "image/png"

    if crop is not None and crop < 100:
        date_str = today.isoformat()
        key = (date_str, location.slug, crop)
        with _location_crop_lock:
            if key not in _location_crop_cache:
                _generate_location_crops(image_path, location.slug, today)
            cached = _location_crop_cache.get(key)
        if cached:
            return Response(content=cached, media_type="image/webp")

    return FileResponse(image_path, media_type=media_type)


@router.post("/location/guess", response_model=GuessResponse)
def guess_location(req: GuessRequest, db: Session = Depends(get_db)):
    today = get_today_utc()
    # Record the guess
    guess = DailyGuess(date=today, mode="location", guessed_slug=req.slug)
    db.add(guess)
    db.commit()

    location = _get_daily_location(db)
    correct = location.slug == req.slug
    if correct:
        return GuessResponse(
            correct=True,
            answer_slug=location.slug,
            answer_name=location.name,
            answer_image=location.image,
        )
    return GuessResponse(correct=False)


@router.get("/location/guess-counts", response_model=list[GuessCountItem])
def location_guess_counts(db: Session = Depends(get_db)):
    today = get_today_utc()
    results = (
        db.query(DailyGuess.guessed_slug, func.count(DailyGuess.id).label("count"))
        .filter(DailyGuess.date == today, DailyGuess.mode == "location")
        .group_by(DailyGuess.guessed_slug)
        .all()
    )
    return [GuessCountItem(slug=r[0], count=r[1]) for r in results]


# --- Blueprint endpoints ---

def _reveal_letters(name: str, letters_to_reveal: int, seed: str) -> str:
    """
    Reveal letters progressively:
    - letters_to_reveal=0: all underscores
    - letters_to_reveal=1,2,...N: reveal first letters of words one by one
    - after all first letters: reveal remaining letters randomly (seeded)
    """
    # Find all letter positions
    letter_positions = [i for i, char in enumerate(name) if char.isalpha()]

    # Find first letter of each word
    first_letter_positions = []
    in_word = False
    for i, char in enumerate(name):
        if char.isalpha():
            if not in_word:
                first_letter_positions.append(i)
                in_word = True
        else:
            in_word = False

    # Remaining letters (not first letters of words)
    remaining_positions = [p for p in letter_positions if p not in first_letter_positions]

    # Shuffle remaining positions with seed for consistency
    rng = random.Random(seed)
    rng.shuffle(remaining_positions)

    # Build reveal order: first letters of words, then shuffled remaining
    reveal_order = first_letter_positions + remaining_positions

    # Determine which positions to reveal based on letters_to_reveal count
    revealed_positions = set(reveal_order[:letters_to_reveal])

    # Build result string
    result = []
    for i, char in enumerate(name):
        if char.isalpha():
            if i in revealed_positions:
                result.append(char)
            else:
                result.append("_")
        else:
            result.append(char)

    return "".join(result)


@router.get("/blueprint/hints", response_model=BlueprintHintsResponse)
def daily_blueprint_hints(
    reveal_up_to: int = Query(1, ge=1),
    db: Session = Depends(get_db),
):
    blueprint = _get_daily_blueprint(db)
    all_ingredients = (
        db.query(BlueprintMaterial)
        .filter(BlueprintMaterial.blueprint_id == blueprint.id)
        .order_by(BlueprintMaterial.reveal_order)
        .all()
    )

    total_ingredients = len(all_ingredients)

    # Reveal order:
    # attempt 1: just the name length (all underscores)
    # attempts 2 to N+1: reveal ingredients one by one
    # attempts N+2 onwards: reveal letters one by one

    # How many ingredients to show (attempt 1 = 0 ingredients, attempt 2 = 1, etc.)
    ingredients_to_show = max(0, reveal_up_to - 1)
    revealed_ingredient_list = all_ingredients[:ingredients_to_show]

    ingredients = []
    for bm in revealed_ingredient_list:
        mat = db.query(Material).filter(Material.id == bm.material_id).one()
        ingredients.append(BlueprintIngredient(
            material_name=mat.name,
            material_slug=mat.slug,
            material_rarity=mat.rarity,
            material_image=mat.image,
            quantity=bm.quantity,
            reveal_order=bm.reveal_order,
        ))

    # How many letters to reveal (starts after all ingredients are shown)
    # Letters start revealing at attempt (total_ingredients + 2)
    letters_to_reveal = max(0, reveal_up_to - total_ingredients - 1)

    # Use date + blueprint slug as seed for consistent random order
    seed = f"{get_today_utc().isoformat()}:{blueprint.slug}"
    revealed_name = _reveal_letters(blueprint.name, letters_to_reveal, seed)

    return BlueprintHintsResponse(
        date=get_today_utc().isoformat(),
        total_ingredients=total_ingredients,
        ingredients=ingredients,
        revealed_name=revealed_name,
    )


@router.post("/blueprint/guess", response_model=GuessResponse)
def guess_blueprint(req: GuessRequest, db: Session = Depends(get_db)):
    today = get_today_utc()
    # Record the guess
    guess = DailyGuess(date=today, mode="blueprint", guessed_slug=req.slug)
    db.add(guess)
    db.commit()

    blueprint = _get_daily_blueprint(db)
    correct = blueprint.slug == req.slug
    if correct:
        return GuessResponse(
            correct=True,
            answer_slug=blueprint.slug,
            answer_name=blueprint.name,
            answer_image=blueprint.image,
            answer_hq_image=blueprint.hq_image,
        )
    return GuessResponse(correct=False)


@router.get("/blueprint/guess-counts", response_model=list[GuessCountItem])
def blueprint_guess_counts(db: Session = Depends(get_db)):
    today = get_today_utc()
    results = (
        db.query(DailyGuess.guessed_slug, func.count(DailyGuess.id).label("count"))
        .filter(DailyGuess.date == today, DailyGuess.mode == "blueprint")
        .group_by(DailyGuess.guessed_slug)
        .all()
    )
    return [GuessCountItem(slug=r[0], count=r[1]) for r in results]


# --- Sound endpoints ---

@router.get("/sound")
def daily_sound_meta(db: Session = Depends(get_db)):
    sound = _get_daily_sound(db)
    return {
        "date": get_today_utc().isoformat(),
        "category": sound.category,
    }


@router.get("/sound/audio")
def daily_sound_audio(db: Session = Depends(get_db)):
    sound = _get_daily_sound(db)
    sound_path = Path(settings.static_dir) / sound.sound_file
    if not sound_path.exists():
        return {"error": "Sound not found"}
    return FileResponse(sound_path, media_type="audio/mpeg")


@router.post("/sound/guess", response_model=GuessResponse)
def guess_sound(req: GuessRequest, db: Session = Depends(get_db)):
    today = get_today_utc()
    # Record the guess
    guess = DailyGuess(date=today, mode="sound", guessed_slug=req.slug)
    db.add(guess)
    db.commit()

    sound = _get_daily_sound(db)
    correct = sound.slug == req.slug
    if correct:
        return GuessResponse(
            correct=True,
            answer_slug=sound.slug,
            answer_name=sound.name,
            answer_image=sound.image,
            answer_hq_image=sound.hq_image,
        )
    return GuessResponse(correct=False)


@router.get("/sound/guess-counts", response_model=list[GuessCountItem])
def sound_guess_counts(db: Session = Depends(get_db)):
    today = get_today_utc()
    results = (
        db.query(DailyGuess.guessed_slug, func.count(DailyGuess.id).label("count"))
        .filter(DailyGuess.date == today, DailyGuess.mode == "sound")
        .group_by(DailyGuess.guessed_slug)
        .all()
    )
    return [GuessCountItem(slug=r[0], count=r[1]) for r in results]


# --- Skill endpoints ---

@router.get("/skill", response_model=SkillDailyResponse)
def daily_skill_meta(db: Session = Depends(get_db)):
    """Returns today's skill description (both languages) + category hint"""
    skill = _get_daily_skill(db)
    return SkillDailyResponse(
        date=get_today_utc().isoformat(),
        description_en=skill.description_en,
        description_ru=skill.description_ru,
        category=skill.category,
    )


@router.get("/skill/tree")
def daily_skill_tree(db: Session = Depends(get_db)):
    """Returns all skills with positions for SVG rendering"""
    import json
    from app.routers.skills import skill_icon_filename

    skills = db.query(Skill).order_by(Skill.category, Skill.skill_id).all()
    return [
        {
            "skill_id": s.skill_id,
            "name_en": s.name_en,
            "name_ru": s.name_ru,
            "category": s.category,
            "position_x": s.position_x,
            "position_y": s.position_y,
            "prerequisites": json.loads(s.prerequisites) if s.prerequisites else [],
            "is_major": s.is_major,
            "icon": skill_icon_filename(s.name_en),
        }
        for s in skills
    ]


@router.post("/skill/guess", response_model=GuessResponse)
def guess_skill(req: GuessRequest, db: Session = Depends(get_db)):
    """Submit a skill guess. req.slug contains the skill_id (e.g., 'cond_1')"""
    today = get_today_utc()
    # Record the guess (storing skill_id in guessed_slug field)
    guess = DailyGuess(date=today, mode="skill", guessed_slug=req.slug)
    db.add(guess)
    db.commit()

    skill = _get_daily_skill(db)
    correct = skill.skill_id == req.slug
    if correct:
        return GuessResponse(
            correct=True,
            answer_slug=skill.skill_id,
            answer_name=skill.name_en,
            answer_image=None,  # Skills don't have images
            answer_hq_image=None,
        )
    return GuessResponse(correct=False)


@router.get("/skill/guess-counts", response_model=list[GuessCountItem])
def skill_guess_counts(db: Session = Depends(get_db)):
    """Returns global guess counts for skills (slug field contains skill_id)"""
    today = get_today_utc()
    results = (
        db.query(DailyGuess.guessed_slug, func.count(DailyGuess.id).label("count"))
        .filter(DailyGuess.date == today, DailyGuess.mode == "skill")
        .group_by(DailyGuess.guessed_slug)
        .all()
    )
    return [GuessCountItem(slug=r[0], count=r[1]) for r in results]


# --- Completion tracking ---

@router.post("/complete", response_model=CompletionResponse)
def record_completion(req: CompletionRequest, db: Session = Depends(get_db)):
    today = get_today_utc()

    # Check if already completed today
    existing = db.query(DailyCompletion).filter(
        DailyCompletion.date == today,
        DailyCompletion.mode == req.mode,
        DailyCompletion.player_id == req.player_id,
    ).first()

    if existing:
        # Return existing position
        position = db.query(func.count(DailyCompletion.id)).filter(
            DailyCompletion.date == today,
            DailyCompletion.mode == req.mode,
            DailyCompletion.completed_at <= existing.completed_at,
        ).scalar()
    else:
        # Record new completion
        completion = DailyCompletion(
            date=today,
            mode=req.mode,
            player_id=req.player_id,
            attempts=req.attempts,
        )
        db.add(completion)
        db.commit()
        db.refresh(completion)

        position = db.query(func.count(DailyCompletion.id)).filter(
            DailyCompletion.date == today,
            DailyCompletion.mode == req.mode,
            DailyCompletion.completed_at <= completion.completed_at,
        ).scalar()

    total_today = db.query(func.count(DailyCompletion.id)).filter(
        DailyCompletion.date == today,
        DailyCompletion.mode == req.mode,
    ).scalar()

    return CompletionResponse(position=position, total_today=total_today)
