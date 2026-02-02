@echo off
REM SAP SOAP Client - Windows Batch Launcher
REM This script starts the Node.js server and opens the browser

setlocal enabledelayedexpansion

REM Get the directory where this batch file is located
set "DIR=%~dp0"
cd /d "%DIR%"

REM Prefer standalone EXE if present
if exist "SAP_SOAP_Client.exe" goto run_exe

REM Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════════╗
    echo ║         ERROR: Node.js is not installed!                  ║
    echo ╠════════════════════════════════════════════════════════════╣
    echo ║                                                            ║
    echo ║  Node.js is required to run this application.             ║
    echo ║                                                            ║
    echo ║  Please download and install Node.js from:               ║
    echo ║  https://nodejs.org/ (LTS version recommended)           ║
    echo ║                                                            ║
    echo ║  After installation, run this file again.                ║
    echo ║                                                            ║
    echo ╚════════════════════════════════════════════════════════════╝
    echo.
    pause
    exit /b 1
)

REM Install dependencies if node_modules doesn't exist
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install
    if %errorlevel% neq 0 (
        echo Failed to install dependencies
        pause
        exit /b 1
    )
)

REM Define the port
set PORT=3000

REM Find an available port starting from 3000
:find_port
netstat -ano | findstr :%PORT% >nul
if %errorlevel% equ 0 (
    set /a PORT+=1
    if %PORT% gtr 3010 (
        echo Error: Could not find available port
        pause
        exit /b 1
    )
    goto find_port
)

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║           SAP SOAP Client - Starting Server              ║
echo ╠════════════════════════════════════════════════════════════╣
echo ║                                                            ║
echo ║  Server running at: http://localhost:%PORT%               
echo ║                                                            ║
echo ║  Opening browser... If it doesn't open automatically,     ║
echo ║  manually visit: http://localhost:%PORT%                  
echo ║                                                            ║
echo ║  Press Ctrl+C to stop the server                          ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Start the server
set PORT=%PORT%
start http://localhost:%PORT%

REM Run the server
call npm start

goto :eof

:run_exe
REM Define the port
set PORT=3000

REM Find an available port starting from 3000
:find_port_exe
netstat -ano | findstr :%PORT% >nul
if %errorlevel% equ 0 (
    set /a PORT+=1
    if %PORT% gtr 3010 (
        echo Error: Could not find available port
        pause
        exit /b 1
    )
    goto find_port_exe
)

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║        SAP SOAP Client - Standalone Mode                 ║
echo ╠════════════════════════════════════════════════════════════╣
echo ║                                                            ║
echo ║  Server running at: http://localhost:%PORT%               
echo ║                                                            ║
echo ║  Opening browser... If it doesn't open automatically,     ║
echo ║  manually visit: http://localhost:%PORT%                  ║
echo ║                                                            ║
echo ║  Press Ctrl+C to stop the server                          ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

set PORT=%PORT%
start http://localhost:%PORT%

REM Run standalone EXE
SAP_SOAP_Client.exe
