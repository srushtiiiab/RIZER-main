param(
    [Parameter(Mandatory=$false)] [string]$RepoUrl
)

# A simple helper to initialize, commit and push this project to GitHub.
# Usage: .\publish.ps1 -RepoUrl "https://github.com/your-username/your-repo.git"

function Check-Git {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Error "Git is not installed or not on PATH. Install Git for Windows: https://git-scm.com/download/win"
        exit 1
    }
}

Check-Git

if (-not $RepoUrl) {
    $RepoUrl = Read-Host "Enter the GitHub repository URL (HTTPS or SSH), e.g. https://github.com/you/repo.git"
}

# Confirm current directory
$cwd = Get-Location
Write-Host "Running from: $cwd"

# Run git commands
git init
git add -A
$existing = git rev-parse --is-inside-work-tree 2>$null
try {
    git commit -m "Initial commit" -q
} catch {
    Write-Host "No changes to commit or commit failed. Continuing..."
}

# Set main branch name and remote
git branch -M main 2>$null
if ($RepoUrl) {
    git remote remove origin 2>$null
    git remote add origin $RepoUrl
    Write-Host "Pushing to $RepoUrl ..."
    git push -u origin main
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Push failed. You may need to authenticate. If using HTTPS, create a PAT and use it when prompted. If using SSH, ensure your key is added to GitHub and ssh-agent is running."
    } else {
        Write-Host "Pushed successfully."
    }
} else {
    Write-Warning "No repo URL provided; repo initialized locally. Add a remote and push manually."
}
