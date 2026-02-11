import json
import random
from pathlib import Path

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import Weapon, Augment, AugmentShield, Shield
from app.schemas import RandomBuildResponse, BuildItem

router = APIRouter()
DATA_DIR = Path(__file__).resolve().parent.parent.parent / "data"


def _load_run_maps():
    with open(DATA_DIR / "run_maps.json", encoding="utf-8") as f:
        return json.load(f)


@router.get("/build/augments", response_model=list[BuildItem])
def list_augments(db: Session = Depends(get_db)):
    return [BuildItem.model_validate(a) for a in db.query(Augment).order_by(Augment.id).all()]


@router.get("/build/shields", response_model=list[BuildItem])
def list_shields(db: Session = Depends(get_db)):
    return [BuildItem.model_validate(s) for s in db.query(Shield).order_by(Shield.id).all()]


@router.get("/build/weapons", response_model=list[BuildItem])
def list_weapons(db: Session = Depends(get_db)):
    return [BuildItem.model_validate(w) for w in db.query(Weapon).order_by(Weapon.id).all()]


@router.get("/build/maps", response_model=list[BuildItem])
def list_maps():
    maps = _load_run_maps()
    return [
        BuildItem(
            slug=m["slug"],
            name=m["name"],
            rarity="",
            image=m.get("location_image") or m["image"].replace("/static/", ""),
            hq_image=None,
        )
        for m in maps
    ]


@router.get("/build/random", response_model=RandomBuildResponse)
def random_build(db: Session = Depends(get_db)):
    augments = db.query(Augment).all()
    augment = random.choice(augments)

    compatible_shield_ids = [
        row.shield_id
        for row in db.query(AugmentShield).filter_by(augment_id=augment.id).all()
    ]
    if compatible_shield_ids:
        shield = db.query(Shield).filter(Shield.id.in_(compatible_shield_ids)).order_by(
            Shield.id
        ).all()
        shield = random.choice(shield)
    else:
        shield = random.choice(db.query(Shield).all())

    weapons = db.query(Weapon).all()
    weapon1, weapon2 = random.sample(weapons, 2)

    maps = _load_run_maps()
    map_item = random.choice(maps)

    return RandomBuildResponse(
        augment=BuildItem.model_validate(augment),
        shield=BuildItem.model_validate(shield),
        weapon1=BuildItem.model_validate(weapon1),
        weapon2=BuildItem.model_validate(weapon2),
        map_item=BuildItem(
            slug=map_item["slug"],
            name=map_item["name"],
            rarity="",
            image=map_item.get("location_image") or map_item["image"].replace("/static/", ""),
            hq_image=None,
        ),
    )
