from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import Weapon
from app.schemas import WeaponListItem

router = APIRouter()


@router.get("/weapons", response_model=list[WeaponListItem])
def list_weapons(db: Session = Depends(get_db)):
    weapons = db.query(Weapon).order_by(Weapon.name).all()
    return weapons
