import { useState, useEffect } from "react";
import { fetchLocations, fetchDailyLocation, fetchLocationGuessCounts, guessLocation, recordCompletion, DAILY_LOCATION_IMAGE_URL, getDailyLocationImageUrl } from "../api/client";
import AutocompleteInput from "../components/AutocompleteInput";
import LocationReveal from "../components/LocationReveal";
import GuessHistory from "../components/GuessHistory";
import type { LocationListItem, LocationDailyResponse, GuessCount, ModeProgress } from "../types";
import { getPlayerId } from "../utils/playerId";
import { useI18n } from "../i18n";

interface Props {
  modeProgress: ModeProgress;
  onGuess: (slug: string) => void;
  onComplete: (slug: string, name: string, image: string | null, hqImage: string | null, position: number | null, totalToday: number | null) => void;
}

export default function LocationMode({ modeProgress, onGuess, onComplete }: Props) {
  const [locations, setLocations] = useState<LocationListItem[]>([]);
  const [dailyData, setDailyData] = useState<LocationDailyResponse | null>(null);
  const [guessCounts, setGuessCounts] = useState<GuessCount[]>([]);
  const { t } = useI18n();

  useEffect(() => {
    fetchLocations().then(setLocations);
    fetchDailyLocation().then(setDailyData);
  }, []);

  useEffect(() => {
    if (modeProgress.guesses.length > 0) {
      fetchLocationGuessCounts().then(setGuessCounts);
    }
  }, [modeProgress.guesses.length]);

  const attemptIdx = Math.min(
    modeProgress.attempts,
    (dailyData?.crop_levels.length ?? 1) - 1
  );
  const cropPercent = dailyData?.crop_levels[attemptIdx]?.crop_percent ?? 10;

  async function handleGuess(slug: string) {
    onGuess(slug);
    const res = await guessLocation(slug);
    if (res.correct) {
      const attempts = modeProgress.attempts + 1;
      const completionRes = await recordCompletion("location", getPlayerId(), attempts);
      onComplete(
        res.answer_slug!,
        res.answer_name!,
        res.answer_image ?? null,
        null,
        completionRes.position,
        completionRes.total_today
      );
    }
  }

  if (modeProgress.completed) {
    return (
      <div className="mode-page">
        <h2>{t("guessTheLocation")}</h2>
        <div className="completed-banner">
          <p>{t("alreadyGuessedLocation")}</p>
          <p className="completed-answer">{modeProgress.answeredCorrectName}</p>
          <img src={DAILY_LOCATION_IMAGE_URL} alt={modeProgress.answeredCorrectName ?? ""} className="completed-img completed-img--wide" />
          <p>{t("attempts")}: {modeProgress.attempts}</p>
          {modeProgress.position !== null && (
            <p>{t("youWereNumber", { position: modeProgress.position })}</p>
          )}
        </div>
        <GuessHistory guesses={modeProgress.guesses} items={locations} guessCounts={guessCounts} correctSlug={modeProgress.answeredCorrectSlug} />
      </div>
    );
  }

  return (
    <div className="mode-page">
      <h2>{t("guessTheLocation")}</h2>
      <p className="mode-hint">
        {t("locationHint")}
      </p>

      {dailyData && (
        <LocationReveal
          imageUrl={getDailyLocationImageUrl(cropPercent)}
          cropX={dailyData.crop_x}
          cropY={dailyData.crop_y}
          cropPercent={cropPercent}
        />
      )}

      <AutocompleteInput
        items={locations}
        onSelect={handleGuess}
        disabled={modeProgress.completed}
        placeholder={t("typeLocationName")}
        guessedSlugs={modeProgress.guesses}
      />

      <GuessHistory guesses={modeProgress.guesses} items={locations} guessCounts={guessCounts} correctSlug={modeProgress.answeredCorrectSlug} />
    </div>
  );
}
