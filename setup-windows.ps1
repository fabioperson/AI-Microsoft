# AI For Beginners - Windows Setup Script
# Run this in PowerShell: .\setup-windows.ps1

Write-Host ""
Write-Host "=== AI For Beginners - Windows Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check if Python is installed
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    Write-Host "[X] Python is NOT installed." -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Python first:" -ForegroundColor Yellow
    Write-Host "  1. Go to https://www.python.org/downloads/"
    Write-Host "  2. Download and run the installer"
    Write-Host '  3. IMPORTANT: Check "Add Python to PATH" during installation'
    Write-Host "  4. Close and reopen PowerShell"
    Write-Host "  5. Run this script again"
    Write-Host ""

    $openBrowser = Read-Host "Open the Python download page now? (y/n)"
    if ($openBrowser -eq 'y') {
        Start-Process "https://www.python.org/downloads/"
    }
    exit 1
}

$pythonVersion = python --version 2>&1
Write-Host "[OK] $pythonVersion found" -ForegroundColor Green

# Warn if Python version is too new for some packages
$versionMatch = [regex]::Match($pythonVersion, '(\d+)\.(\d+)')
if ($versionMatch.Success) {
    $major = [int]$versionMatch.Groups[1].Value
    $minor = [int]$versionMatch.Groups[2].Value
    if ($major -ge 3 -and $minor -ge 14) {
        Write-Host "[!] Python $major.$minor detected. Some packages may need newer versions." -ForegroundColor Yellow
        Write-Host "    This project uses pygame-ce (Community Edition) for compatibility." -ForegroundColor Yellow
    }
}

# Check pip
$pip = Get-Command pip -ErrorAction SilentlyContinue
if (-not $pip) {
    Write-Host "[X] pip is not available. Trying to install..." -ForegroundColor Yellow
    python -m ensurepip --upgrade
}

Write-Host ""
Write-Host "Installing dependencies from requirements.txt..." -ForegroundColor Cyan
Write-Host "(This may take several minutes)"
Write-Host ""

python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip install jupyter notebook

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[X] Some packages failed to install." -ForegroundColor Red
    Write-Host "You can still try running Jupyter - some lessons may work." -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "[OK] All dependencies installed successfully!" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "To start learning, run:" -ForegroundColor Yellow
Write-Host "  python -m jupyter notebook" -ForegroundColor White
Write-Host ""
Write-Host "This will open Jupyter in your browser." -ForegroundColor Gray
Write-Host "Navigate to the 'lessons' folder to begin!" -ForegroundColor Gray
Write-Host ""

$startNow = Read-Host "Start Jupyter Notebook now? (y/n)"
if ($startNow -eq 'y') {
    python -m jupyter notebook
}
