const API_BASE = "/api";

async function fetchJson<T>(path: string): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`);
  if (!res.ok) throw new Error(`API error: ${res.status}`);
  return res.json();
}

async function postJson<T>(path: string, body: unknown): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  if (!res.ok) throw new Error(`API error: ${res.status}`);
  return res.json();
}

// Lists for autocomplete
export const fetchWeapons = () => fetchJson<import("../types").WeaponListItem[]>("/weapons");
export const fetchLocations = () => fetchJson<import("../types").LocationListItem[]>("/locations");
export const fetchBlueprints = () => fetchJson<import("../types").BlueprintListItem[]>("/blueprints");

// Daily weapon
export const fetchDailyWeaponMeta = () => fetchJson<{ date: string; total_stats: number }>("/daily/weapon");
export const fetchWeaponStats = (revealUpTo: number) =>
  fetchJson<import("../types").WeaponStatsResponse>(`/daily/weapon/stats?reveal_up_to=${revealUpTo}`);
export const guessWeapon = (slug: string) =>
  postJson<import("../types").GuessResponse>("/daily/weapon/guess", { slug });
export const fetchWeaponGuessCounts = () =>
  fetchJson<import("../types").GuessCount[]>("/daily/weapon/guess-counts");

// Daily location
export const fetchDailyLocation = () => fetchJson<import("../types").LocationDailyResponse>("/daily/location");
export const DAILY_LOCATION_IMAGE_URL = `${API_BASE}/daily/location/image`;
export const getDailyLocationImageUrl = (cropPercent: number) =>
  cropPercent >= 100 ? DAILY_LOCATION_IMAGE_URL : `${DAILY_LOCATION_IMAGE_URL}?crop=${cropPercent}`;
export const guessLocation = (slug: string) =>
  postJson<import("../types").GuessResponse>("/daily/location/guess", { slug });
export const fetchLocationGuessCounts = () =>
  fetchJson<import("../types").GuessCount[]>("/daily/location/guess-counts");

// Daily blueprint
export const fetchBlueprintHints = (revealUpTo: number) =>
  fetchJson<import("../types").BlueprintHintsResponse>(`/daily/blueprint/hints?reveal_up_to=${revealUpTo}`);
export const guessBlueprint = (slug: string) =>
  postJson<import("../types").GuessResponse>("/daily/blueprint/guess", { slug });
export const fetchBlueprintGuessCounts = () =>
  fetchJson<import("../types").GuessCount[]>("/daily/blueprint/guess-counts");

// Sound
export const fetchSounds = () => fetchJson<import("../types").SoundListItem[]>("/sounds");
export const fetchDailySound = () => fetchJson<import("../types").SoundDailyResponse>("/daily/sound");
export const DAILY_SOUND_AUDIO_URL = `${API_BASE}/daily/sound/audio`;
export const guessSound = (slug: string) =>
  postJson<import("../types").GuessResponse>("/daily/sound/guess", { slug });
export const fetchSoundGuessCounts = () =>
  fetchJson<import("../types").GuessCount[]>("/daily/sound/guess-counts");

// Skill
export const fetchSkillTree = () => fetchJson<import("../types").SkillTreeNode[]>("/daily/skill/tree");
export const fetchDailySkill = () => fetchJson<import("../types").SkillDailyResponse>("/daily/skill");
export const guessSkill = (skill_id: string) =>
  postJson<import("../types").GuessResponse>("/daily/skill/guess", { slug: skill_id });
export const fetchSkillGuessCounts = () =>
  fetchJson<import("../types").GuessCount[]>("/daily/skill/guess-counts");

// Build
export const fetchRandomBuild = () => fetchJson<import("../types").RandomBuild>("/build/random");
export const fetchBuildAugments = () => fetchJson<import("../types").BuildItem[]>("/build/augments");
export const fetchBuildShields = () => fetchJson<import("../types").BuildItem[]>("/build/shields");
export const fetchBuildWeapons = () => fetchJson<import("../types").BuildItem[]>("/build/weapons");
export const fetchBuildMaps = () => fetchJson<import("../types").BuildItem[]>("/build/maps");

// Completion tracking
export const recordCompletion = (mode: string, playerId: string, attempts: number) =>
  postJson<import("../types").CompletionResponse>("/daily/complete", { mode, player_id: playerId, attempts });

// Stats
export interface StatsSummary {
  modes: Record<string, { completions: number; unique_players: number }>;
  total_completions: number;
  total_unique_players: number;
  run_attempts?: number;
  run_saves?: number;
  favorite_votes?: number;
}
export const fetchStatsSummary = () => fetchJson<StatsSummary>("/stats/summary");
export interface VisitsStats {
  "1h": number;
  "4h": number;
  "12h": number;
  "24h": number;
  "7d": number;
}
export const fetchVisitsStats = () => fetchJson<VisitsStats>("/stats/visits");
export const recordVisit = (playerId: string) =>
  postJson<{ ok: boolean }>(`/stats/record-visit?player_id=${encodeURIComponent(playerId)}`, {});

// Run (Exodus mini-game)
export interface RunMap {
  slug: string;
  name: string;
  exit_type?: "surface" | "underground";
  crop?: number | { right?: number };
  image: string;
  image_width?: number;
  image_height?: number;
  exit_positions: ({ x: number; y: number; w: number; h: number } | { x_px: number; y_px: number; icon?: string })[];
}
export interface RunTexts {
  surface_success: string[];
  surface_failure: string[];
  underground_success: string[];
  underground_failure: string[];
  adjectives_en: string[];
  adjectives_ru: string[];
}
export interface LeaderboardEntry {
  nickname: string;
  score: number;
  created_at: string | null;
}
export const fetchRunMaps = () => fetchJson<RunMap[]>("/run/maps");
export const fetchRunTexts = () => fetchJson<RunTexts>("/run/texts");
export const fetchRunLeaderboard = (limit = 20) =>
  fetchJson<LeaderboardEntry[]>(`/run/leaderboard?limit=${limit}`);
export const saveRunScore = (score: number, nickname: string | null, lang: "en" | "ru") =>
  postJson<{ ok: boolean; nickname: string }>(
    `/run/save?lang=${lang}`,
    { score, nickname: nickname || undefined }
  );
export const recordRunPlay = (playerId: string) =>
  postJson<{ ok: boolean }>(`/run/record-play?player_id=${encodeURIComponent(playerId)}`, {});

// Favorite (daily best-of-two voting)
export interface FavoriteItem {
  slug: string;
  name: string;
  image: string;
}
export interface FavoriteCategory {
  category: string;
}
export interface FavoriteResults {
  total_votes: number;
  results: { slug: string; votes: number; percent: number }[];
  items: Record<string, { name: string; image: string }>;
}
export const fetchFavoriteCategory = () => fetchJson<FavoriteCategory>("/favorite/category");
export interface FavoriteStatus {
  has_voted: boolean;
  favorite_slug?: string;
}
export const fetchFavoriteStatus = (category: string, playerId: string) =>
  fetchJson<FavoriteStatus>(`/favorite/status?category=${category}&player_id=${encodeURIComponent(playerId)}`);
export const fetchFavoriteItems = (category: string) =>
  fetchJson<FavoriteItem[]>(`/favorite/items?category=${category}`);
export const submitFavoriteVote = (category: string, favoriteSlug: string, playerId: string) =>
  postJson<{ ok: boolean }>(`/favorite/vote?player_id=${encodeURIComponent(playerId)}`, {
    category,
    favorite_slug: favoriteSlug,
  });
export const fetchFavoriteResults = (category: string) =>
  fetchJson<FavoriteResults>(`/favorite/results?category=${category}`);
