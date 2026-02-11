import json
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import Skill

router = APIRouter()


def skill_icon_filename(name_en: str) -> str:
    """Convert English skill name to icon filename"""
    # Remove apostrophes, replace spaces and hyphens with underscores
    filename = name_en.lower().replace("'", "").replace(" ", "_").replace("-", "_")
    return filename + ".webp"


@router.get("/skills")
def list_skills(db: Session = Depends(get_db)):
    """List all skills with positions for frontend rendering"""
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
            "icon": skill_icon_filename(s.name_en)
        }
        for s in skills
    ]
