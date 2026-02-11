import { useState, useEffect } from "react";
import { fetchBlueprints, fetchBlueprintHints, fetchBlueprintGuessCounts, guessBlueprint, recordCompletion } from "../api/client";
import AutocompleteInput from "../components/AutocompleteInput";
import IngredientCard from "../components/IngredientCard";
import GuessHistory from "../components/GuessHistory";
import type { BlueprintListItem, BlueprintHintsResponse, GuessCount, ModeProgress } from "../types";
import { getPlayerId } from "../utils/playerId";
import { useI18n } from "../i18n";

interface Props {
  modeProgress: ModeProgress;
  onGuess: (slug: string) => void;
  onComplete: (slug: string, name: string, image: string | null, hqImage: string | null, position: number | null, totalToday: number | null) => void;
}

export default function BlueprintMode({ modeProgress, onGuess, onComplete }: Props) {
  const [blueprints, setBlueprints] = useState<BlueprintListItem[]>([]);
  const [hintsData, setHintsData] = useState<BlueprintHintsResponse | null>(null);
  const [guessCounts, setGuessCounts] = useState<GuessCount[]>([]);
  const { t } = useI18n();

  const revealCount = modeProgress.attempts + 1;

  useEffect(() => {
    fetchBlueprints().then(setBlueprints);
  }, []);

  useEffect(() => {
    if (!modeProgress.completed) {
      fetchBlueprintHints(revealCount).then(setHintsData);
    }
  }, [revealCount, modeProgress.completed]);

  useEffect(() => {
    if (modeProgress.guesses.length > 0) {
      fetchBlueprintGuessCounts().then(setGuessCounts);
    }
  }, [modeProgress.guesses.length]);

  async function handleGuess(slug: string) {
    onGuess(slug);
    const res = await guessBlueprint(slug);
    if (res.correct) {
      const attempts = modeProgress.attempts + 1;
      const completionRes = await recordCompletion("blueprint", getPlayerId(), attempts);
      onComplete(
        res.answer_slug!,
        res.answer_name!,
        res.answer_image ?? null,
        res.answer_hq_image ?? null,
        completionRes.position,
        completionRes.total_today
      );
    } else {
      fetchBlueprintHints(revealCount + 1).then(setHintsData);
    }
  }

  if (modeProgress.completed) {
    return (
      <div className="mode-page">
        <h2>{t("guessTheBlueprint")}</h2>
        <div className="completed-banner">
          <p>{t("alreadyGuessedBlueprint")}</p>
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
        <GuessHistory guesses={modeProgress.guesses} items={blueprints} guessCounts={guessCounts} correctSlug={modeProgress.answeredCorrectSlug} />
      </div>
    );
  }

  return (
    <div className="mode-page">
      <h2>{t("guessTheBlueprint")}</h2>
      <p className="mode-hint">
        {t("blueprintHint")}
      </p>

      {hintsData && (
        <>
          <div className="revealed-name">{hintsData.revealed_name}</div>
          <div className="ingredients-list">
            <p className="ingredients-count">
              {t("showingIngredients", { shown: hintsData.ingredients.length, total: hintsData.total_ingredients })}
            </p>
            {hintsData.ingredients.map((ing) => (
              <IngredientCard
                key={ing.material_slug}
                name={ing.material_name}
                quantity={ing.quantity}
                rarity={ing.material_rarity}
                image={ing.material_image ? `/static/${ing.material_image}` : null}
              />
            ))}
          </div>
        </>
      )}

      <AutocompleteInput
        items={blueprints}
        onSelect={handleGuess}
        disabled={modeProgress.completed}
        placeholder={t("typeItemName")}
        guessedSlugs={modeProgress.guesses}
      />

      <GuessHistory guesses={modeProgress.guesses} items={blueprints} guessCounts={guessCounts} correctSlug={modeProgress.answeredCorrectSlug} />
    </div>
  );
}
