import { useState, useEffect } from "react";
import { fetchStatsSummary, fetchVisitsStats } from "../api/client";
import type { StatsSummary, VisitsStats } from "../api/client";
import { useI18n } from "../i18n";

const MODE_KEYS = ["weapon", "location", "blueprint", "sound", "skill"] as const;
const VISITS_PERIODS: { key: keyof VisitsStats; labelKey: string }[] = [
  { key: "1h", labelKey: "statsVisits1h" },
  { key: "4h", labelKey: "statsVisits4h" },
  { key: "12h", labelKey: "statsVisits12h" },
  { key: "24h", labelKey: "statsVisits24h" },
  { key: "7d", labelKey: "statsVisits7d" },
];
const MODE_LABELS: Record<string, string> = {
  weapon: "modeWeapon",
  location: "modeLocation",
  blueprint: "modeBlueprint",
  sound: "modeSound",
  skill: "modeSkill",
};

export default function Stats() {
  const { t } = useI18n();
  const [stats, setStats] = useState<StatsSummary | null>(null);
  const [visits, setVisits] = useState<VisitsStats | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    Promise.all([fetchStatsSummary(), fetchVisitsStats()])
      .then(([s, v]) => {
        setStats(s);
        setVisits(v);
      })
      .catch((e) => setError(e instanceof Error ? e.message : "Failed to load"))
      .finally(() => setLoading(false));
  }, []);

  function handleExport() {
    const base = typeof window !== "undefined" ? window.location.origin : "";
    window.open(`${base}/api/stats/export`, "_blank");
  }

  if (loading) {
    return (
      <div className="stats-page">
        <h2>{t("statsTitle")}</h2>
        <p className="stats-loading">{t("loading")}</p>
      </div>
    );
  }

  if (error || !stats) {
    return (
      <div className="stats-page">
        <h2>{t("statsTitle")}</h2>
        <p className="stats-error">{error ?? t("statsError")}</p>
      </div>
    );
  }

  return (
    <div className="stats-page">
      <h2>{t("statsTitle")}</h2>
      <p className="stats-subtitle">{t("statsSubtitle")}</p>

      <div className="stats-summary">
        <div className="stats-summary-row">
          <span className="stats-label">{t("totalCompletions")}</span>
          <span className="stats-value">{stats.total_completions}</span>
        </div>
        <div className="stats-summary-row">
          <span className="stats-label">{t("uniquePlayers")}</span>
          <span className="stats-value">{stats.total_unique_players}</span>
        </div>
      </div>

      {visits && (
        <div className="stats-visits">
          <h3>{t("statsVisitsTitle")}</h3>
          <div className="stats-visits-grid">
            {VISITS_PERIODS.map(({ key, labelKey }) => (
              <div key={key} className="stats-visits-item">
                <span className="stats-visits-value">{visits[key]}</span>
                <span className="stats-visits-label">{t(labelKey as import("../i18n").TranslationKey)}</span>
              </div>
            ))}
          </div>
        </div>
      )}

      <div className="stats-other">
        <h3>{t("statsOtherModes")}</h3>
        <div className="stats-summary-row">
          <span className="stats-label">{t("statsRunAttempts")}</span>
          <span className="stats-value">{stats.run_attempts ?? 0}</span>
        </div>
        <div className="stats-summary-row">
          <span className="stats-label">{t("statsRunSaves")}</span>
          <span className="stats-value">{stats.run_saves ?? 0}</span>
        </div>
        <div className="stats-summary-row">
          <span className="stats-label">{t("statsFavoriteVotes")}</span>
          <span className="stats-value">{stats.favorite_votes ?? 0}</span>
        </div>
      </div>

      <div className="stats-modes">
        <h3>{t("statsByMode")}</h3>
        <div className="stats-modes-header">
          <span className="stats-mode-label">{t("mode")}</span>
          <span className="stats-mode-completions">{t("completions")}</span>
          <span className="stats-mode-unique">{t("uniquePlayers")}</span>
        </div>
        {MODE_KEYS.map((mode) => {
          const m = stats.modes[mode];
          if (!m) return null;
          return (
            <div key={mode} className="stats-mode-row">
              <span className="stats-mode-label">{t((MODE_LABELS[mode] ?? mode) as import("../i18n").TranslationKey)}</span>
              <span className="stats-mode-completions">{m.completions}</span>
              <span className="stats-mode-unique">{m.unique_players}</span>
            </div>
          );
        })}
      </div>

      <div className="stats-export">
        <button type="button" className="stats-export-btn" onClick={handleExport}>
          {t("exportStats")}
        </button>
      </div>
    </div>
  );
}
