from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse, Response
from fastapi.staticfiles import StaticFiles

from app.config import settings, FRONTEND_DIST
from app.database import Base, engine, SessionLocal
from app.models import Weapon, Location, Blueprint
from app.routers import weapons, locations, blueprints, skills, sounds, daily, build, stats, run, favorite

Base.metadata.create_all(bind=engine)


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Warm up DB connection pool on startup
    db = SessionLocal()
    try:
        db.query(Weapon).first()
        db.query(Location).first()
        db.query(Blueprint).first()
        print("Database connection warmed up")
    finally:
        db.close()
    yield


app = FastAPI(title="ARCIdle API", lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.mount("/static", StaticFiles(directory=settings.static_dir), name="static")

app.include_router(weapons.router, prefix="/api")
app.include_router(locations.router, prefix="/api")
app.include_router(blueprints.router, prefix="/api")
app.include_router(skills.router, prefix="/api")
app.include_router(sounds.router, prefix="/api")
app.include_router(daily.router, prefix="/api/daily")
app.include_router(build.router, prefix="/api")
app.include_router(stats.router, prefix="/api/stats")
app.include_router(run.router, prefix="/api")
app.include_router(favorite.router, prefix="/api")


# Return 404 for common bot/scanner paths (WordPress, PHP, etc.) so they don't get 200 + index.html
@app.get("/wp-admin", include_in_schema=False)
@app.get("/wp-admin/{path:path}", include_in_schema=False)
@app.get("/wordpress", include_in_schema=False)
@app.get("/wordpress/{path:path}", include_in_schema=False)
def _block_bot_paths(path: str = ""):
    return Response(status_code=404)


# Serve frontend SPA (production build) - must be last
if FRONTEND_DIST.exists():
    @app.get("/{path:path}")
    def serve_spa(path: str):
        """Serve frontend static files or index.html for SPA routes."""
        file_path = (FRONTEND_DIST / path).resolve()
        if not str(file_path).startswith(str(FRONTEND_DIST.resolve())):
            return FileResponse(FRONTEND_DIST / "index.html")  # path traversal guard
        if file_path.is_file():
            return FileResponse(file_path)
        return FileResponse(FRONTEND_DIST / "index.html")
