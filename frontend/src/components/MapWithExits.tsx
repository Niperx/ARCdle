import { useState, useCallback } from "react";

type ExitPosition = { x: number; y: number; w: number; h: number } | { x_px: number; y_px: number; icon?: string };

type CropConfig = number | { left?: number; right?: number; top?: number; bottom?: number };

interface Props {
  imageUrl: string;
  exitPositions: ExitPosition[];
  imageWidth?: number;
  imageHeight?: number;
  crop?: CropConfig;
  onExitClick: (index: number) => void;
}

const EXIT_ICONS: Record<string, string> = {
  exfil_train: "/static/maps/topdown/exfil_train.png",
  exfil_elevator: "/static/maps/topdown/exfil_elevator.png",
  exfil_airshaft: "/static/maps/topdown/exfil_airshaft.png",
};
const DEFAULT_ICON = "/static/maps/topdown/exfil_elevator.png";
const BUTTON_SIZE_PCT = 8;

function toPercentCoords(
  pos: ExitPosition,
  imgW: number,
  imgH: number,
  crop: CropConfig | undefined
): { centerX: number; centerY: number; w: number; h: number; icon: string } {
  if ("x_px" in pos && "y_px" in pos) {
    const icon = pos.icon && EXIT_ICONS[pos.icon] ? EXIT_ICONS[pos.icon] : DEFAULT_ICON;
    let centerX: number;
    let centerY: number;
    const xPct = (pos.x_px / imgW) * 100;
    const yPct = (pos.y_px / imgH) * 100;
    if (typeof crop === "number") {
      const visible = 100 - crop * 2;
      centerX = ((xPct - crop) / visible) * 100;
      centerY = ((yPct - crop) / visible) * 100;
    } else if (typeof crop === "object") {
      const left = crop.left ?? 0;
      const right = crop.right ?? 0;
      const top = crop.top ?? 0;
      const bottom = crop.bottom ?? 0;
      const visibleW = 100 - left - right;
      const visibleH = 100 - top - bottom;
      centerX = visibleW > 0 ? ((xPct - left) / visibleW) * 100 : xPct;
      centerY = visibleH > 0 ? ((yPct - top) / visibleH) * 100 : yPct;
    } else {
      centerX = xPct;
      centerY = yPct;
    }
    return { centerX, centerY, w: BUTTON_SIZE_PCT, h: BUTTON_SIZE_PCT, icon };
  }
  const p = pos as { x: number; y: number; w: number; h: number };
  return { centerX: p.x + p.w / 2, centerY: p.y + p.h / 2, w: p.w, h: p.h, icon: DEFAULT_ICON };
}

function getImgTransform(crop: CropConfig | undefined): React.CSSProperties {
  if (!crop) return {};
  if (typeof crop === "number") {
    const visible = (100 - crop * 2) / 100;
    const scale = 1 / visible;
    return { transform: `scale(${scale})`, transformOrigin: "center center" };
  }
  const left = crop.left ?? 0;
  const right = crop.right ?? 0;
  const top = crop.top ?? 0;
  const bottom = crop.bottom ?? 0;
  const visibleW = (100 - left - right) / 100;
  const visibleH = (100 - top - bottom) / 100;
  const scaleX = visibleW > 0 ? 1 / visibleW : 1;
  const scaleY = visibleH > 0 ? 1 / visibleH : 1;
  return {
    transform: `translate(${-left * scaleX}%, ${-top * scaleY}%) scale(${scaleX}, ${scaleY})`,
    transformOrigin: "0 0",
  };
}

export default function MapWithExits({ imageUrl, exitPositions, imageWidth = 2048, imageHeight = 2048, crop, onExitClick }: Props) {
  const [imgSize, setImgSize] = useState<{ w: number; h: number } | null>(null);
  const onImgLoad = useCallback((e: React.SyntheticEvent<HTMLImageElement>) => {
    const img = e.currentTarget;
    setImgSize({ w: img.naturalWidth, h: img.naturalHeight });
  }, []);

  const dims = imgSize ?? { w: imageWidth, h: imageHeight };
  const positions = exitPositions.map((p) => toPercentCoords(p, dims.w, dims.h, crop));

  return (
    <div className="run-map-container" style={{ aspectRatio: `${dims.w} / ${dims.h}` }}>
      <img src={imageUrl} alt="Map" className="run-map-img" onLoad={onImgLoad} style={getImgTransform(crop)} />
      {positions.map((pos, i) => (
        <button
          key={i}
          type="button"
          className="run-exit-btn"
          style={{
            left: `${pos.centerX}%`,
            top: `${pos.centerY}%`,
            width: `${pos.w}%`,
            height: `${pos.h}%`,
          }}
          onClick={() => onExitClick(i)}
          aria-label={`Exit ${i + 1}`}
        >
          <img src={pos.icon} alt="" />
        </button>
      ))}
    </div>
  );
}
