import { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { useI18n } from "../i18n";
import AllCompleteModal from "../components/AllCompleteModal";
import type { DailyProgress } from "../types";

interface ModeCardProps {
  title: string;
  description: string;
  to: string;
  completed: boolean;
  icon: string | null;
}

function ModeCard({ title, description, to, completed, icon }: ModeCardProps) {
  const { t } = useI18n();
  return (
    <Link to={to} className={`mode-card ${completed ? "mode-card--done" : ""}`}>
      {icon && <img src={icon} alt="" className="mode-card-icon" />}
      <h2>{title}</h2>
      <p>{description}</p>
      {completed && <span className="mode-card-badge">{t("completed")}</span>}
    </Link>
  );
}

interface Props {
  progress: DailyProgress;
  weaponDone: boolean;
  locationDone: boolean;
  blueprintDone: boolean;
  soundDone: boolean;
  skillDone: boolean;
}

export default function Home({ progress, weaponDone, locationDone, blueprintDone, soundDone, skillDone }: Props) {
  const { t } = useI18n();
  const [showAllCompleteModal, setShowAllCompleteModal] = useState(false);
  const allDone = weaponDone && locationDone && blueprintDone && soundDone && skillDone;

  useEffect(() => {
    if (allDone && !showAllCompleteModal) {
      const wasShown = sessionStorage.getItem("arcIdle_allCompleteShown");
      const today = new Date().toISOString().split("T")[0];
      if (wasShown !== today) {
        setShowAllCompleteModal(true);
        sessionStorage.setItem("arcIdle_allCompleteShown", today);
      }
    }
  }, [allDone, showAllCompleteModal]);

  return (
    <div className="home">
      <h1 className="home-title">{t("dailyChallenges")}</h1>
      <p className="home-subtitle">{t("homeSubtitle")}</p>
      <div className="mode-cards">
        <ModeCard
          title={t("guessTheWeapon")}
          description={t("weaponDesc")}
          to="/weapon"
          completed={weaponDone}
          icon="/static/ui/icons/Ammo_Heavy.png"
        />
        <ModeCard
          title={t("guessTheLocation")}
          description={t("locationDesc")}
          to="/location"
          completed={locationDone}
          icon="/static/ui/icons/Icon_Exodus.png"
        />
        <ModeCard
          title={t("guessTheBlueprint")}
          description={t("blueprintDesc")}
          to="/blueprint"
          completed={blueprintDone}
          icon="/static/ui/icons/Icon_Old_World.png"
        />
        <ModeCard
          title={t("guessTheSound")}
          description={t("soundDesc")}
          to="/sound"
          completed={soundDone}
          icon="/static/ui/icons/Icon_Utility.png"
        />
        <ModeCard
          title={t("guessTheSkill")}
          description={t("skillDesc")}
          to="/skill"
          completed={skillDone}
          icon="/static/ui/icons/Icon_Raider.png"
        />
      </div>
      {allDone && (
        <button
          className="all-complete-trigger"
          onClick={() => setShowAllCompleteModal(true)}
          type="button"
        >
          {t("viewResults")}
        </button>
      )}
      {showAllCompleteModal && allDone && (
        <AllCompleteModal progress={progress} onClose={() => setShowAllCompleteModal(false)} />
      )}
    </div>
  );
}
