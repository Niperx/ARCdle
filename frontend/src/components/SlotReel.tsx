import { useEffect, useRef, useState } from "react";
import type { BuildItem } from "../types";

interface Props {
  items: BuildItem[];
  targetItem: BuildItem | null;
  spinning: boolean;
  delay: number;
  label: string;
  wide?: boolean;
  large?: boolean;
  onStopped?: () => void;
}

const SPIN_SPEED = 70;

export default function SlotReel({ items, targetItem, spinning, delay, label, wide, large, onStopped }: Props) {
  const [currentIdx, setCurrentIdx] = useState(0);
  const [showResult, setShowResult] = useState(false);
  const [isActive, setIsActive] = useState(false);

  const targetItemRef = useRef(targetItem);
  const onStoppedRef = useRef(onStopped);
  const wasSpinningRef = useRef(false);
  const currentIdxRef = useRef(currentIdx);

  useEffect(() => { targetItemRef.current = targetItem; }, [targetItem]);
  useEffect(() => { onStoppedRef.current = onStopped; }, [onStopped]);
  useEffect(() => { currentIdxRef.current = currentIdx; }, [currentIdx]);

  useEffect(() => {
    // Detect rising edge of spinning (false -> true)
    if (spinning && !wasSpinningRef.current && items.length > 0) {
      wasSpinningRef.current = true;
      setIsActive(true);
      setShowResult(false);

      let idx = currentIdxRef.current;
      const interval = setInterval(() => {
        idx = (idx + 1) % items.length;
        setCurrentIdx(idx);
      }, SPIN_SPEED);

      const stopTimer = setTimeout(() => {
        clearInterval(interval);

        const target = targetItemRef.current;
        if (!target) {
          setIsActive(false);
          setShowResult(true);
          onStoppedRef.current?.();
          return;
        }

        const targetIdx = items.findIndex((it) => it.slug === target.slug);
        if (targetIdx === -1) {
          setIsActive(false);
          setShowResult(true);
          onStoppedRef.current?.();
          return;
        }

        // Slowdown
        let speed = SPIN_SPEED;
        let passedTarget = false;

        const step = () => {
          idx = (idx + 1) % items.length;
          setCurrentIdx(idx);

          if (idx === targetIdx && passedTarget && speed >= 200) {
            setIsActive(false);
            setShowResult(true);
            onStoppedRef.current?.();
            return;
          }
          if (idx === targetIdx) passedTarget = true;

          speed = Math.min(speed + 20, 280);
          setTimeout(step, speed);
        };

        step();
      }, delay);

      return () => {
        clearInterval(interval);
        clearTimeout(stopTimer);
      };
    }

    // Reset on falling edge
    if (!spinning && wasSpinningRef.current) {
      wasSpinningRef.current = false;
    }
  }, [spinning, items, delay]);

  const currentItem = items[currentIdx];
  const windowClass = isActive ? "spinning" : showResult ? "stopped" : "";

  return (
    <div className={`slot-reel ${wide ? "slot-reel--wide" : ""} ${large ? "slot-reel--large" : ""}`}>
      <span className="slot-reel-label">{label}</span>
      <div className={`slot-reel-window ${windowClass}`}>
        {currentItem && (
          <div className={`slot-reel-item ${currentItem.rarity ? `rarity-${currentItem.rarity.toLowerCase()}` : ""}`}>
            {(currentItem.hq_image || currentItem.image) && (
              <img
                src={`/static/${currentItem.hq_image || currentItem.image}`}
                alt={currentItem.name}
              />
            )}
          </div>
        )}
      </div>
      {showResult && targetItem && (
        <div className="slot-reel-result">
          <span className="slot-reel-name">{targetItem.name}</span>
          {targetItem.rarity && (
            <span className={`slot-reel-rarity rarity-${targetItem.rarity.toLowerCase()}`}>
              {targetItem.rarity}
            </span>
          )}
        </div>
      )}
    </div>
  );
}
