interface Props {
  label: string;
  value: number;
  maxValue: number;
}

export default function StatBar({ label, value, maxValue }: Props) {
  const percent = maxValue > 0 ? Math.min((value / maxValue) * 100, 100) : 0;

  return (
    <div className="stat-bar">
      <span className="stat-bar-label">{label}</span>
      <div className="stat-bar-track">
        <div className="stat-bar-fill" style={{ width: `${percent}%` }} />
      </div>
    </div>
  );
}
