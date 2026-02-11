from pathlib import Path

from pydantic_settings import BaseSettings

# Frontend dist path (for production SPA serving)
PROJECT_ROOT = Path(__file__).resolve().parent.parent.parent
FRONTEND_DIST = PROJECT_ROOT / "frontend" / "dist"


class Settings(BaseSettings):
    database_url: str = "postgresql://arcidle:arcidle@localhost:5432/arcidle"
    static_dir: str = "static"
    epoch_date: str = "2026-02-02"
    timezone: str = "UTC"
    cors_origins: list[str] = ["http://localhost:5173", "https://arcdle.online"]

    class Config:
        env_file = ".env"


settings = Settings()
