import json
from pathlib import Path

from app.database import Base, engine, SessionLocal
from app.models import (
    Weapon, Location, Material, Blueprint, BlueprintMaterial,
    Shield, ShieldMaterial, Augment, AugmentMaterial, AugmentShield,
    Skill, Sound, DailyCompletion, DailyGuess, RunScore,
)

DATA_DIR = Path(__file__).parent / "data"


def seed():
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)
    db = SessionLocal()

    try:
        # Weapons
        with open(DATA_DIR / "weapons.json") as f:
            weapons_data = json.load(f)
        for w in weapons_data:
            db.add(Weapon(**w))
        db.commit()
        print(f"Seeded {len(weapons_data)} weapons")

        # Locations
        with open(DATA_DIR / "locations.json") as f:
            locations_data = json.load(f)
        for loc in locations_data:
            db.add(Location(**loc))
        db.commit()
        print(f"Seeded {len(locations_data)} locations")

        # Materials
        with open(DATA_DIR / "materials.json") as f:
            materials_data = json.load(f)
        for mat in materials_data:
            db.add(Material(**mat))
        db.commit()
        print(f"Seeded {len(materials_data)} materials")

        # Blueprints
        with open(DATA_DIR / "blueprints.json") as f:
            blueprints_data = json.load(f)
        for bp_data in blueprints_data:
            bp = Blueprint(
                slug=bp_data["slug"],
                name=bp_data["name"],
                rarity=bp_data["rarity"],
                image=bp_data.get("image"),
            )
            db.add(bp)
            db.flush()

            for ing in bp_data["ingredients"]:
                material = db.query(Material).filter_by(slug=ing["material_slug"]).first()
                if not material:
                    print(f"  WARNING: material '{ing['material_slug']}' not found, skipping")
                    continue
                db.add(BlueprintMaterial(
                    blueprint_id=bp.id,
                    material_id=material.id,
                    quantity=ing["quantity"],
                    reveal_order=ing["reveal_order"],
                ))
        db.commit()
        print(f"Seeded {len(blueprints_data)} blueprints")

        # Shields
        with open(DATA_DIR / "shields.json") as f:
            shields_data = json.load(f)
        for sh_data in shields_data:
            sh = Shield(
                slug=sh_data["slug"],
                name=sh_data["name"],
                rarity=sh_data["rarity"],
                image=sh_data.get("image"),
                hq_image=sh_data.get("hq_image"),
            )
            db.add(sh)
            db.flush()

            for ing in sh_data["ingredients"]:
                material = db.query(Material).filter_by(slug=ing["material_slug"]).first()
                if not material:
                    print(f"  WARNING: material '{ing['material_slug']}' not found, skipping")
                    continue
                db.add(ShieldMaterial(
                    shield_id=sh.id,
                    material_id=material.id,
                    quantity=ing["quantity"],
                    reveal_order=ing["reveal_order"],
                ))
        db.commit()
        print(f"Seeded {len(shields_data)} shields")

        # Augments
        with open(DATA_DIR / "augments.json") as f:
            augments_data = json.load(f)
        for aug_data in augments_data:
            aug = Augment(
                slug=aug_data["slug"],
                name=aug_data["name"],
                rarity=aug_data["rarity"],
                image=aug_data.get("image"),
                hq_image=aug_data.get("hq_image"),
                craftable=aug_data.get("craftable", True),
            )
            db.add(aug)
            db.flush()

            for ing in aug_data.get("ingredients", []):
                material = db.query(Material).filter_by(slug=ing["material_slug"]).first()
                if not material:
                    print(f"  WARNING: material '{ing['material_slug']}' not found, skipping")
                    continue
                db.add(AugmentMaterial(
                    augment_id=aug.id,
                    material_id=material.id,
                    quantity=ing["quantity"],
                    reveal_order=ing["reveal_order"],
                ))

            for shield_slug in aug_data.get("compatible_shields", []):
                shield = db.query(Shield).filter_by(slug=shield_slug).first()
                if not shield:
                    print(f"  WARNING: shield '{shield_slug}' not found, skipping")
                    continue
                db.add(AugmentShield(
                    augment_id=aug.id,
                    shield_id=shield.id,
                ))
        db.commit()
        print(f"Seeded {len(augments_data)} augments")

        # Sounds
        with open(DATA_DIR / "sounds.json") as f:
            sounds_data = json.load(f)
        for snd in sounds_data:
            db.add(Sound(**snd))
        db.commit()
        print(f"Seeded {len(sounds_data)} sounds")

        # Skills
        with open(DATA_DIR / "skills.json", encoding="utf-8") as f:
            skills_data = json.load(f)
        for skill in skills_data:
            db.add(Skill(**skill))
        db.commit()
        print(f"Seeded {len(skills_data)} skills")

    finally:
        db.close()


if __name__ == "__main__":
    seed()
