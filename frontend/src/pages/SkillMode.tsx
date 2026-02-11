import { useState, useEffect } from "react";
import { fetchSkillTree, fetchDailySkill, fetchSkillGuessCounts, guessSkill, recordCompletion } from "../api/client";
import SkillTree from "../components/SkillTree";
import type { SkillTreeNode, SkillDailyResponse, GuessCount, ModeProgress } from "../types";
import { getPlayerId } from "../utils/playerId";
import { useI18n } from "../i18n";

interface Props {
  modeProgress: ModeProgress;
  onGuess: (skill_id: string) => void;
  onComplete: (slug: string, name: string, image: string | null, hqImage: string | null, position: number | null, totalToday: number | null) => void;
}

export default function SkillMode({ modeProgress, onGuess, onComplete }: Props) {
  const [treeNodes, setTreeNodes] = useState<SkillTreeNode[]>([]);
  const [dailyData, setDailyData] = useState<SkillDailyResponse | null>(null);
  const [, setGuessCounts] = useState<GuessCount[]>([]);
  const { t, lang } = useI18n();

  useEffect(() => {
    fetchSkillTree().then(setTreeNodes);
    fetchDailySkill().then(setDailyData);
  }, []);

  useEffect(() => {
    if (modeProgress.guesses.length > 0) {
      fetchSkillGuessCounts().then(setGuessCounts);
    }
  }, [modeProgress.guesses.length]);

  async function handleNodeClick(skill_id: string) {
    // Don't allow clicking the same node twice
    if (modeProgress.guesses.includes(skill_id)) return;

    onGuess(skill_id);
    const res = await guessSkill(skill_id);
    if (res.correct) {
      const attempts = modeProgress.attempts + 1;
      const completionRes = await recordCompletion("skill", getPlayerId(), attempts);
      onComplete(
        res.answer_slug!,
        res.answer_name!,
        null,  // Skills don't have images
        null,
        completionRes.position,
        completionRes.total_today
      );
    }
  }

  const description = dailyData
    ? (lang === "ru" ? dailyData.description_ru : dailyData.description_en)
    : "";

  const branchLabel = dailyData?.category
    ? t(`branch_${dailyData.category}` as import("../i18n").TranslationKey)
    : "";

  if (modeProgress.completed) {
    return (
      <div className="mode-page">
        <h2>{t("guessTheSkill")}</h2>
        <div className="completed-banner">
          <p>{t("alreadyGuessedSkill")}</p>
          <p className="completed-answer">{modeProgress.answeredCorrectName}</p>
          <p className="mode-hint">{t("attempts")}: {modeProgress.attempts}</p>
          {modeProgress.position !== null && (
            <p>{t("youWereNumber", { position: modeProgress.position })}</p>
          )}
        </div>

        <SkillTree
          nodes={treeNodes}
          wrongGuesses={modeProgress.guesses.filter(g => g !== modeProgress.answeredCorrectSlug)}
          onNodeClick={() => {}}
          disabled={true}
          correctSlug={modeProgress.answeredCorrectSlug}
        />
      </div>
    );
  }

  return (
    <div className="mode-page">
      <h2>{t("guessTheSkill")}</h2>
      <p className="mode-hint">{t("skillHint")}</p>

      {dailyData && (
        <div className="skill-description-card">
          <p className="skill-description">{description}</p>
          {modeProgress.attempts >= 5 && (
            <p className="skill-branch-hint">
              {t("branch")}: <span className={`branch-${dailyData.category}`}>{branchLabel}</span>
            </p>
          )}
        </div>
      )}

      <SkillTree
        nodes={treeNodes}
        wrongGuesses={modeProgress.guesses}
        onNodeClick={handleNodeClick}
        disabled={modeProgress.completed}
        correctSlug={null}
      />

      {modeProgress.attempts > 0 && (
        <div className="skill-attempts">
          <p>{t("wrongAttempts")}: {modeProgress.attempts}</p>
        </div>
      )}
    </div>
  );
}
