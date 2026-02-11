from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import Blueprint
from app.schemas import BlueprintListItem

router = APIRouter()


@router.get("/blueprints", response_model=list[BlueprintListItem])
def list_blueprints(db: Session = Depends(get_db)):
    blueprints = db.query(Blueprint).order_by(Blueprint.name).all()
    return blueprints
