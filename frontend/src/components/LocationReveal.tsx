interface Props {
  imageUrl: string;
  cropX: number;
  cropY: number;
  cropPercent: number;
}

export default function LocationReveal({ imageUrl }: Props) {
  return (
    <div className="location-reveal">
      <div className="location-reveal-container">
        <img
          src={imageUrl}
          alt="Location"
          className="location-reveal-img"
          draggable={false}
        />
      </div>
    </div>
  );
}
