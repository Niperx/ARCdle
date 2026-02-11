import { useState, useCallback, useEffect } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Layout from "./components/Layout";
import Home from "./pages/Home";
import WeaponMode from "./pages/WeaponMode";
import LocationMode from "./pages/LocationMode";
import BlueprintMode from "./pages/BlueprintMode";
import SoundMode from "./pages/SoundMode";
import SkillMode from "./pages/SkillMode";
import Build from "./pages/Build";
import RunPage from "./pages/RunPage";
import FavoritePage from "./pages/FavoritePage";
import Stats from "./pages/Stats";
import CelebrationOverlay from "./components/CelebrationOverlay";
import { useLocalProgress } from "./hooks/useLocalProgress";
import { recordVisit } from "./api/client";
import { getPlayerId } from "./utils/playerId";
import "./styles/global.css";

function App() {
  const { progress, recordGuess, markCompleted } = useLocalProgress();
  const [celebrateTrigger, setCelebrateTrigger] = useState(false);

  useEffect(() => {
    recordVisit(getPlayerId()).catch(() => {});
  }, []);

  const handleComplete = useCallback(
    (
      mode: "weapon" | "location" | "blueprint" | "sound" | "skill",
      slug: string,
      name: string,
      image: string | null,
      hqImage: string | null,
      position: number | null,
      totalToday: number | null
    ) => {
      markCompleted(mode, slug, name, image, hqImage, position, totalToday);
      setCelebrateTrigger(true);
    },
    [markCompleted]
  );

  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route element={<Layout progress={progress} />}>
            <Route
              index
              element={
                <Home
                  progress={progress}
                  weaponDone={progress.modes.weapon.completed}
                  locationDone={progress.modes.location.completed}
                  blueprintDone={progress.modes.blueprint.completed}
                  soundDone={progress.modes.sound.completed}
                  skillDone={progress.modes.skill.completed}
                />
              }
            />
          <Route
            path="weapon"
            element={
              <WeaponMode
                modeProgress={progress.modes.weapon}
                onGuess={(slug) => recordGuess("weapon", slug)}
                onComplete={(slug, name, image, hqImage, position, totalToday) => handleComplete("weapon", slug, name, image, hqImage, position, totalToday)}
              />
            }
          />
          <Route
            path="location"
            element={
              <LocationMode
                modeProgress={progress.modes.location}
                onGuess={(slug) => recordGuess("location", slug)}
                onComplete={(slug, name, image, hqImage, position, totalToday) => handleComplete("location", slug, name, image, hqImage, position, totalToday)}
              />
            }
          />
          <Route
            path="blueprint"
            element={
              <BlueprintMode
                modeProgress={progress.modes.blueprint}
                onGuess={(slug) => recordGuess("blueprint", slug)}
                onComplete={(slug, name, image, hqImage, position, totalToday) => handleComplete("blueprint", slug, name, image, hqImage, position, totalToday)}
              />
            }
          />
          <Route
            path="sound"
            element={
              <SoundMode
                modeProgress={progress.modes.sound}
                onGuess={(slug) => recordGuess("sound", slug)}
                onComplete={(slug, name, image, hqImage, position, totalToday) => handleComplete("sound", slug, name, image, hqImage, position, totalToday)}
              />
            }
          />
          <Route
            path="skill"
            element={
              <SkillMode
                modeProgress={progress.modes.skill}
                onGuess={(skill_id) => recordGuess("skill", skill_id)}
                onComplete={(slug, name, image, hqImage, position, totalToday) => handleComplete("skill", slug, name, image, hqImage, position, totalToday)}
              />
            }
          />
          <Route path="build" element={<Build />} />
          <Route path="run" element={<RunPage />} />
          <Route path="favorite" element={<FavoritePage />} />
          <Route path="stats" element={<Stats />} />
        </Route>
      </Routes>
    </BrowserRouter>
    <CelebrationOverlay show={celebrateTrigger} onEnd={() => setCelebrateTrigger(false)} />
    </>
  );
}

export default App;
