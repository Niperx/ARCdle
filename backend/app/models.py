from sqlalchemy import Boolean, Column, Integer, String, Float, ForeignKey, Date, DateTime
from sqlalchemy.orm import relationship
from datetime import datetime

from app.database import Base


class Weapon(Base):
    __tablename__ = "weapons"

    id = Column(Integer, primary_key=True)
    slug = Column(String(100), unique=True, nullable=False)
    name = Column(String(100), nullable=False)
    category = Column(String(30), nullable=False)
    rarity = Column(String(20), nullable=False)
    image = Column(String(200), nullable=True)
    hq_image = Column(String(200), nullable=True)

    damage = Column(Float, nullable=False)
    fire_rate = Column(Float, nullable=False)
    range = Column(Float, nullable=False)
    stability = Column(Float, nullable=False)
    agility = Column(Float, nullable=False)
    stealth = Column(Float, nullable=False)

    ammo_type = Column(String(20), nullable=False)
    magazine_size = Column(Integer, nullable=False)
    firing_mode = Column(String(20), nullable=False)
    arc_armor_penetration = Column(String(20), nullable=False)
    weight = Column(Float, nullable=False)

    sell_price_1 = Column(Integer, nullable=False)
    sell_price_2 = Column(Integer, nullable=False)
    sell_price_3 = Column(Integer, nullable=False)
    sell_price_4 = Column(Integer, nullable=False)

    headshot_multiplier = Column(Float, nullable=True)


class Location(Base):
    __tablename__ = "locations"

    id = Column(Integer, primary_key=True)
    slug = Column(String(100), unique=True, nullable=False)
    name = Column(String(100), nullable=False)
    image = Column(String(200), nullable=True)
    region = Column(String(100), nullable=True)


class Material(Base):
    __tablename__ = "materials"

    id = Column(Integer, primary_key=True)
    slug = Column(String(100), unique=True, nullable=False)
    name = Column(String(100), nullable=False)
    rarity = Column(String(20), nullable=False)
    image = Column(String(200), nullable=True)


class Blueprint(Base):
    __tablename__ = "blueprints"

    id = Column(Integer, primary_key=True)
    slug = Column(String(100), unique=True, nullable=False)
    name = Column(String(100), nullable=False)
    rarity = Column(String(20), nullable=False)
    image = Column(String(200), nullable=True)
    hq_image = Column(String(200), nullable=True)

    ingredients = relationship("BlueprintMaterial", back_populates="blueprint")


class BlueprintMaterial(Base):
    __tablename__ = "blueprint_materials"

    id = Column(Integer, primary_key=True)
    blueprint_id = Column(Integer, ForeignKey("blueprints.id"), nullable=False)
    material_id = Column(Integer, ForeignKey("materials.id"), nullable=False)
    quantity = Column(Integer, nullable=False)
    reveal_order = Column(Integer, nullable=False)

    blueprint = relationship("Blueprint", back_populates="ingredients")
    material = relationship("Material")


class Shield(Base):
    __tablename__ = "shields"

    id = Column(Integer, primary_key=True)
    slug = Column(String(100), unique=True, nullable=False)
    name = Column(String(100), nullable=False)
    rarity = Column(String(20), nullable=False)
    image = Column(String(200), nullable=True)
    hq_image = Column(String(200), nullable=True)

    ingredients = relationship("ShieldMaterial", back_populates="shield")
    compatible_augments = relationship("AugmentShield", back_populates="shield")


class ShieldMaterial(Base):
    __tablename__ = "shield_materials"

    id = Column(Integer, primary_key=True)
    shield_id = Column(Integer, ForeignKey("shields.id"), nullable=False)
    material_id = Column(Integer, ForeignKey("materials.id"), nullable=False)
    quantity = Column(Integer, nullable=False)
    reveal_order = Column(Integer, nullable=False)

    shield = relationship("Shield", back_populates="ingredients")
    material = relationship("Material")


class Augment(Base):
    __tablename__ = "augments"

    id = Column(Integer, primary_key=True)
    slug = Column(String(100), unique=True, nullable=False)
    name = Column(String(100), nullable=False)
    rarity = Column(String(20), nullable=False)
    image = Column(String(200), nullable=True)
    hq_image = Column(String(200), nullable=True)
    craftable = Column(Boolean, default=True)

    ingredients = relationship("AugmentMaterial", back_populates="augment")
    compatible_shields = relationship("AugmentShield", back_populates="augment")


class AugmentMaterial(Base):
    __tablename__ = "augment_materials"

    id = Column(Integer, primary_key=True)
    augment_id = Column(Integer, ForeignKey("augments.id"), nullable=False)
    material_id = Column(Integer, ForeignKey("materials.id"), nullable=False)
    quantity = Column(Integer, nullable=False)
    reveal_order = Column(Integer, nullable=False)

    augment = relationship("Augment", back_populates="ingredients")
    material = relationship("Material")


class AugmentShield(Base):
    __tablename__ = "augment_shields"

    id = Column(Integer, primary_key=True)
    augment_id = Column(Integer, ForeignKey("augments.id"), nullable=False)
    shield_id = Column(Integer, ForeignKey("shields.id"), nullable=False)

    augment = relationship("Augment", back_populates="compatible_shields")
    shield = relationship("Shield", back_populates="compatible_augments")


class Sound(Base):
    __tablename__ = "sounds"

    id = Column(Integer, primary_key=True)
    slug = Column(String(100), unique=True, nullable=False)
    name = Column(String(100), nullable=False)
    category = Column(String(50), nullable=False)  # weapon, enemy, environment, vehicle
    sound_file = Column(String(200), nullable=False)  # sounds/{slug}.mp3
    image = Column(String(200), nullable=True)  # optional image to show after guess
    hq_image = Column(String(200), nullable=True)  # HQ image for display


class Skill(Base):
    __tablename__ = "skills"

    id = Column(Integer, primary_key=True)
    skill_id = Column(String(20), unique=True, nullable=False)  # "cond_1", "mob_2l", etc.
    name_en = Column(String(100), nullable=False)
    name_ru = Column(String(100), nullable=False)
    description_en = Column(String(500), nullable=False)
    description_ru = Column(String(500), nullable=False)
    category = Column(String(20), nullable=False)  # conditioning, mobility, survival
    position_x = Column(Float, nullable=False)  # 0-100 coordinate
    position_y = Column(Float, nullable=False)  # 0-100 coordinate
    prerequisites = Column(String(200), nullable=True)  # JSON array as string, e.g., '["cond_1"]'
    is_major = Column(Boolean, default=False)  # Major skills are larger nodes


class DailyCompletion(Base):
    __tablename__ = "daily_completions"

    id = Column(Integer, primary_key=True)
    date = Column(Date, nullable=False)
    mode = Column(String(20), nullable=False)  # weapon, location, blueprint
    player_id = Column(String(64), nullable=False)  # anonymous hash from frontend
    attempts = Column(Integer, nullable=False)
    completed_at = Column(DateTime, default=datetime.utcnow)


class DailyGuess(Base):
    __tablename__ = "daily_guesses"

    id = Column(Integer, primary_key=True)
    date = Column(Date, nullable=False)
    mode = Column(String(20), nullable=False)  # weapon, location, blueprint
    guessed_slug = Column(String(100), nullable=False)  # slug of the guessed item
    guessed_at = Column(DateTime, default=datetime.utcnow)


class RunScore(Base):
    __tablename__ = "run_scores"

    id = Column(Integer, primary_key=True)
    nickname = Column(String(64), nullable=False)
    score = Column(Integer, nullable=False)
    player_id = Column(String(64), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)


class RunPlay(Base):
    """Tracks each escape attempt (success or failure) for stats."""
    __tablename__ = "run_plays"

    id = Column(Integer, primary_key=True)
    player_id = Column(String(64), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)


class FavoriteVote(Base):
    __tablename__ = "favorite_votes"

    id = Column(Integer, primary_key=True)
    date = Column(Date, nullable=False)
    category = Column(String(30), nullable=False)  # arc, weapon, etc.
    favorite_slug = Column(String(100), nullable=False)
    player_id = Column(String(64), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)


class Visit(Base):
    """Tracks page visits for stats (unique visitors per period)."""
    __tablename__ = "visits"

    id = Column(Integer, primary_key=True)
    player_id = Column(String(64), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
