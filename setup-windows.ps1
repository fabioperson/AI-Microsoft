# AI For Beginners - Windows Setup Script
# Run this in PowerShell: .\setup-windows.ps1

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  AI For Beginners - Windows Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ── Step 1: Check Python ──────────────────────────

Write-Host "Step 1: Checking Python installation..." -ForegroundColor White

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    Write-Host ""
    Write-Host "  [X] Python is NOT installed." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Please install Python first:" -ForegroundColor Yellow
    Write-Host "    1. Go to https://www.python.org/downloads/"
    Write-Host "    2. Download and run the installer"
    Write-Host '    3. IMPORTANT: Check "Add Python to PATH" during installation'
    Write-Host "    4. Close and reopen PowerShell"
    Write-Host "    5. Run this script again"
    Write-Host ""

    $openBrowser = Read-Host "  Open the Python download page now? (y/n)"
    if ($openBrowser -eq 'y') {
        Start-Process "https://www.python.org/downloads/"
    }
    exit 1
}

$pythonVersion = python --version 2>&1
Write-Host "  [OK] $pythonVersion" -ForegroundColor Green

# Check for version compatibility warnings
$versionMatch = [regex]::Match($pythonVersion, '(\d+)\.(\d+)')
if ($versionMatch.Success) {
    $major = [int]$versionMatch.Groups[1].Value
    $minor = [int]$versionMatch.Groups[2].Value
    if ($major -ge 3 -and $minor -ge 13) {
        Write-Host ""
        Write-Host "  [!] WARNING: Python $major.$minor has limited package support." -ForegroundColor Yellow
        Write-Host "      - TensorFlow/TensorBoard will be skipped (no builds available)" -ForegroundColor Yellow
        Write-Host "      - Lessons using TensorFlow/Keras will not work" -ForegroundColor Yellow
        if ($minor -ge 14) {
            Write-Host "      - Using pygame-ce (Community Edition) for compatibility" -ForegroundColor Yellow
        }
        Write-Host ""
        Write-Host "      TIP: For full compatibility, create a Python 3.12 venv:" -ForegroundColor Gray
        Write-Host "        py -3.12 -m venv .venv" -ForegroundColor Gray
        Write-Host "        .venv\Scripts\Activate.ps1" -ForegroundColor Gray
        Write-Host "        .\setup-windows.ps1" -ForegroundColor Gray
    }
}

Write-Host ""

# ── Step 2: Check pip ─────────────────────────────

Write-Host "Step 2: Checking pip..." -ForegroundColor White

$pip = Get-Command pip -ErrorAction SilentlyContinue
if (-not $pip) {
    Write-Host "  [!] pip not found. Installing..." -ForegroundColor Yellow
    python -m ensurepip --upgrade
} else {
    Write-Host "  [OK] pip available" -ForegroundColor Green
}

Write-Host ""

# ── Step 3: Install dependencies ──────────────────

Write-Host "Step 3: Installing dependencies..." -ForegroundColor White
Write-Host "  This may take several minutes." -ForegroundColor Gray
Write-Host ""

python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip install jupyter notebook

Write-Host ""
if ($LASTEXITCODE -ne 0) {
    Write-Host "  [X] Some packages failed to install." -ForegroundColor Red
    Write-Host "      You can still try running Jupyter - some lessons may work." -ForegroundColor Yellow
} else {
    Write-Host "  [OK] All dependencies installed!" -ForegroundColor Green
}

Write-Host ""

# ── Done ──────────────────────────────────────────

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  To start learning, run:" -ForegroundColor White
Write-Host "    python -m jupyter notebook" -ForegroundColor Cyan
Write-Host ""
Write-Host "  This will open Jupyter in your browser." -ForegroundColor Gray
Write-Host "  Navigate to the 'lessons' folder to begin!" -ForegroundColor Gray
Write-Host ""

$startNow = Read-Host "  Start Jupyter Notebook now? (y/n)"
if ($startNow -eq 'y') {
    python -m jupyter notebook
}
