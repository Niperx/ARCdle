import { useState, useEffect } from "react";
import { fetchWeapons, fetchWeaponStats, fetchWeaponGuessCounts, guessWeapon, recordCompletion } from "../api/client";
import AutocompleteInput from "../components/AutocompleteInput";
import StatBar from "../components/StatBar";
import StatText from "../components/StatText";
import GuessHistory from "../components/GuessHistory";
import type { WeaponListItem, WeaponStatsResponse, GuessCount, ModeProgress } from "../types";
import { getPlayerId } from "../utils/playerId";
import { useI18n } from "../i18n";

interface Props {
  modeProgress: ModeProgress;
  onGuess: (slug: string) => void;
  onComplete: (slug: string, name: string, image: string | null, hqImage: string | null, position: number | null, totalToday: number | null) => void;
}

export default function WeaponMode({ modeProgress, onGuess, onComplete }: Props) {
  const [weapons, setWeapons] = useState<WeaponListItem[]>([]);
  const [statsData, setStatsData] = useState<WeaponStatsResponse | null>(null);
  const [guessCounts, setGuessCounts] = useState<GuessCount[]>([]);
  const { t } = useI18n();

  const revealCount = modeProgress.attempts + 1;

  useEffect(() => {
    fetchWeapons().then(setWeapons);
  }, []);

  useEffect(() => {
    if (!modeProgress.completed) {
      fetchWeaponStats(Math.min(revealCount, 14)).then(setStatsData);
    }
  }, [revealCount, modeProgress.completed]);

  useEffect(() => {
    if (modeProgress.guesses.length > 0) {
      fetchWeaponGuessCounts().then(setGuessCounts);
    }
  }, [modeProgress.guesses.length]);

  async function handleGuess(slug: string) {
    onGuess(slug);
    const res = await guessWeapon(slug);
    if (res.correct) {
      const attempts = modeProgress.attempts + 1;
      const completionRes = await recordCompletion("weapon", getPlayerId(), attempts);
      onComplete(
        res.answer_slug!,
        res.answer_name!,
        res.answer_image ?? null,
        res.answer_hq_image ?? null,
        completionRes.position,
        completionRes.total_today
      );
    } else {
      fetchWeaponStats(Math.min(revealCount + 1, 14)).then(setStatsData);
    }
  }

  if (modeProgress.completed) {
    return (
      <div className="mode-page">
        <h2>{t("guessTheWeapon")}</h2>
        <div className="completed-banner">
          <p>{t("alreadyGuessedWeapon")}</p>
          <p className="completed-answer">{modeProgress.answeredCorrectName}</p>
          {(modeProgress.answeredCorrectHqImage || modeProgress.answeredCorrectImage) && (
            <img
              src={`/static/${modeProgress.answeredCorrectHqImage || modeProgress.answeredCorrectImage}`}
              alt={modeProgress.answeredCorrectName ?? ""}
              className="completed-img"
            />
          )}
          <p>{t("attempts")}: {modeProgress.attempts}</p>
          {modeProgress.position !== null && (
            <p>{t("youWereNumber", { position: modeProgress.position })}</p>
          )}
        </div>
        <GuessHistory guesses={modeProgress.guesses} items={weapons} guessCounts={guessCounts} correctSlug={modeProgress.answeredCorrectSlug} />
      </div>
    );
  }

  return (
    <div className="mode-page">
      <h2>{t("guessTheWeapon")}</h2>
      <p className="mode-hint">
        {t("weaponHint")}
      </p>

      {statsData && (
        <div className="stats-list">
          {statsData.stats.map((stat) =>
            stat.type === "bar" ? (
              <StatBar
                key={stat.key}
                label={stat.label}
                value={stat.value as number}
                maxValue={statsData.max_values[stat.key] ?? 100}
              />
            ) : (
              <StatText key={stat.key} label={stat.label} value={stat.value} />
            )
          )}
        </div>
      )}

      <AutocompleteInput
        items={weapons}
        onSelect={handleGuess}
        disabled={modeProgress.completed}
        placeholder={t("typeWeaponName")}
        guessedSlugs={modeProgress.guesses}
      />

      <GuessHistory guesses={modeProgress.guesses} items={weapons} guessCounts={guessCounts} correctSlug={modeProgress.answeredCorrectSlug} />
    </div>
  );
}
