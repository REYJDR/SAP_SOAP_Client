# SAP SOAP Client - Windows PowerShell Launcher
# This script starts the Node.js server and opens the browser

# Set location to script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Prefer standalone EXE if present
$exePath = Join-Path $scriptPath "SAP_SOAP_Client.exe"
$useExe = Test-Path $exePath

if (-not $useExe) {
    # Check if Node.js is installed
    try {
        $node = Get-Command node -ErrorAction Stop
        Write-Host "✓ Node.js found: $($node.Source)" -ForegroundColor Green
    } catch {
        Write-Host ""
        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
        Write-Host "║         ERROR: Node.js is not installed!                  ║" -ForegroundColor Red
        Write-Host "╠════════════════════════════════════════════════════════════╣" -ForegroundColor Red
        Write-Host "║                                                            ║" -ForegroundColor Red
        Write-Host "║  Node.js is required to run this application.             ║" -ForegroundColor Red
        Write-Host "║                                                            ║" -ForegroundColor Red
        Write-Host "║  Please download and install Node.js from:               ║" -ForegroundColor Red
        Write-Host "║  https://nodejs.org/ (LTS version recommended)           ║" -ForegroundColor Red
        Write-Host "║                                                            ║" -ForegroundColor Red
        Write-Host "║  After installation, run this file again.                ║" -ForegroundColor Red
        Write-Host "║                                                            ║" -ForegroundColor Red
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }

    # Install dependencies if needed
    if (-not (Test-Path "node_modules")) {
        Write-Host "Installing dependencies..."
        & npm install
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Failed to install dependencies" -ForegroundColor Red
            Read-Host "Press Enter to exit"
            exit 1
        }
    }
}

# Find available port
$port = 3000
$maxAttempts = 10
$attempts = 0

while ($attempts -lt $maxAttempts) {
    try {
        $connection = Test-NetConnection -ComputerName localhost -Port $port -WarningAction SilentlyContinue
        if ($connection.TcpTestSucceeded) {
            $port++
            $attempts++
        } else {
            break
        }
    } catch {
        break
    }
}

if ($attempts -eq $maxAttempts) {
    Write-Host "Error: Could not find available port" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
if ($useExe) {
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║        SAP SOAP Client - Standalone Mode                 ║" -ForegroundColor Cyan
    Write-Host "╠════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
} else {
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║           SAP SOAP Client - Starting Server              ║" -ForegroundColor Cyan
    Write-Host "╠════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
}
Write-Host "║                                                            ║" -ForegroundColor Cyan
Write-Host "║  Server running at: http://localhost:$port" -ForegroundColor Cyan
Write-Host "║                                                            ║" -ForegroundColor Cyan
Write-Host "║  Opening browser... If it doesn't open automatically,     ║" -ForegroundColor Cyan
Write-Host "║  manually visit: http://localhost:$port" -ForegroundColor Cyan
Write-Host "║                                                            ║" -ForegroundColor Cyan
Write-Host "║  Press Ctrl+C to stop the server                          ║" -ForegroundColor Cyan
Write-Host "║                                                            ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Open browser
Start-Process "http://localhost:$port"

# Start server
$env:PORT = $port
if ($useExe) {
    & $exePath
} else {
    & npm start
}
