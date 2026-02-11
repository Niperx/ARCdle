from pydantic import BaseModel


class WeaponListItem(BaseModel):
    slug: str
    name: str
    image: str | None = None

    class Config:
        from_attributes = True


class LocationListItem(BaseModel):
    slug: str
    name: str

    class Config:
        from_attributes = True


class BlueprintListItem(BaseModel):
    slug: str
    name: str
    image: str | None = None

    class Config:
        from_attributes = True


class SoundListItem(BaseModel):
    slug: str
    name: str
    category: str
    image: str | None = None

    class Config:
        from_attributes = True


class SkillTreeNode(BaseModel):
    skill_id: str
    name_en: str
    name_ru: str
    category: str
    position_x: float
    position_y: float
    prerequisites: list[str]
    is_major: bool

    class Config:
        from_attributes = True


class SkillDailyResponse(BaseModel):
    date: str
    description_en: str
    description_ru: str
    category: str


class GuessCountItem(BaseModel):
    slug: str
    count: int


class WeaponStat(BaseModel):
    key: str
    label: str
    value: float | int | str
    type: str  # "bar", "text", "number"


class WeaponStatsResponse(BaseModel):
    date: str
    total_stats: int
    stats: list[WeaponStat]
    max_values: dict[str, float]  # for bar normalization


class LocationDailyResponse(BaseModel):
    date: str
    crop_x: float
    crop_y: float
    crop_levels: list[dict]


class BlueprintIngredient(BaseModel):
    material_name: str
    material_slug: str
    material_rarity: str
    material_image: str | None
    quantity: int
    reveal_order: int


class BlueprintHintsResponse(BaseModel):
    date: str
    total_ingredients: int
    ingredients: list[BlueprintIngredient]
    revealed_name: str  # e.g. "A__ C_______" - partially revealed name


class GuessRequest(BaseModel):
    slug: str


class GuessResponse(BaseModel):
    correct: bool
    answer_slug: str | None = None
    answer_image: str | None = None
    answer_hq_image: str | None = None
    answer_name: str | None = None


class CompletionRequest(BaseModel):
    mode: str  # weapon, location, blueprint
    player_id: str  # anonymous hash from frontend
    attempts: int


class CompletionResponse(BaseModel):
    position: int  # which player you are today (1st, 2nd, etc.)
    total_today: int  # total completions today for this mode


class BuildItem(BaseModel):
    slug: str
    name: str
    rarity: str
    image: str | None = None
    hq_image: str | None = None

    class Config:
        from_attributes = True


class RandomBuildResponse(BaseModel):
    augment: BuildItem
    shield: BuildItem
    weapon1: BuildItem
    weapon2: BuildItem
    map_item: BuildItem
