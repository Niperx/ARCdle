# Stage 1: Build frontend
FROM node:20-alpine AS frontend-build
WORKDIR /build

COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci

COPY frontend/ ./
RUN npm run build

# Stage 2: Backend + frontend
FROM python:3.12-slim
WORKDIR /app

# Layout: /app = project root (backend + frontend)
# Config expects PROJECT_ROOT = dir containing backend & frontend, FRONTEND_DIST = .../frontend/dist

COPY backend/ ./backend/
COPY --from=frontend-build /build/dist ./frontend/dist/

RUN pip install --no-cache-dir -r backend/requirements.txt

WORKDIR /app/backend
EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
