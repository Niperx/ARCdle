import hashlib
from datetime import date, datetime, timezone
from pathlib import Path

from app.config import settings

EPOCH = date.fromisoformat(settings.epoch_date)


def get_today_utc() -> date:
    return datetime.now(timezone.utc).date()


def daily_index(mode: str, today: date, pool_size: int) -> int:
    day_number = (today - EPOCH).days
    seed_str = f"{mode}:{day_number}"
    hash_bytes = hashlib.sha256(seed_str.encode()).digest()
    raw_index = int.from_bytes(hash_bytes[:4], "big")
    return raw_index % pool_size


def daily_crop_position(location_slug: str, today: date) -> tuple[float, float]:
    """Generate a deterministic crop center biased toward edges."""
    seed_str = f"crop:{location_slug}:{today.isoformat()}"
    hash_bytes = hashlib.sha256(seed_str.encode()).digest()

    raw_x = int.from_bytes(hash_bytes[:4], "big") % 1000 / 1000.0
    raw_y = int.from_bytes(hash_bytes[4:8], "big") % 1000 / 1000.0

    def to_edge(v: float) -> float:
        # Map [0, 1) into [0.05, 0.30] or [0.70, 0.95]
        if v < 0.5:
            return 0.05 + v * 2 * 0.25  # [0.05, 0.30]
        else:
            return 0.70 + (v - 0.5) * 2 * 0.25  # [0.70, 0.95]

    return to_edge(raw_x), to_edge(raw_y)


CROP_LEVELS = [
    {"attempt": 0, "crop_percent": 10},
    {"attempt": 1, "crop_percent": 20},
    {"attempt": 2, "crop_percent": 35},
    {"attempt": 3, "crop_percent": 50},
    {"attempt": 4, "crop_percent": 65},
    {"attempt": 5, "crop_percent": 80},
    {"attempt": 6, "crop_percent": 100},
]


def daily_location_image_path(location_slug: str, today: date) -> Path | None:
    """Select a deterministic random image from the location's folder."""
    location_dir = Path(settings.static_dir) / "maps" / "locations" / location_slug
    if not location_dir.exists():
        return None

    images = [f for f in location_dir.iterdir() if f.suffix.lower() in (".webp", ".png", ".jpg", ".jpeg", ".avif")]
    if not images:
        return None

    images.sort(key=lambda x: x.name)  # Deterministic order
    seed_str = f"locimg:{location_slug}:{today.isoformat()}"
    hash_bytes = hashlib.sha256(seed_str.encode()).digest()
    idx = int.from_bytes(hash_bytes[:4], "big") % len(images)
    return images[idx]

WEAPON_STATS_ORDER = [
    {"key": "damage", "label": "Damage", "type": "bar"},
    {"key": "fire_rate", "label": "Fire Rate", "type": "bar"},
    {"key": "range", "label": "Range", "type": "bar"},
    {"key": "stability", "label": "Stability", "type": "bar"},
    {"key": "agility", "label": "Agility", "type": "bar"},
    {"key": "stealth", "label": "Stealth", "type": "bar"},
    {"key": "ammo_type", "label": "Ammo Type", "type": "text"},
    {"key": "magazine_size", "label": "Magazine Size", "type": "number"},
    {"key": "firing_mode", "label": "Firing Mode", "type": "text"},
    {"key": "arc_armor_penetration", "label": "ARC Armor Penetration", "type": "text"},
    {"key": "weight", "label": "Weight", "type": "number"},
    {"key": "sell_price", "label": "Sell Price", "type": "text"},
    {"key": "rarity", "label": "Rarity", "type": "text"},
    {"key": "category", "label": "Category", "type": "text"},
]
