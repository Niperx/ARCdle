interface Props {
  name: string;
  quantity: number;
  rarity: string;
  image: string | null;
}

export default function IngredientCard({ name, quantity, rarity, image }: Props) {
  return (
    <div className={`ingredient-card rarity-${rarity.toLowerCase()}`}>
      {image && <img src={image} alt={name} className="ingredient-img" />}
      <div className="ingredient-info">
        <span className="ingredient-name">{name}</span>
        <span className="ingredient-qty">x{quantity}</span>
        <span className="ingredient-rarity">{rarity}</span>
      </div>
    </div>
  );
}
