export interface WeaponListItem {
  slug: string;
  name: string;
  image: string | null;
}

export interface LocationListItem {
  slug: string;
  name: string;
}

export interface BlueprintListItem {
  slug: string;
  name: string;
  image: string | null;
}

export interface SoundListItem {
  slug: string;
  name: string;
  category: string;
  image: string | null;
}

export interface SkillTreeNode {
  skill_id: string;
  name_en: string;
  name_ru: string;
  category: "conditioning" | "mobility" | "survival";
  position_x: number;
  position_y: number;
  prerequisites: string[];
  is_major: boolean;
  icon: string;
}

export interface GuessCount {
  slug: string;
  count: number;
}

export interface WeaponStat {
  key: string;
  label: string;
  value: number | string;
  type: "bar" | "text" | "number";
}

export interface WeaponStatsResponse {
  date: string;
  total_stats: number;
  stats: WeaponStat[];
  max_values: Record<string, number>;
}

export interface CropLevel {
  attempt: number;
  crop_percent: number;
}

export interface LocationDailyResponse {
  date: string;
  crop_x: number;
  crop_y: number;
  crop_levels: CropLevel[];
}

export interface BlueprintIngredient {
  material_name: string;
  material_slug: string;
  material_rarity: string;
  material_image: string | null;
  quantity: number;
  reveal_order: number;
}

export interface BlueprintHintsResponse {
  date: string;
  total_ingredients: number;
  ingredients: BlueprintIngredient[];
  revealed_name: string;
}

export interface GuessResponse {
  correct: boolean;
  answer_slug?: string;
  answer_image?: string;
  answer_hq_image?: string;
  answer_name?: string;
}

export interface CompletionResponse {
  position: number;
  total_today: number;
}

export interface ModeProgress {
  completed: boolean;
  attempts: number;
  guesses: string[];
  answeredCorrectSlug: string | null;
  answeredCorrectName: string | null;
  answeredCorrectImage: string | null;
  answeredCorrectHqImage: string | null;
  position: number | null;
  totalToday: number | null;
}

export interface BuildItem {
  slug: string;
  name: string;
  rarity: string;
  image: string | null;
  hq_image: string | null;
}

export interface RandomBuild {
  augment: BuildItem;
  shield: BuildItem;
  weapon1: BuildItem;
  weapon2: BuildItem;
  map_item: BuildItem;
}

export interface SoundDailyResponse {
  date: string;
  category: string;
}

export interface SkillDailyResponse {
  date: string;
  description_en: string;
  description_ru: string;
  category: string;
}

export interface DailyProgress {
  date: string;
  modes: {
    weapon: ModeProgress;
    location: ModeProgress;
    blueprint: ModeProgress;
    sound: ModeProgress;
    skill: ModeProgress;
  };
}
