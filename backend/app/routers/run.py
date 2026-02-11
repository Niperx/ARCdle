import hashlib
import json
import random
from pathlib import Path

from fastapi import APIRouter, Depends, Query
from pydantic import BaseModel
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import RunScore, RunPlay

router = APIRouter()
DATA_DIR = Path(__file__).resolve().parent.parent.parent / "data"


def _load_run_maps():
    with open(DATA_DIR / "run_maps.json", encoding="utf-8") as f:
        return json.load(f)


def _load_run_texts():
    with open(DATA_DIR / "run_texts.json", encoding="utf-8") as f:
        return json.load(f)


@router.get("/run/maps")
def get_run_maps():
    """List of run maps with slug, name, image path, exit_positions (percent)."""
    return _load_run_maps()


@router.get("/run/texts")
def get_run_texts():
    """Success and failure text sets plus adjectives for default nickname."""
    return _load_run_texts()


@router.get("/run/leaderboard")
def get_leaderboard(
    limit: int = Query(20, ge=1, le=100),
    db: Session = Depends(get_db),
):
    """Top scores: nickname, score, created_at."""
    rows = (
        db.query(RunScore.nickname, RunScore.score, RunScore.created_at)
        .order_by(RunScore.score.desc(), RunScore.created_at.asc())
        .limit(limit)
        .all()
    )
    return [
        {"nickname": r[0], "score": r[1], "created_at": r[2].isoformat() if r[2] else None}
        for r in rows
    ]


class SaveScoreRequest(BaseModel):
    score: int
    nickname: str | None = None


def _default_nickname(lang: str) -> str:
    texts = _load_run_texts()
    if lang == "ru":
        adj = random.choice(texts["adjectives_ru"])
        return f"{adj} Плюшкин"
    adj = random.choice(texts["adjectives_en"])
    return f"{adj} Scrappy"


@router.post("/run/record-play")
def record_play(player_id: str = Query(""), db: Session = Depends(get_db)):
    """Record that a player attempted an escape (success or failure). Used for stats."""
    pid = player_id or "anon"
    if len(pid) > 64:
        pid = hashlib.sha256(pid.encode()).hexdigest()[:64]
    db.add(RunPlay(player_id=pid))
    db.commit()
    return {"ok": True}


@router.post("/run/save")
def save_score(
    body: SaveScoreRequest,
    lang: str = Query("en"),
    db: Session = Depends(get_db),
):
    """Save run score. If nickname is empty, generate adjective + Scrappy/Плюшкин."""
    nickname = (body.nickname or "").strip()
    if not nickname:
        nickname = _default_nickname(lang)
    nickname = nickname[:64]
    db.add(RunScore(nickname=nickname, score=body.score, player_id=None))
    db.commit()
    return {"ok": True, "nickname": nickname}
