import { useState, useRef, useEffect } from "react";
import { useI18n } from "../i18n";

interface Item {
  slug: string;
  name: string;
}

interface Props {
  items: Item[];
  onSelect: (slug: string) => void;
  disabled?: boolean;
  placeholder?: string;
  guessedSlugs?: string[];
}

export default function AutocompleteInput({ items, onSelect, disabled, placeholder, guessedSlugs = [] }: Props) {
  const [query, setQuery] = useState("");
  const [open, setOpen] = useState(false);
  const [highlightIdx, setHighlightIdx] = useState(0);
  const wrapperRef = useRef<HTMLDivElement>(null);
  const { t } = useI18n();

  const filtered = query.length > 0
    ? items
        .filter((it) => it.name.toLowerCase().includes(query.toLowerCase()))
        .filter((it) => !guessedSlugs.includes(it.slug))
        .slice(0, 8)
    : [];

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (wrapperRef.current && !wrapperRef.current.contains(e.target as Node)) {
        setOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  function handleKeyDown(e: React.KeyboardEvent) {
    if (e.key === "ArrowDown") {
      e.preventDefault();
      setHighlightIdx((prev) => Math.min(prev + 1, filtered.length - 1));
    } else if (e.key === "ArrowUp") {
      e.preventDefault();
      setHighlightIdx((prev) => Math.max(prev - 1, 0));
    } else if (e.key === "Enter" && filtered.length > 0) {
      e.preventDefault();
      select(filtered[highlightIdx].slug);
    } else if (e.key === "Escape") {
      setOpen(false);
    }
  }

  function select(slug: string) {
    setQuery("");
    setOpen(false);
    setHighlightIdx(0);
    onSelect(slug);
  }

  return (
    <div className="autocomplete" ref={wrapperRef}>
      <input
        type="text"
        value={query}
        onChange={(e) => {
          setQuery(e.target.value);
          setOpen(true);
          setHighlightIdx(0);
        }}
        onFocus={() => query.length > 0 && setOpen(true)}
        onKeyDown={handleKeyDown}
        disabled={disabled}
        placeholder={placeholder || t("typeToSearch")}
        className="autocomplete-input"
      />
      {open && filtered.length > 0 && (
        <ul className="autocomplete-dropdown">
          {filtered.map((item, i) => (
            <li
              key={item.slug}
              className={`autocomplete-item ${i === highlightIdx ? "highlighted" : ""}`}
              onMouseEnter={() => setHighlightIdx(i)}
              onMouseDown={() => select(item.slug)}
            >
              {item.name}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
