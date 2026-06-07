FROM python:3.11-slim

WORKDIR /app

# Dépendances système
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# Dépendances Python
COPY requirements.txt* ./
RUN pip install --no-cache-dir \
    fastapi uvicorn[standard] \
    google-auth google-auth-oauthlib google-api-python-client \
    groq python-dotenv cryptography

# Code source
COPY main.py ./
COPY credentials.json* ./
COPY token.enc* ./
COPY emailai_state.json* ./

# Port exposé
EXPOSE 8000

# Démarrage
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
