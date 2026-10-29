# Maclight Live ISO builder for Windows 10/11.
# This script opens the GitHub Actions workflow page; the build runs on a Linux runner.
# No local Linux VM, WSL, admin privileges, or personal access token is required.
$ErrorActionPreference = "Stop"

$repoUrl = "https://github.com/"
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    Write-Host "This folder is not connected to a GitHub repository." -ForegroundColor Yellow
    Write-Host "1. Create an empty GitHub repository."
    Write-Host "2. Run these commands in this folder:"
    Write-Host "   git init"
    Write-Host "   git add ."
    Write-Host '   git commit -m "Initial Maclight Live builder"'
    Write-Host "   git branch -M main"
    Write-Host "   git remote add origin https://github.com/YOUR-USER/YOUR-REPO.git"
    Write-Host "   git push -u origin main"
    exit 1
}

$slug = $remote -replace '^git@github\.com:', 'https://github.com/'
$slug = $slug -replace '^https://github\.com/', ''
$slug = $slug -replace '\.git$', ''
if ($slug.Contains("/")) {
    $workflow = "https://github.com/$slug/actions/workflows/build-iso.yml"
    Write-Host "Opening GitHub Actions for $slug"
    Write-Host "Select 'Run workflow' and confirm the main branch."
    Start-Process $workflow
} else {
    throw "Could not identify GitHub repository from remote URL: $remote"
}
