import { useState, useEffect, useCallback } from "react";
import {
  fetchFavoriteCategory,
  fetchFavoriteItems,
  fetchFavoriteStatus,
  submitFavoriteVote,
  fetchFavoriteResults,
  type FavoriteItem,
  type FavoriteResults,
} from "../api/client";
import { useI18n } from "../i18n";
import { getPlayerId } from "../utils/playerId";

function shuffle<T>(arr: T[]): T[] {
  const out = [...arr];
  for (let i = out.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [out[i], out[j]] = [out[j], out[i]];
  }
  return out;
}

export default function FavoritePage() {
  const { t } = useI18n();
  const [category, setCategory] = useState<string>("arc");
  const [champion, setChampion] = useState<FavoriteItem | null>(null);
  const [challenger, setChallenger] = useState<FavoriteItem | null>(null);
  const [pool, setPool] = useState<FavoriteItem[]>([]);
  const [phase, setPhase] = useState<"loading" | "voting" | "submitting" | "results" | "already_voted">("loading");
  const [winner, setWinner] = useState<FavoriteItem | null>(null);
  const [results, setResults] = useState<FavoriteResults | null>(null);
  const [userFavoriteSlug, setUserFavoriteSlug] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const initVoting = useCallback((list: FavoriteItem[]) => {
    if (list.length < 2) {
      setError("Not enough items");
      return;
    }
    const shuffled = shuffle(list);
    setChampion(shuffled[0]);
    setChallenger(shuffled[1]);
    setPool(shuffled.slice(2));
    setPhase("voting");
  }, []);

  useEffect(() => {
    const playerId = getPlayerId();
    Promise.all([
      fetchFavoriteCategory(),
      fetchFavoriteItems("arc"),
      fetchFavoriteStatus("arc", playerId),
    ])
      .then(async ([catRes, list, status]) => {
        setCategory(catRes.category);
        if (status.has_voted && status.favorite_slug) {
          setUserFavoriteSlug(status.favorite_slug);
          setPhase("already_voted");
          const res = await fetchFavoriteResults(catRes.category);
          setResults(res);
        } else {
          initVoting(list);
        }
      })
      .catch(() => setError("Failed to load"));
  }, [initVoting]);

  function handlePick(picked: FavoriteItem) {
    if (phase !== "voting" || !champion || !challenger) return;
    const nextChallenger = pool[0];
    if (!nextChallenger) {
      setWinner(picked);
      setPhase("submitting");
      const playerId = getPlayerId();
      submitFavoriteVote(category, picked.slug, playerId)
        .then(() => fetchFavoriteResults(category))
        .then(setResults)
        .then(() => setPhase("results"))
        .catch(() => setPhase("results"));
      return;
    }
    setChampion(picked);
    setChallenger(nextChallenger);
    setPool((p) => p.slice(1));
  }

  if (error) {
    return (
      <div className="mode-page">
        <h2>{t("favoriteTitle")}</h2>
        <p className="mode-hint">{error}</p>
      </div>
    );
  }

  if (phase === "loading") {
    return (
      <div className="mode-page">
        <h2>{t("favoriteTitle")}</h2>
        <p className="mode-hint">{t("loading")}</p>
      </div>
    );
  }

  function renderCommunityStats(res: FavoriteResults) {
    const top3 = res.results.slice(0, 3);
    const rest = res.results.slice(3);
    return (
      <>
        <h3 className="favorite-stats-title">{t("favoriteCommunityPick")}</h3>
        <div className="favorite-top-three">
          {top3.map((r) => {
            const item = res.items[r.slug];
            return item ? (
              <div key={r.slug} className="favorite-top-item">
                <img src={item.image} alt={item.name} />
                <span>{item.name}</span>
                <span className="favorite-result-percent">{r.percent}%</span>
              </div>
            ) : null;
          })}
        </div>
        {rest.length > 0 && (
          <ul className="favorite-rest-list">
            {rest.map((r) => {
              const item = res.items[r.slug];
              return item ? (
                <li key={r.slug}>
                  <span>{item.name}</span>
                  <span className="favorite-rest-percent">{r.percent}%</span>
                </li>
              ) : null;
            })}
          </ul>
        )}
        <p className="favorite-result-total">
          {t("favoriteTotalVotes", { count: res.total_votes })}
        </p>
      </>
    );
  }

  if (phase === "already_voted" && results && userFavoriteSlug) {
    const userItem = results.items[userFavoriteSlug];
    const userPercent = results.results.find((r) => r.slug === userFavoriteSlug)?.percent ?? 0;
    return (
      <div className="mode-page">
        <h2>{t("favoriteTitle")}</h2>
        <p className="mode-hint">{t("favoriteHint")}</p>

        <div className="favorite-result-block">
          <h3>{t("favoriteYourPick")}</h3>
          {userItem && (
            <div className="favorite-result-winner">
              <img src={userItem.image} alt={userItem.name} />
              <span>{userItem.name}</span>
            </div>
          )}
          <p className="favorite-result-percent">
            {t("favoritePercentChose", { percent: userPercent })}
          </p>
          {renderCommunityStats(results)}
        </div>
      </div>
    );
  }

  if (phase === "results" || phase === "submitting") {
    const winnerPercent = results?.results.find((r) => r.slug === winner?.slug)?.percent ?? 0;
    return (
      <div className="mode-page">
        <h2>{t("favoriteTitle")}</h2>
        <p className="mode-hint">{t("favoriteHint")}</p>

        <div className="favorite-result-block">
          <h3>{t("favoriteYourPick")}</h3>
          {winner && (
            <div className="favorite-result-winner">
              <img src={winner.image} alt={winner.name} />
              <span>{winner.name}</span>
            </div>
          )}
          {phase === "results" && results && (
            <>
              <p className="favorite-result-percent">
                {t("favoritePercentChose", { percent: winnerPercent })}
              </p>
              {renderCommunityStats(results)}
            </>
          )}
          {phase === "submitting" && <p>{t("loading")}</p>}
        </div>
      </div>
    );
  }

  return (
    <div className="mode-page">
      <h2>{t("favoriteTitle")}</h2>
      <p className="mode-hint">{t("favoriteHint")}</p>

      <div className="favorite-vs-block">
        <p className="favorite-vs-label">{t("favoritePickBetter")}</p>
        <div className="favorite-cards">
          {champion && (
            <button
              type="button"
              className="favorite-card favorite-card--left"
              onClick={() => handlePick(champion)}
            >
              <img src={champion.image} alt={champion.name} />
              <span>{champion.name}</span>
            </button>
          )}
          <span className="favorite-vs-sep">vs</span>
          {challenger && (
            <button
              type="button"
              className="favorite-card favorite-card--right"
              onClick={() => handlePick(challenger)}
            >
              <img src={challenger.image} alt={challenger.name} />
              <span>{challenger.name}</span>
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
