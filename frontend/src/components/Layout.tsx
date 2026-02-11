import { useState } from "react";
import { NavLink, Outlet, Link, useLocation } from "react-router-dom";
import type { DailyProgress } from "../types";
import { useI18n } from "../i18n";

const MODE_ICONS = [
  { mode: "weapon", path: "/weapon", icon: "/static/ui/icons/Ammo_Heavy.png" },
  { mode: "location", path: "/location", icon: "/static/ui/icons/Icon_Exodus.png" },
  { mode: "blueprint", path: "/blueprint", icon: "/static/ui/icons/Icon_Old_World.png" },
  { mode: "sound", path: "/sound", icon: "/static/ui/icons/Icon_Utility.png" },
  { mode: "skill", path: "/skill", icon: "/static/ui/icons/Icon_Raider.png" },
] as const;

interface Props {
  progress: DailyProgress;
}

export default function Layout({ progress }: Props) {
  const location = useLocation();
  const currentPath = location.pathname;
  const isModePage = MODE_ICONS.some((m) => currentPath === m.path);
  const { lang, setLang, t } = useI18n();
  const [showAbout, setShowAbout] = useState(false);

  return (
    <div className="app">
      <header className="header">
        <nav className="nav nav--left">
          <NavLink to="/" end>{t("home")}</NavLink>
          <NavLink to="/run">{t("run")}</NavLink>
          <NavLink to="/favorite">{t("favorite")}</NavLink>
          <NavLink to="/build">{t("build")}</NavLink>
        </nav>
        <div className="header-right">
          <button
            type="button"
            className="lang-toggle"
            onClick={() => setLang(lang === "en" ? "ru" : "en")}
          >
            {lang === "en" ? "EN" : "RU"}
          </button>
          <button
            type="button"
            className="about-btn"
            onClick={() => setShowAbout(true)}
            aria-label={t("aboutSite")}
          >
            <img src="/static/ui/icons/Icon_Trinket.png" alt="" aria-hidden />
          </button>
        </div>
      </header>

      <Link to="/" className="logo-block">
        <img src="/a.svg" alt="A" className="logo-letter" />
        <img src="/r.svg" alt="R" className="logo-letter" />
        <img src="/c.svg" alt="C" className="logo-letter" />
      </Link>

      {isModePage && (
        <div className="mode-icons-bar">
          {MODE_ICONS.map((m) => {
            const modeProgress = progress.modes[m.mode as keyof typeof progress.modes];
            const isActive = currentPath === m.path;
            const isDone = modeProgress.completed;

            let statusClass = "mode-icon--idle";
            if (isActive && !isDone) statusClass = "mode-icon--active";
            if (isDone) statusClass = "mode-icon--done";

            return (
              <Link key={m.mode} to={m.path} className={`mode-icon ${statusClass}`}>
                <img src={m.icon} alt={m.mode} />
              </Link>
            );
          })}
        </div>
      )}

      <main className="main">
        <Outlet />
      </main>

      {showAbout && (
        <div className="app-modal-overlay" role="dialog" aria-modal="true">
          <div className="app-modal">
            <h2 className="app-modal-title">{t("aboutTitle")}</h2>

            <p className="app-modal-text">{t("aboutIntro1")}</p>
            <p className="app-modal-text">{t("aboutIntro2")}</p>

            <div className="app-modal-separator" />

            <h3 className="app-modal-subtitle">{t("aboutModesTitle")}</h3>
            <ul className="app-modal-list">
              <li>{t("aboutModeWeapon")}</li>
              <li>{t("aboutModeLocation")}</li>
              <li>{t("aboutModeBlueprint")}</li>
              <li>{t("aboutModeSound")}</li>
              <li>{t("aboutModeSkill")}</li>
            </ul>

            <div className="app-modal-separator" />

            <h3 className="app-modal-subtitle">{t("aboutMiniTitle")}</h3>
            <ul className="app-modal-list">
              <li>{t("aboutMiniRun")}</li>
              <li>{t("aboutMiniFavorite")}</li>
              <li>{t("aboutMiniBuild")}</li>
            </ul>

            <div className="app-modal-separator" />

            <h3 className="app-modal-subtitle">{t("aboutFaqTitle")}</h3>
            <div className="app-modal-faq-item">
              <p className="app-modal-faq-q">{t("aboutFaqQ1")}</p>
              <p className="app-modal-faq-a">{t("aboutFaqA1")}</p>
            </div>
            <div className="app-modal-faq-item">
              <p className="app-modal-faq-q">{t("aboutFaqQ2")}</p>
              <p className="app-modal-faq-a">{t("aboutFaqA2")}</p>
            </div>
            <div className="app-modal-faq-item">
              <p className="app-modal-faq-q">{t("aboutFaqQ3")}</p>
              <p className="app-modal-faq-a">{t("aboutFaqA3")}</p>
            </div>

            <p className="app-modal-text app-modal-disclaimer">{t("aboutDisclaimer")}</p>
            <p className="app-modal-text app-modal-urls">{t("aboutUrls")}</p>

            <button
              type="button"
              className="app-modal-close"
              onClick={() => setShowAbout(false)}
            >
              {t("close")}
            </button>
          </div>
        </div>
      )}

      <footer className="app-footer">
        <p>{t("footerCopyright")}</p>
        <p className="app-footer-site">ARCdle.online © 2026</p>
      </footer>
    </div>
  );
}
