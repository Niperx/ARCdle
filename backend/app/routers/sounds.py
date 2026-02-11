from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import Sound
from app.schemas import SoundListItem

router = APIRouter()


@router.get("/sounds", response_model=list[SoundListItem])
def list_sounds(db: Session = Depends(get_db)):
    sounds = db.query(Sound).order_by(Sound.name).all()
    return sounds
