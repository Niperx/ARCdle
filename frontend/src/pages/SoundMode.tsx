import { useState, useEffect, useMemo, useRef } from "react";
import { fetchSounds, fetchWeapons, fetchDailySound, fetchSoundGuessCounts, guessSound, recordCompletion, DAILY_SOUND_AUDIO_URL } from "../api/client";
import AutocompleteInput from "../components/AutocompleteInput";
import GuessHistory from "../components/GuessHistory";
import type { SoundListItem, SoundDailyResponse, GuessCount, ModeProgress, WeaponListItem } from "../types";
import { getPlayerId } from "../utils/playerId";
import { useI18n } from "../i18n";

interface Props {
  modeProgress: ModeProgress;
  onGuess: (slug: string) => void;
  onComplete: (slug: string, name: string, image: string | null, hqImage: string | null, position: number | null, totalToday: number | null) => void;
}

export default function SoundMode({ modeProgress, onGuess, onComplete }: Props) {
  const [sounds, setSounds] = useState<SoundListItem[]>([]);
  const [weapons, setWeapons] = useState<WeaponListItem[]>([]);
  const [dailyData, setDailyData] = useState<SoundDailyResponse | null>(null);
  const [guessCounts, setGuessCounts] = useState<GuessCount[]>([]);
  const [isPlaying, setIsPlaying] = useState(false);
  const [volume, setVolume] = useState(0.1);
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const { t } = useI18n();

  useEffect(() => {
    if (audioRef.current) {
      audioRef.current.volume = volume;
    }
  }, [volume]);

  useEffect(() => {
    Promise.all([fetchSounds(), fetchWeapons(), fetchDailySound()]).then(([s, w, d]) => {
      setSounds(s);
      setWeapons(w);
      setDailyData(d);
    });
  }, []);

  const soundByName = useMemo(() => Object.fromEntries(sounds.map((s) => [s.name.toLowerCase(), s])), [sounds]);
  const autocompleteItems = useMemo(
    () =>
      weapons.map((w) => {
        const sound = soundByName[w.name.toLowerCase()];
        return { slug: sound ? sound.slug : w.slug, name: w.name };
      }),
    [weapons, soundByName]
  );
  const historyItems = useMemo(
    () => [...sounds, ...weapons] as { slug: string; name: string; image?: string | null }[],
    [sounds, weapons]
  );

  useEffect(() => {
    if (modeProgress.guesses.length > 0) {
      fetchSoundGuessCounts().then(setGuessCounts);
    }
  }, [modeProgress.guesses.length]);

  function handlePlaySound() {
    if (audioRef.current) {
      if (isPlaying) {
        audioRef.current.pause();
        audioRef.current.currentTime = 0;
        setIsPlaying(false);
      } else {
        audioRef.current.play();
        setIsPlaying(true);
      }
    }
  }

  function handleAudioEnded() {
    setIsPlaying(false);
  }

  async function handleGuess(slug: string) {
    onGuess(slug);
    const res = await guessSound(slug);
    if (res.correct) {
      const attempts = modeProgress.attempts + 1;
      const completionRes = await recordCompletion("sound", getPlayerId(), attempts);
      onComplete(
        res.answer_slug!,
        res.answer_name!,
        res.answer_image ?? null,
        res.answer_hq_image ?? null,
        completionRes.position,
        completionRes.total_today
      );
    }
  }

  if (modeProgress.completed) {
    return (
      <div className="mode-page">
        <h2>{t("guessTheSound")}</h2>
        <div className="completed-banner">
          <p>{t("alreadyGuessedSound")}</p>
          <p className="completed-answer">{modeProgress.answeredCorrectName}</p>
          <div className="sound-player">
            <audio ref={audioRef} src={DAILY_SOUND_AUDIO_URL} onEnded={handleAudioEnded} />
            <div className="volume-slider">
              <input
                type="range"
                min="0"
                max="1"
                step="0.01"
                value={volume}
                onChange={(e) => setVolume(parseFloat(e.target.value))}
              />
              <span className="volume-value">{Math.round(volume * 100)}%</span>
            </div>
            <button className="play-sound-btn" onClick={handlePlaySound}>
              {isPlaying ? t("stopSound") : t("playSound")}
            </button>
          </div>
          {(modeProgress.answeredCorrectHqImage || modeProgress.answeredCorrectImage) && (
            <img src={`/static/${modeProgress.answeredCorrectHqImage || modeProgress.answeredCorrectImage}`} alt={modeProgress.answeredCorrectName ?? ""} className="completed-img" />
          )}
          <p>{t("attempts")}: {modeProgress.attempts}</p>
          {modeProgress.position !== null && (
            <p>{t("youWereNumber", { position: modeProgress.position })}</p>
          )}
        </div>
        <GuessHistory guesses={modeProgress.guesses} items={historyItems} guessCounts={guessCounts} correctSlug={modeProgress.answeredCorrectSlug} />
      </div>
    );
  }

  return (
    <div className="mode-page">
      <h2>{t("guessTheSound")}</h2>
      <p className="mode-hint">
        {t("soundHint")}
      </p>

      {dailyData && (
        <div className="sound-player-container">
          <audio ref={audioRef} src={DAILY_SOUND_AUDIO_URL} onEnded={handleAudioEnded} />
          <div className="volume-slider">
            <input
              type="range"
              min="0"
              max="1"
              step="0.01"
              value={volume}
              onChange={(e) => setVolume(parseFloat(e.target.value))}
            />
            <span className="volume-value">{Math.round(volume * 100)}%</span>
          </div>
          <button className="play-sound-btn play-sound-btn--large" onClick={handlePlaySound}>
            {isPlaying ? t("stopSound") : t("playSound")}
          </button>
          <p className="sound-category">{t("category")}: {dailyData.category}</p>
        </div>
      )}

      <AutocompleteInput
        items={autocompleteItems}
        onSelect={handleGuess}
        disabled={modeProgress.completed}
        placeholder={t("typeSoundName")}
        guessedSlugs={modeProgress.guesses}
      />

      <GuessHistory guesses={modeProgress.guesses} items={sounds} guessCounts={guessCounts} correctSlug={modeProgress.answeredCorrectSlug} />
    </div>
  );
}
