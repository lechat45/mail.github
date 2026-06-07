FROM python:3.11-slim

WORKDIR /app

# Cache buster — incrémenter pour forcer rebuild
ARG CACHE_BUST=2

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc curl && rm -rf /var/lib/apt/lists/*

# Dépendances Python
RUN pip install --no-cache-dir \
    fastapi \
    "uvicorn[standard]" \
    google-auth \
    google-auth-oauthlib \
    google-api-python-client \
    groq \
    python-dotenv \
    httplib2 \
    pydantic \
    starlette

# Copier le code (APRÈS pip install = cache séparé)
COPY main.py .

# Port Render
ENV PORT=8000
EXPOSE $PORT

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
