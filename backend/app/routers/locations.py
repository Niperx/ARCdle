from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import Location
from app.schemas import LocationListItem

router = APIRouter()


@router.get("/locations", response_model=list[LocationListItem])
def list_locations(db: Session = Depends(get_db)):
    locations = db.query(Location).order_by(Location.name).all()
    return locations
