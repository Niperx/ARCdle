import { useState, useCallback } from "react";
import type { DailyProgress, ModeProgress } from "../types";

const STORAGE_KEY = "arcIdle_progress";

function getTodayUTC(): string {
  return new Date().toISOString().split("T")[0];
}

function freshMode(): ModeProgress {
  return {
    completed: false,
    attempts: 0,
    guesses: [],
    answeredCorrectSlug: null,
    answeredCorrectName: null,
    answeredCorrectImage: null,
    answeredCorrectHqImage: null,
    position: null,
    totalToday: null,
  };
}

function freshProgress(): DailyProgress {
  return {
    date: getTodayUTC(),
    modes: {
      weapon: freshMode(),
      location: freshMode(),
      blueprint: freshMode(),
      sound: freshMode(),
      skill: freshMode(),
    },
  };
}

function loadProgress(): DailyProgress {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return freshProgress();
    const parsed: DailyProgress = JSON.parse(raw);
    if (parsed.date !== getTodayUTC()) return freshProgress();
    // Migrate old data that doesn't have sound mode
    if (!parsed.modes.sound) {
      parsed.modes.sound = freshMode();
    }
    // Migrate old data that doesn't have skill mode
    if (!parsed.modes.skill) {
      parsed.modes.skill = freshMode();
    }
    return parsed;
  } catch {
    return freshProgress();
  }
}

function saveProgress(p: DailyProgress) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(p));
}

type ModeName = "weapon" | "location" | "blueprint" | "sound" | "skill";

export function useLocalProgress() {
  const [progress, setProgress] = useState<DailyProgress>(loadProgress);

  const recordGuess = useCallback((mode: ModeName, slug: string) => {
    setProgress((prev) => {
      const updated = {
        ...prev,
        modes: {
          ...prev.modes,
          [mode]: {
            ...prev.modes[mode],
            attempts: prev.modes[mode].attempts + 1,
            guesses: [...prev.modes[mode].guesses, slug],
          },
        },
      };
      saveProgress(updated);
      return updated;
    });
  }, []);

  const markCompleted = useCallback(
    (
      mode: ModeName,
      slug: string,
      name: string,
      image: string | null,
      hqImage: string | null = null,
      position: number | null = null,
      totalToday: number | null = null
    ) => {
      setProgress((prev) => {
        const updated = {
          ...prev,
          modes: {
            ...prev.modes,
            [mode]: {
              ...prev.modes[mode],
              completed: true,
              answeredCorrectSlug: slug,
              answeredCorrectName: name,
              answeredCorrectImage: image,
              answeredCorrectHqImage: hqImage,
              position,
              totalToday,
            },
          },
        };
        saveProgress(updated);
        return updated;
      });
    },
    []
  );

  return { progress, recordGuess, markCompleted };
}
