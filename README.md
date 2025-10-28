# RIZER - Local run instructions

This project is a Django app. These steps assume Windows PowerShell and the project root at `C:\Users\KESHAV-PC\Desktop\RIZER-main`.

1) Open PowerShell and change to the project folder:

```powershell
cd "C:\Users\KESHAV-PC\Desktop\RIZER-main"
```

2) Activate the virtual environment (this project uses `.venv`):

```powershell
.\.venv\Scripts\Activate.ps1
```

3) (Optional) Install dependencies if not already installed:

```powershell
python -m pip install --upgrade pip
python -m pip install -r .\requirements.txt
```

4) Run database migrations:

```powershell
python manage.py migrate
```

5) (Optional) Create an admin user:

```powershell
python manage.py createsuperuser
```

6) Start the development server (basic):

```powershell
python manage.py runserver 0.0.0.0:8000
```

7) Open a browser to http://127.0.0.1:8000

Notes about AI features
- The app optionally uses the Google Generative AI SDK. To enable it, set an environment variable with your API key before starting the server:

```powershell
$env:RIZER_GENAI_KEY = "YOUR_API_KEY"
python manage.py runserver 0.0.0.0:8000
```

- If the SDK cannot be imported on your machine due to package conflicts, the app will run in fallback mode: endpoints will return deterministic placeholder summaries and MCQs so the site stays usable.

Easy start script
-----------------
I added a `start.ps1` helper to make local runs simpler. It sets optional env vars and starts the server. Usage:

```powershell
# Set API key and secret on the fly and start server
.\start.ps1 -GenAIKey "YOUR_REAL_API_KEY" -SecretKey "your-secret-key"

# Or just activate venv and run the script (useful when secrets are already set):
.\.venv\Scripts\Activate.ps1
.\start.ps1
```

Notes about secrets
- `RIZER_GENAI_KEY` is used for the Google Generative AI API key.
- `RIZER_SECRET_KEY` is the Django secret key.
- Both are read from environment variables in `rizer/settings.py` with safe defaults for local development. Do NOT commit real secrets to the repo.

If you run into errors, paste the terminal output here and I'll help fix them.
# RIZER - Local run instructions

This project is a Django app. These steps assume Windows PowerShell and the project root at `C:\Users\KESHAV-PC\Desktop\RIZER-main`.

1) Open PowerShell and change to the project folder:

```powershell
cd "C:\Users\KESHAV-PC\Desktop\RIZER-main"
```

2) Activate the virtual environment (this project uses `.venv`):

```powershell
.\.venv\Scripts\Activate.ps1
```

3) (Optional) Install dependencies if not already installed:

```powershell
python -m pip install --upgrade pip
python -m pip install -r .\requirements.txt
```

4) Run database migrations:

```powershell
python manage.py migrate
```

5) (Optional) Create an admin user:

```powershell
python manage.py createsuperuser
```

6) Start the development server:

```powershell
python manage.py runserver 0.0.0.0:8000
```

7) Open a browser to http://127.0.0.1:8000

Notes about AI features
- The app optionally uses the Google Generative AI SDK. To enable it, set an environment variable with your API key before starting the server:

```powershell
$env:RIZER_GENAI_KEY = "YOUR_API_KEY"
python manage.py runserver 0.0.0.0:8000
```

- If the SDK cannot be imported on your machine due to package conflicts, the app will now run in fallback mode: endpoints will return deterministic placeholder summaries and MCQs so the site stays usable.

If you run into errors, paste the terminal output here and I'll help fix them.

Deploying to Render (one recommended, easy option)
------------------------------------------------
1) Push your project to GitHub (create a repo and push the current directory).
2) Create a new Web Service on https://render.com and connect your GitHub repo.
	- Build command: pip install -r requirements.txt
	- Start command: gunicorn rizer.wsgi --log-file -
3) Set environment variables in Render's dashboard:
	- RIZER_SECRET_KEY (set a secure value)
	- RIZER_DEBUG = False
	- (optional) RIZER_GENAI_KEY = your Google API key
4) Deploy — Render will build, run collectstatic (if you include it in build commands), and give you a public URL.

Notes
- I added WhiteNoise + Gunicorn and a `Procfile` so the app is ready to run on Render, Heroku, Railway, etc.
- You must push the repo to GitHub and then connect the repo to the hosting provider; I cannot push it to your GitHub account without credentials.
- If you'd like, paste your GitHub repo URL here after you push and I will provide exact Render settings or try to trigger a deploy step-by-step.