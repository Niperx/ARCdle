import { useState, useEffect, useCallback } from "react";
import {
  fetchRunMaps,
  fetchRunTexts,
  fetchRunLeaderboard,
  saveRunScore,
  recordRunPlay,
  type RunMap,
  type RunTexts,
  type LeaderboardEntry,
} from "../api/client";
import { useI18n } from "../i18n";
import { getPlayerId } from "../utils/playerId";
import MapWithExits from "../components/MapWithExits";

type Phase = "playing" | "success" | "failure" | "save" | "saved";

function pickTwoSuccessIndices(exitCount: number): [number, number] {
  const a = Math.floor(Math.random() * exitCount);
  let b = Math.floor(Math.random() * exitCount);
  while (b === a) b = Math.floor(Math.random() * exitCount);
  return [a, b];
}

function pickRandomMap(maps: RunMap[]): RunMap {
  return maps[Math.floor(Math.random() * maps.length)];
}

const RAID_PAYOUT = {
  normal: { min: 30_000, max: 70_000, chance: 0.6 },
  good: { min: 70_000, max: 100_000, chance: 0.3 },
  very: { min: 100_000, max: 115_000, chance: 0.1 },
} as const;

function rollRaidPayout(): number {
  const r = Math.random();
  let tier: keyof typeof RAID_PAYOUT = "normal";
  if (r < RAID_PAYOUT.normal.chance) tier = "normal";
  else if (r < RAID_PAYOUT.normal.chance + RAID_PAYOUT.good.chance) tier = "good";
  else tier = "very";
  const { min, max } = RAID_PAYOUT[tier];
  return min + Math.floor(Math.random() * (max - min + 1));
}

function formatCurrency(n: number): string {
  return n.toLocaleString("en-US").replace(/,/g, " ");
}

const SPACE_DOLLAR_ICON = "/static/ui/icons/Space_Dollar.png";
const COIN_FLIP_ICONS = ["/static/ui/icons/Space_Dollar.png", "/static/ui/icons/Raider_Token.png"] as const;
const RUN_RECORD_KEY = "arcdle_run_record";

function pickRandomCoinIcon(): string {
  return COIN_FLIP_ICONS[Math.floor(Math.random() * COIN_FLIP_ICONS.length)];
}

interface RunRecord {
  currency: number;
  exitsCount: number;
}

function loadRunRecord(): RunRecord | null {
  try {
    const raw = localStorage.getItem(RUN_RECORD_KEY);
    if (!raw) return null;
    const data = JSON.parse(raw) as RunRecord;
    return typeof data.currency === "number" && typeof data.exitsCount === "number" ? data : null;
  } catch {
    return null;
  }
}

export default function RunPage() {
  const { t, lang } = useI18n();
  const [maps, setMaps] = useState<RunMap[]>([]);
  const [texts, setTexts] = useState<RunTexts | null>(null);
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([]);
  const [score, setScore] = useState(0);
  const [successfulExitsInRun, setSuccessfulExitsInRun] = useState(0);
  const [currentMap, setCurrentMap] = useState<RunMap | null>(null);
  const [successIndices, setSuccessIndices] = useState<Set<number>>(new Set());
  const [phase, setPhase] = useState<Phase>("playing");
  const [resultText, setResultText] = useState("");
  const [lastPayout, setLastPayout] = useState(0);
  const [nicknameInput, setNicknameInput] = useState("");
  const [saving, setSaving] = useState(false);
  const [record, setRecord] = useState<RunRecord | null>(() => loadRunRecord());
  const [pendingExitIndex, setPendingExitIndex] = useState<number | null>(null);
  const [flipCoinIcon, setFlipCoinIcon] = useState<string | null>(null);

  const startNewMap = useCallback((resetRunProgress = true) => {
    if (maps.length === 0) return;
    if (resetRunProgress) {
      setScore(0);
      setSuccessfulExitsInRun(0);
    }
    const map = pickRandomMap(maps);
    setCurrentMap(map);
    const exitCount = map.exit_positions.length;
    const [a, b] = pickTwoSuccessIndices(exitCount);
    setSuccessIndices(new Set([a, b]));
    setPhase("playing");
  }, [maps]);

  useEffect(() => {
    fetchRunMaps().then(setMaps);
    fetchRunTexts().then(setTexts);
    fetchRunLeaderboard(20).then(setLeaderboard);
  }, []);

  useEffect(() => {
    if (maps.length > 0 && !currentMap) startNewMap();
  }, [maps, currentMap, startNewMap]);

  function applyExitResult(index: number) {
    if (!texts || !currentMap) return;
    const exitType = currentMap.exit_type ?? "surface";
    const isSuccess = successIndices.has(index);
    const key = `${exitType}_${isSuccess ? "success" : "failure"}`;
    const arr = texts[key as keyof RunTexts];
    const textArr = Array.isArray(arr) ? arr : [];
    const text = textArr.length > 0 ? textArr[Math.floor(Math.random() * textArr.length)] : (isSuccess ? "You made it out!" : "You didn't make it.");
    setResultText(text);
    recordRunPlay(getPlayerId()).catch(() => {});
    if (isSuccess) {
      const payout = rollRaidPayout();
      setLastPayout(payout);
      setScore((s) => s + payout);
      setSuccessfulExitsInRun((n) => n + 1);
      setPhase("success");
    } else {
      setScore(0);
      setSuccessfulExitsInRun(0);
      setPhase("failure");
    }
  }

  function handleExitClick(index: number) {
    if (phase !== "playing" || !texts || !currentMap) return;
    setPendingExitIndex(index);
    setFlipCoinIcon(pickRandomCoinIcon());
  }

  useEffect(() => {
    if (pendingExitIndex === null) return;
    const duration = 2000 + Math.floor(Math.random() * 1000);
    const t = setTimeout(() => {
      applyExitResult(pendingExitIndex);
      setPendingExitIndex(null);
      setFlipCoinIcon(null);
    }, duration);
    return () => clearTimeout(t);
  }, [pendingExitIndex]);

  function handleContinue() {
    startNewMap(false);
  }

  function handleSaveClick() {
    setPhase("save");
    setNicknameInput("");
  }

  async function handleSubmitSave() {
    if (saving) return;
    setSaving(true);
    try {
      await saveRunScore(score, nicknameInput.trim() || null, lang as "en" | "ru");
      const newRecord: RunRecord = { currency: score, exitsCount: successfulExitsInRun };
      const prev = loadRunRecord();
      if (!prev || score > prev.currency) {
        localStorage.setItem(RUN_RECORD_KEY, JSON.stringify(newRecord));
        setRecord(newRecord);
      }
      const updated = await fetchRunLeaderboard(20);
      setLeaderboard(updated);
      setPhase("saved");
    } finally {
      setSaving(false);
    }
  }

  function handleTryAgain() {
    startNewMap(true);
  }

  const showResultModal = phase === "success" || phase === "failure";
  const showSaveForm = phase === "save";
  const showSaved = phase === "saved";

  return (
    <div className="mode-page run-page">
      <h2>{t("runTitle")}</h2>
      <p className="mode-hint">{t("runHint")}</p>

      <div className="run-record-block">
        <div className="run-record-label">{t("runYourRecord")}</div>
        <div className="run-record-value">
          {record ? (
            <>
              {record.exitsCount} {t("runExitsCount")} — {formatCurrency(record.currency)}
              <img src={SPACE_DOLLAR_ICON} alt="" className="run-currency-icon" aria-hidden />
            </>
          ) : (
            <span className="run-record-empty">{t("runNoRecord")}</span>
          )}
        </div>
      </div>

      <div className="run-score-bar">
        <strong>{formatCurrency(score)}</strong>
        <img src={SPACE_DOLLAR_ICON} alt="" className="run-currency-icon" aria-hidden />
      </div>

      {pendingExitIndex !== null && flipCoinIcon && (
        <div className="run-coin-flip-overlay" aria-live="polite">
          <div className="run-coin-flip-coin-wrap">
            <img src={flipCoinIcon} alt="" className="run-coin-flip-coin" />
          </div>
        </div>
      )}

      {currentMap && phase === "playing" && (
        <MapWithExits
          imageUrl={currentMap.image}
          exitPositions={currentMap.exit_positions}
          imageWidth={currentMap.image_width}
          imageHeight={currentMap.image_height}
          crop={currentMap.crop}
          onExitClick={handleExitClick}
        />
      )}

      {showResultModal && (
        <div className="run-result-modal-overlay" role="dialog">
          <div className="run-result-modal">
            <p className="run-result-text">{resultText}</p>
            {phase === "success" && (
              <p className="run-result-score">
                +{formatCurrency(lastPayout)}
                <img src={SPACE_DOLLAR_ICON} alt="" className="run-currency-icon" aria-hidden />
                {" · "}{t("runTotal")}: {formatCurrency(score)}
                <img src={SPACE_DOLLAR_ICON} alt="" className="run-currency-icon" aria-hidden />
              </p>
            )}
            <div className="run-result-actions">
              {phase === "success" && (
                <>
                  <button type="button" className="run-btn run-btn--primary" onClick={handleSaveClick}>
                    {t("runSaveScore")}
                  </button>
                  <button type="button" className="run-btn" onClick={handleContinue}>
                    {t("runContinue")}
                  </button>
                </>
              )}
              {phase === "failure" && (
                <button type="button" className="run-btn run-btn--primary" onClick={handleTryAgain}>
                  {t("runTryAgain")}
                </button>
              )}
            </div>
          </div>
        </div>
      )}

      {showSaveForm && (
        <div className="run-result-modal-overlay" role="dialog">
          <div className="run-result-modal run-save-form">
            <h3>{t("runSaveScore")}</h3>
            <p className="run-result-score">
              {formatCurrency(score)}
              <img src={SPACE_DOLLAR_ICON} alt="" className="run-currency-icon" aria-hidden />
            </p>
            <input
              type="text"
              className="run-nickname-input"
              placeholder={t("runNicknamePlaceholder")}
              value={nicknameInput}
              onChange={(e) => setNicknameInput(e.target.value)}
              maxLength={64}
            />
            <div className="run-result-actions">
              <button
                type="button"
                className="run-btn run-btn--primary"
                onClick={handleSubmitSave}
                disabled={saving}
              >
                {saving ? t("runSaving") : t("runSave")}
              </button>
              <button type="button" className="run-btn" onClick={handleContinue}>
                {t("runContinue")}
              </button>
            </div>
          </div>
        </div>
      )}

      {showSaved && (
        <div className="run-result-modal-overlay" role="dialog">
          <div className="run-result-modal">
            <p className="run-saved-message">{t("runSaved")}</p>
            <button
              type="button"
              className="run-btn run-btn--primary"
              onClick={() => startNewMap(true)}
            >
              {t("runContinue")}
            </button>
          </div>
        </div>
      )}

      <section className="run-leaderboard">
        <h3>{t("runLeaderboard")}</h3>
        <ol className="run-leaderboard-list">
          {leaderboard.map((entry, i) => (
            <li key={i} className="run-leaderboard-row">
              <span className="run-leaderboard-rank">{i + 1}.</span>
              <span className="run-leaderboard-nickname">{entry.nickname}</span>
              <span className="run-leaderboard-score">
                {formatCurrency(entry.score)}
                <img src={SPACE_DOLLAR_ICON} alt="" className="run-currency-icon" aria-hidden />
              </span>
            </li>
          ))}
        </ol>
      </section>
    </div>
  );
}
