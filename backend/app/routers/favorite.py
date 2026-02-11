import json
import hashlib
from datetime import date, datetime, timezone
from pathlib import Path

from fastapi import APIRouter, Depends, Query
from pydantic import BaseModel
from sqlalchemy import func
from sqlalchemy.orm import Session

from app.config import settings
from app.database import get_db
from app.models import FavoriteVote

router = APIRouter()
DATA_DIR = Path(__file__).resolve().parent.parent.parent / "data"
FAVORITE_CATEGORIES = ["arc", "trader"]


def _load_json(name: str):
    with open(DATA_DIR / name, encoding="utf-8") as f:
        return json.load(f)


def _daily_category() -> str:
    """Pick today's favorite category (arc or trader) deterministically."""
    epoch = date.fromisoformat(settings.epoch_date)
    today = datetime.now(timezone.utc).date()
    day_number = (today - epoch).days
    seed_str = f"favorite_category:{day_number}"
    raw = int.from_bytes(hashlib.sha256(seed_str.encode()).digest()[:4], "big")
    return FAVORITE_CATEGORIES[raw % len(FAVORITE_CATEGORIES)]


def _load_items(category: str):
    if category == "arc":
        return _load_json("arcs.json")
    if category == "trader":
        return _load_json("traders.json")
    return []


@router.get("/favorite/category")
def get_today_category():
    """Today's category for favorite voting: arc or trader."""
    return {"category": _daily_category()}


@router.get("/favorite/items")
def get_favorite_items(category: str = Query("arc")):
    """List items for the category (slug, name, image)."""
    items = _load_items(category)
    return [{"slug": x["slug"], "name": x["name"], "image": f"/static/{x['image']}"} for x in items]


class VoteRequest(BaseModel):
    category: str
    favorite_slug: str


@router.post("/favorite/vote")
def submit_vote(body: VoteRequest, player_id: str = Query(""), db: Session = Depends(get_db)):
    """Record user's favorite. player_id from localStorage hash."""
    pid = player_id or "anon"
    if len(pid) > 64:
        pid = hashlib.sha256(pid.encode()).hexdigest()[:64]
    today = date.today()
    # One vote per player per day per category
    existing = db.query(FavoriteVote).filter(
        FavoriteVote.date == today,
        FavoriteVote.category == body.category,
        FavoriteVote.player_id == pid,
    ).first()
    if existing:
        existing.favorite_slug = body.favorite_slug
    else:
        db.add(FavoriteVote(date=today, category=body.category, favorite_slug=body.favorite_slug, player_id=pid))
    db.commit()
    return {"ok": True}


@router.get("/favorite/status")
def get_status(
    category: str = Query("arc"),
    player_id: str = Query(""),
    db: Session = Depends(get_db),
):
    """Check if current player has voted today."""
    pid = player_id or "anon"
    if len(pid) > 64:
        pid = hashlib.sha256(pid.encode()).hexdigest()[:64]
    today = date.today()
    vote = (
        db.query(FavoriteVote)
        .filter(
            FavoriteVote.date == today,
            FavoriteVote.category == category,
            FavoriteVote.player_id == pid,
        )
        .first()
    )
    if vote:
        return {"has_voted": True, "favorite_slug": vote.favorite_slug}
    return {"has_voted": False}


@router.get("/favorite/results")
def get_results(category: str = Query("arc"), db: Session = Depends(get_db)):
    """Today's vote counts per slug and total voters."""
    today = date.today()
    rows = (
        db.query(FavoriteVote.favorite_slug, func.count(FavoriteVote.id).label("cnt"))
        .filter(FavoriteVote.date == today, FavoriteVote.category == category)
        .group_by(FavoriteVote.favorite_slug)
        .all()
    )
    total = sum(r.cnt for r in rows)
    items = _load_items(category)
    by_slug = {x["slug"]: {"name": x["name"], "image": f"/static/{x['image']}"} for x in items}
    results = [
        {"slug": r.favorite_slug, "votes": r.cnt, "percent": round(100 * r.cnt / total, 1) if total else 0}
        for r in rows
    ]
    results.sort(key=lambda x: -x["votes"])
    return {"total_votes": total, "results": results, "items": by_slug}
