import { createContext, useContext, useState, useEffect, type ReactNode } from "react";
import { translations, type Language, type TranslationKey } from "./translations";

const STORAGE_KEY = "arcIdle_language";

interface I18nContextValue {
  lang: Language;
  setLang: (lang: Language) => void;
  t: (key: TranslationKey, params?: Record<string, string | number>) => string;
}

const I18nContext = createContext<I18nContextValue | null>(null);

export function I18nProvider({ children }: { children: ReactNode }) {
  const [lang, setLangState] = useState<Language>(() => {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved === "en" || saved === "ru") return saved;
    // Auto-detect from browser
    const browserLang = navigator.language.toLowerCase();
    if (browserLang.startsWith("ru")) return "ru";
    return "en";
  });

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, lang);
  }, [lang]);

  function setLang(newLang: Language) {
    setLangState(newLang);
  }

  function t(key: TranslationKey, params?: Record<string, string | number>): string {
    let text: string = String(translations[lang][key] || translations.en[key] || key);
    if (params) {
      Object.entries(params).forEach(([k, v]) => {
        text = text.replace(`{${k}}`, String(v));
      });
    }
    return text;
  }

  return (
    <I18nContext.Provider value={{ lang, setLang, t }}>
      {children}
    </I18nContext.Provider>
  );
}

export function useI18n() {
  const ctx = useContext(I18nContext);
  if (!ctx) throw new Error("useI18n must be used within I18nProvider");
  return ctx;
}
