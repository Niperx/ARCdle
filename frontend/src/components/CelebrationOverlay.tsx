import { useEffect, useState } from "react";

interface Props {
  show: boolean;
  onEnd: () => void;
}

export default function CelebrationOverlay({ show, onEnd }: Props) {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    if (show) {
      setVisible(true);
      const t = setTimeout(() => {
        setVisible(false);
        onEnd();
      }, 1200);
      return () => clearTimeout(t);
    }
  }, [show, onEnd]);

  if (!visible) return null;

  return (
    <div className="celebration-overlay" aria-hidden>
      <div className="celebration-flash" />
      <div className="celebration-particles">
        {[...Array(8)].map((_, i) => (
          <div
            key={i}
            className="celebration-particle"
            style={{
              "--angle": `${i * 45}deg`,
              "--delay": `${i * 0.03}s`,
            } as React.CSSProperties}
          />
        ))}
      </div>
    </div>
  );
}
