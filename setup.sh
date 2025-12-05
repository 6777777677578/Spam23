#!/bin/bash
set -e

echo "🚀 Starting Spyther bot setup (VENV MODE)..."

# ✅ Ensure venv is active
if [[ "$VIRTUAL_ENV" == "" ]]; then
  echo "❌ ERROR: Virtual environment is NOT active!"
  echo "Run this first:"
  echo "source myenv/bin/activate"
  exit 1
fi

echo "✅ Using venv at: $VIRTUAL_ENV"

# ---------------- System packages (ONLY if you have sudo) ----------------
echo "📦 Installing system dependencies (requires sudo)..."
sudo apt update
sudo apt install -y \
    python3-dev build-essential \
    libffi-dev libssl-dev libsqlite3-dev libjpeg-dev zlib1g-dev \
    curl git wget unzip xvfb libnss3 libatk1.0-0 libcups2 \
    libxcomposite1 libxdamage1 libxrandr2 libxkbcommon0 libpango-1.0-0 \
    libgbm1 fonts-liberation libappindicator3-1 xdg-utils \
    ffmpeg procps psmisc ca-certificates

# ---------------- Upgrade pip inside venv ----------------
echo "🐍 Upgrading pip, setuptools, wheel (VENV)..."
python -m pip install --upgrade pip setuptools wheel

# ---------------- Python packages (VENV ONLY) ----------------
echo "📦 Installing Python dependencies (VENV)..."
python -m pip install python-dotenv cryptography httpx
python -m pip install "python-telegram-bot<23,>=22.0"
python -m pip install instagrapi
python -m pip install playwright
python -m pip install playwright-stealth==1.0.6

# ---------------- Playwright browsers ----------------
echo "🌐 Installing Playwright browsers..."
python -m playwright install
python -m playwright install-deps

# ---------------- Create sessions folder ----------------
mkdir -p sessions

echo "✅ Setup complete! Run your bot using:"
echo "python bot.py"
