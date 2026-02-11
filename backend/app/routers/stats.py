import hashlib
from datetime import date, datetime, timedelta

from fastapi import APIRouter, Depends, Query
from fastapi.responses import StreamingResponse
from sqlalchemy import func
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import DailyCompletion, RunPlay, RunScore, FavoriteVote, Visit

router = APIRouter()

MODES = ["weapon", "location", "blueprint", "sound", "skill"]


@router.get("/summary")
def stats_summary(db: Session = Depends(get_db)):
    """Aggregate stats: daily completions, run attempts/saves, favorite votes."""
    result = {"modes": {}, "total_completions": 0, "total_unique_players": 0}

    all_player_ids = set()

    for mode in MODES:
        completions = (
            db.query(func.count(DailyCompletion.id))
            .filter(DailyCompletion.mode == mode)
            .scalar()
            or 0
        )
        unique = (
            db.query(func.count(func.distinct(DailyCompletion.player_id)))
            .filter(DailyCompletion.mode == mode)
            .scalar()
            or 0
        )
        player_ids = db.query(DailyCompletion.player_id).filter(DailyCompletion.mode == mode).distinct().all()
        all_player_ids.update(pid[0] for pid in player_ids)

        result["modes"][mode] = {"completions": completions, "unique_players": unique}

    result["total_completions"] = sum(m["completions"] for m in result["modes"].values())
    result["total_unique_players"] = len(all_player_ids)

    # Exodus Run
    result["run_attempts"] = (
        db.query(func.count(func.distinct(RunPlay.player_id)))
        .scalar() or 0
    )
    result["run_saves"] = db.query(func.count(RunScore.id)).scalar() or 0

    # Favorite
    result["favorite_votes"] = (
        db.query(func.count(func.distinct(FavoriteVote.player_id)))
        .scalar() or 0
    )

    return result


@router.post("/record-visit")
def record_visit(player_id: str = Query(""), db: Session = Depends(get_db)):
    """Record a page visit. Call on app load. player_id from localStorage."""
    pid = player_id or "anon"
    if len(pid) > 64:
        pid = hashlib.sha256(pid.encode()).hexdigest()[:64]
    db.add(Visit(player_id=pid))
    db.commit()
    return {"ok": True}


@router.get("/visits")
def visits_stats(db: Session = Depends(get_db)):
    """Unique visitors in last 1h, 4h, 12h, 24h, 7d."""
    now = datetime.utcnow()
    periods = [
        ("1h", timedelta(hours=1)),
        ("4h", timedelta(hours=4)),
        ("12h", timedelta(hours=12)),
        ("24h", timedelta(hours=24)),
        ("7d", timedelta(days=7)),
    ]
    result = {}
    for key, delta in periods:
        since = now - delta
        count = (
            db.query(func.count(func.distinct(Visit.player_id)))
            .filter(Visit.created_at >= since)
            .scalar()
            or 0
        )
        result[key] = count
    return result


@router.get("/by-date")
def stats_by_date(db: Session = Depends(get_db)):
    """Completions per mode per date."""
    rows = (
        db.query(DailyCompletion.date, DailyCompletion.mode, func.count(DailyCompletion.id))
        .group_by(DailyCompletion.date, DailyCompletion.mode)
        .order_by(DailyCompletion.date.desc(), DailyCompletion.mode)
        .all()
    )
    by_date: dict[str, dict[str, int]] = {}
    for d, mode, count in rows:
        key = d.isoformat() if isinstance(d, date) else str(d)
        if key not in by_date:
            by_date[key] = {}
        by_date[key][mode] = count
    return {"by_date": by_date}


@router.get("/export")
def stats_export(db: Session = Depends(get_db)):
    """Export stats as JSON file for download."""
    summary = stats_summary(db)
    by_date_data = stats_by_date(db)

    export_data = {
        "exported_at": datetime.utcnow().isoformat() + "Z",
        "summary": summary,
        "by_date": by_date_data.get("by_date", {}),
    }
    content = json.dumps(export_data, indent=2, ensure_ascii=False)
    return StreamingResponse(
        iter([content]),
        media_type="application/json",
        headers={"Content-Disposition": "attachment; filename=arcdle-stats.json"},
    )
