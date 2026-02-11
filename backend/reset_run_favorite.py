"""Reset Exodus Run leaderboard and Daily Favorite votes. Run: python reset_run_favorite.py"""

from sqlalchemy import text

from app.database import engine

def main():
    with engine.connect() as conn:
        conn.execute(text("TRUNCATE TABLE run_scores RESTART IDENTITY CASCADE"))
        conn.execute(text("TRUNCATE TABLE favorite_votes RESTART IDENTITY CASCADE"))
        conn.execute(text("TRUNCATE TABLE run_plays RESTART IDENTITY CASCADE"))
        conn.execute(text("TRUNCATE TABLE visits RESTART IDENTITY CASCADE"))
        conn.commit()
    print("Reset: run_scores, favorite_votes, run_plays, visits")

if __name__ == "__main__":
    main()
