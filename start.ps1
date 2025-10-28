param(
    [string]$GenAIKey = "",
    [string]$SecretKey = "",
    [string]$Host = "0.0.0.0",
    [int]$Port = 8000
)

# Optional: set env vars for this session if provided
if ($GenAIKey -ne "") { $env:RIZER_GENAI_KEY = $GenAIKey }
if ($SecretKey -ne "") { $env:RIZER_SECRET_KEY = $SecretKey }

Write-Host "Activating virtual environment .venv..."
if (Test-Path ".\.venv\Scripts\Activate.ps1") {
    & .\.venv\Scripts\Activate.ps1
} else {
    Write-Warning "Virtual environment not found at .\.venv. Activate your venv manually before running the script."
}

Write-Host "Starting Django development server on $Host:$Port"
python manage.py runserver "$Host`:$Port"
