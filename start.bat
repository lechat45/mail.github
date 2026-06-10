@echo off
chcp 65001 > nul
title EmailAI - Démarrage automatique
color 0B

echo.
echo  ╔═══════════════════════════════════════╗
echo  ║         EmailAI - Démarrage           ║
echo  ╚═══════════════════════════════════════╝
echo.

:: Aller dans le dossier du script
cd /d "%~dp0"

:: Vérifier Python
where python > nul 2>&1
if errorlevel 1 (
    echo  [ERREUR] Python non trouvé
    pause & exit
)

:: Vérifier Node
where node > nul 2>&1
if errorlevel 1 (
    echo  [ERREUR] Node.js non trouvé
    pause & exit
)

:: Installer les dépendances Python si nécessaire
echo  [1/4] Vérification des dépendances Python...
pip install -q fastapi uvicorn google-auth google-auth-oauthlib google-api-python-client groq python-dotenv

:: npm install si node_modules absent
if not exist "node_modules" (
    echo  [2/4] Installation des dépendances Node...
    call npm install --silent
) else (
    echo  [2/4] Dépendances Node OK
)

:: Démarrer le backend dans une nouvelle fenêtre
echo  [3/4] Démarrage du backend (port 8000)...
start "EmailAI Backend" cmd /k "python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload"

:: Attendre 3 secondes que le backend démarre
timeout /t 3 /nobreak > nul

:: Démarrer le frontend dans une nouvelle fenêtre
echo  [4/4] Démarrage du frontend (port 5173)...
start "EmailAI Frontend" cmd /k "npm run dev"

:: Attendre 2 secondes
timeout /t 2 /nobreak > nul

:: Ouvrir le navigateur
echo.
echo  ✓ EmailAI démarré !
echo  ✓ Ouverture du navigateur...
start http://localhost:5173

echo.
echo  ╔═══════════════════════════════════════╗
echo  ║  Backend:  http://localhost:8000      ║
echo  ║  Frontend: http://localhost:5173      ║
echo  ║                                       ║
echo  ║  Ferme cette fenêtre pour tout        ║
echo  ║  arrêter, ou ferme les fenêtres       ║
echo  ║  Backend et Frontend séparément.      ║
echo  ╚═══════════════════════════════════════╝
echo.
pause
