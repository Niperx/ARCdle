import type { GuessCount } from "../types";
import { useI18n } from "../i18n";

interface Props {
  guesses: string[];
  items: { slug: string; name: string; image?: string | null }[];
  guessCounts?: GuessCount[];
  correctSlug?: string | null;
}

export default function GuessHistory({ guesses, items, guessCounts, correctSlug }: Props) {
  const { t } = useI18n();
  if (guesses.length === 0) return null;

  const getItem = (slug: string) => items.find((i) => i.slug === slug);
  const getCount = (slug: string) => guessCounts?.find((c) => c.slug === slug)?.count;

  return (
    <div className="guess-history">
      <h3>{t("guesses")}</h3>
      <ul>
        {[...guesses].reverse().map((slug, i) => {
          const item = getItem(slug);
          const count = getCount(slug);
          const isCorrect = slug === correctSlug;
          return (
            <li key={i} className={`guess-history-item ${isCorrect ? "correct" : "wrong"}`}>
              {item?.image && (
                <img
                  src={`/static/${item.image}`}
                  alt={item?.name ?? slug}
                  className="guess-history-img"
                />
              )}
              <div className="guess-history-info">
                <span className="guess-history-name">{item?.name ?? slug}</span>
              </div>
              {count !== undefined && (
                <span className="guess-history-count">
                  <img src="/static/ui/icons/Icon_Residential.png" alt="" className="guess-history-count-icon" />
                  {count}
                </span>
              )}
            </li>
          );
        })}
      </ul>
    </div>
  );
}
