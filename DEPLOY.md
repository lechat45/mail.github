# EmailAI — Guide de déploiement & GitHub Actions

## Option 1 : Local (recommandé pour débuter)
Double-clique sur `start.bat` — tout démarre automatiquement.

---

## Option 2 : Railway (gratuit, 5$/mois après quota)

1. **Crée un compte** sur [railway.app](https://railway.app)
2. **Nouveau projet** → "Deploy from GitHub repo"
3. **Variables d'environnement** à ajouter dans Railway :
   ```
   GROQ_API_KEY=gsk_xxxxx
   EMAILAI_CRON_SECRET=ton-secret-aleatoire
   EMAILAI_API_URL=https://ton-app.railway.app
   OAUTHLIB_INSECURE_TRANSPORT=1
   ```
4. **Copie ton token Gmail** :
   - Connecte-toi en local, copie le contenu de `token.json` ou `token.enc`
   - Ajoute `GMAIL_TOKEN_B64` = contenu encodé en base64

5. **Ajoute le `Dockerfile`** (déjà inclus)

---

## Option 3 : Render (gratuit 750h/mois)

1. [render.com](https://render.com) → New Web Service
2. Connect GitHub repo
3. Build Command: `pip install -r requirements.txt`
4. Start Command: `uvicorn main:app --host 0.0.0.0 --port $PORT`
5. Variables d'environnement : identiques à Railway

---

## Configuration GitHub Actions (après déploiement)

### Secrets à ajouter dans GitHub
Settings → Secrets and variables → Actions → New repository secret :

| Nom | Valeur |
|---|---|
| `EMAILAI_API_URL` | `https://ton-app.railway.app` |
| `EMAILAI_CRON_SECRET` | Même valeur que dans ton `.env` |

### Activer l'analyse automatique
Dans l'app → **GitHub & Cron** → Active "Analyse auto toutes les 5 min"

Le workflow `.github/workflows/auto-analyze.yml` se déclenchera :
- ✅ Automatiquement toutes les 5 minutes
- ✅ À chaque push sur `main`
- ✅ Manuellement depuis GitHub → Actions → Run workflow

---

## Variables d'environnement (.env)

```env
GROQ_API_KEY=gsk_xxxxx
EMAILAI_CRON_SECRET=change-moi-par-une-chaine-aleatoire
EMAILAI_API_URL=http://localhost:8000
```
