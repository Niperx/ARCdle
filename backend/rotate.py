"""
Rotate daily challenges to new ones.

Shifts epoch_date back by 1 day in config.py, which changes the hash seed
and selects different items for today. Also clears today's guesses and
completions from the database.

Usage:
    cd backend && venv/Scripts/python.exe rotate.py
"""

import re
from datetime import date, timedelta
from pathlib import Path

from app.database import SessionLocal
from app.models import DailyGuess, DailyCompletion
from app.daily import get_today_utc

CONFIG_PATH = Path(__file__).parent / "app" / "config.py"


def shift_epoch():
    text = CONFIG_PATH.read_text(encoding="utf-8")
    match = re.search(r'epoch_date:\s*str\s*=\s*"(\d{4}-\d{2}-\d{2})"', text)
    if not match:
        print("ERROR: Could not find epoch_date in config.py")
        return None

    old_date = date.fromisoformat(match.group(1))
    new_date = old_date - timedelta(days=1)
    new_text = text.replace(f'"{old_date.isoformat()}"', f'"{new_date.isoformat()}"')
    CONFIG_PATH.write_text(new_text, encoding="utf-8")
    print(f"Shifted epoch: {old_date} -> {new_date}")
    return new_date


def clear_today_data():
    today = get_today_utc()
    db = SessionLocal()
    guesses = db.query(DailyGuess).filter(DailyGuess.date == today).delete()
    completions = db.query(DailyCompletion).filter(DailyCompletion.date == today).delete()
    db.commit()
    db.close()
    print(f"Cleared {guesses} guesses and {completions} completions for {today}")


if __name__ == "__main__":
    shift_epoch()
    clear_today_data()
    print("Done! Restart the backend and clear localStorage in the browser.")
