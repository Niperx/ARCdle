interface Props {
  label: string;
  value: string | number;
}

export default function StatText({ label, value }: Props) {
  return (
    <div className="stat-text">
      <span className="stat-text-label">{label}</span>
      <span className="stat-text-value">{String(value)}</span>
    </div>
  );
}
