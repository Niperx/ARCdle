import { useState, useEffect } from "react";
import { fetchRandomBuild, fetchBuildAugments, fetchBuildShields, fetchBuildWeapons, fetchBuildMaps } from "../api/client";
import type { RandomBuild, BuildItem } from "../types";
import { useI18n } from "../i18n";
import SlotReel from "../components/SlotReel";

export default function Build() {
  const [build, setBuild] = useState<RandomBuild | null>(null);
  const [spinning, setSpinning] = useState(false);
  const [, setStoppedCount] = useState(0);
  const { t } = useI18n();

  // Item lists for slot reels
  const [augments, setAugments] = useState<BuildItem[]>([]);
  const [shields, setShields] = useState<BuildItem[]>([]);
  const [weapons, setWeapons] = useState<BuildItem[]>([]);
  const [maps, setMaps] = useState<BuildItem[]>([]);

  useEffect(() => {
    // Preload all item lists
    fetchBuildAugments().then(setAugments);
    fetchBuildShields().then(setShields);
    fetchBuildWeapons().then(setWeapons);
    fetchBuildMaps().then(setMaps);
  }, []);

  async function handleGenerate() {
    setSpinning(true);
    setStoppedCount(0);

    // Fetch the result while spinning (don't clear old build)
    const data = await fetchRandomBuild();
    setBuild(data);
  }

  function handleReelStopped() {
    setStoppedCount((prev) => {
      const next = prev + 1;
      if (next >= 5) {
        setSpinning(false);
      }
      return next;
    });
  }

  const listsLoaded = augments.length > 0 && shields.length > 0 && weapons.length > 0 && maps.length > 0;

  return (
    <div className="mode-page">
      <h2>{t("randomLoadout")}</h2>
      <p className="mode-hint">{t("buildHint")}</p>

      <button
        className="build-generate-btn"
        onClick={handleGenerate}
        disabled={spinning || !listsLoaded}
      >
        {spinning ? t("rolling") : build ? t("reroll") : t("generate")}
      </button>

      {listsLoaded && (
        <div className="slot-machine">
          <div className="slot-row">
            <SlotReel
              items={augments}
              targetItem={build?.augment ?? null}
              spinning={spinning}
              delay={1500}
              label={t("augment")}
              onStopped={handleReelStopped}
            />
            <SlotReel
              items={shields}
              targetItem={build?.shield ?? null}
              spinning={spinning}
              delay={2000}
              label={t("shield")}
              onStopped={handleReelStopped}
            />
          </div>
          <div className="slot-row">
            <SlotReel
              items={weapons}
              targetItem={build?.weapon1 ?? null}
              spinning={spinning}
              delay={2500}
              label={t("weapon") + " 1"}
              wide
              onStopped={handleReelStopped}
            />
            <SlotReel
              items={weapons}
              targetItem={build?.weapon2 ?? null}
              spinning={spinning}
              delay={3000}
              label={t("weapon") + " 2"}
              wide
              onStopped={handleReelStopped}
            />
          </div>
          <div className="slot-row">
            <SlotReel
              items={maps}
              targetItem={build?.map_item ?? null}
              spinning={spinning}
              delay={3500}
              label={t("buildMap")}
              wide
              large
              onStopped={handleReelStopped}
            />
          </div>
        </div>
      )}
    </div>
  );
}
