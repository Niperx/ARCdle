import { useState, useEffect } from "react";
import type { DailyProgress } from "../types";
import { useI18n } from "../i18n";
import type { TranslationKey } from "../i18n";
import { getSecondsUntilNextReset, formatCountdown } from "../utils/nextReset";

interface Props {
  progress: DailyProgress;
  onClose: () => void;
}

const MODE_KEYS = ["weapon", "location", "blueprint", "sound", "skill"] as const;

function formatShareText(progress: DailyProgress, lang: "en" | "ru"): string {
  const date = new Date().toLocaleDateString(lang === "ru" ? "ru-RU" : "en-GB", {
    day: "numeric",
    month: "short",
    year: "numeric",
  });
  const labels: Record<string, { en: string; ru: string }> = {
    weapon: { en: "Weapon", ru: "Оружие" },
    location: { en: "Location", ru: "Локация" },
    blueprint: { en: "Blueprint", ru: "Чертёж" },
    sound: { en: "Sound", ru: "Звук" },
    skill: { en: "Skill", ru: "Навык" },
  };
  const attemptsWord = (n: number) =>
    lang === "ru" ? (n === 1 ? "попытка" : n >= 2 && n <= 4 ? "попытки" : "попыток") : n === 1 ? "attempt" : "attempts";

  const lines = [
    `ARCdle - ${date}`,
    "",
    ...MODE_KEYS.map((m) => {
      const a = progress.modes[m].attempts;
      const label = labels[m][lang];
      return `${label}: ${a} ${attemptsWord(a)}`;
    }),
  ];
  return lines.join("\n");
}

export default function AllCompleteModal({ progress, onClose }: Props) {
  const { t, lang } = useI18n();
  const [countdown, setCountdown] = useState(getSecondsUntilNextReset());
  const [shareStatus, setShareStatus] = useState<"idle" | "copied" | "shared">("idle");

  useEffect(() => {
    const interval = setInterval(() => {
      setCountdown(getSecondsUntilNextReset());
    }, 1000);
    return () => clearInterval(interval);
  }, []);

  async function handleShare() {
    const text = formatShareText(progress, lang);
    const shareData = {
      title: "ARCdle",
      text,
      url: window.location.origin,
    };
    if (navigator.share && navigator.canShare?.(shareData)) {
      try {
        await navigator.share(shareData);
        setShareStatus("shared");
      } catch {
        fallbackCopy(text);
      }
    } else {
      fallbackCopy(text);
    }
  }

  function fallbackCopy(text: string) {
    navigator.clipboard.writeText(text).then(() => {
      setShareStatus("copied");
      setTimeout(() => setShareStatus("idle"), 2000);
    });
  }

  return (
    <div className="all-complete-overlay" onClick={onClose}>
      <div className="all-complete-modal" onClick={(e) => e.stopPropagation()}>
        <h2 className="all-complete-title">{t("allCompleteTitle")}</h2>
        <p className="all-complete-subtitle">{t("allCompleteSubtitle")}</p>

        <div className="all-complete-stats">
          {MODE_KEYS.map((mode) => {
            const labelKey = { weapon: "modeWeapon", location: "modeLocation", blueprint: "modeBlueprint", sound: "modeSound", skill: "modeSkill" }[mode];
            return (
            <div key={mode} className="all-complete-stat-row">
              <span className="all-complete-stat-label">{t(labelKey as TranslationKey)}</span>
              <span className="all-complete-stat-value">
                {progress.modes[mode].attempts} {t("attemptsShort")}
              </span>
            </div>
          );})}
        </div>

        <div className="all-complete-timer">
          <span className="all-complete-timer-label">{t("nextResetIn")}</span>
          <span className="all-complete-timer-value">{formatCountdown(countdown)}</span>
        </div>

        <div className="all-complete-actions">
          <button className="all-complete-share-btn" onClick={handleShare}>
            {shareStatus === "copied" ? t("copied") : shareStatus === "shared" ? t("shared") : t("share")}
          </button>
          <button className="all-complete-close-btn" onClick={onClose}>
            {t("close")}
          </button>
        </div>
      </div>
    </div>
  );
}
