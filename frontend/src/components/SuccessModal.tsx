interface Props {
  name: string;
  image: string | null;
  attempts: number;
  position: number | null;
  wideImage?: boolean;
  onClose: () => void;
}

export default function SuccessModal({ name, image, attempts, position, wideImage, onClose }: Props) {
  return (
    <div className="success-overlay" onClick={onClose}>
      <div className={`success-modal ${wideImage ? "success-modal--wide" : ""}`} onClick={(e) => e.stopPropagation()}>
        <h2>Correct!</h2>
        {image && <img src={image} alt={name} className={`success-img ${wideImage ? "success-img--wide" : ""}`} />}
        <p className="success-name">{name}</p>
        <p className="success-attempts">Guessed in {attempts} {attempts === 1 ? "attempt" : "attempts"}</p>
        {position !== null && (
          <p className="success-position">
            You are #{position} today
          </p>
        )}
        <button className="success-btn" onClick={onClose}>Close</button>
      </div>
    </div>
  );
}
