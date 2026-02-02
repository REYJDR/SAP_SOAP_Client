# Windows Installation Guide for SAP SOAP Client

## Quick Start (Recommended)

### Option 0: Standalone EXE (No Installation Required)
Use this if you **cannot install Node.js** on the target computer.
1. Obtain the standalone package that includes `SAP_SOAP_Client.exe`
2. Extract the ZIP to a folder
3. Double-click `start.bat` or `start.ps1`
4. The app opens in your browser (no Node.js install needed)

### Option 1: Using PowerShell (Windows 10/11)
1. Right-click `start.ps1` and select "Run with PowerShell"
2. If you get an execution policy error, use PowerShell as Administrator and run:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
3. Then double-click `start.ps1` again

### Option 2: Using Batch File
1. Double-click `start.bat`
2. Wait for dependencies to install (first run only)
3. Browser will open automatically

### Option 3: Manual Setup
1. Install Node.js from https://nodejs.org/ (LTS version recommended)
2. Open Command Prompt or PowerShell
3. Navigate to the SAP SOAP Client folder
4. Run: `npm install`
5. Run: `npm start`
6. Open browser to http://localhost:3000

---

## System Requirements

- **Windows 7 or newer** (Windows 10/11 recommended)
- **Choose one of the following**:
   - **Standalone EXE** (recommended if you cannot install Node.js)
   - **Node.js**: Download from https://nodejs.org/
      - LTS version (18.x or 20.x) recommended
      - The batch/PowerShell scripts will handle the rest

---

## Troubleshooting

### Problem: "I cannot install Node.js"
**Solution**: Use the standalone package that includes `SAP_SOAP_Client.exe`. The launch scripts will automatically use it if present.

### Problem: "Node.js is not installed"
**Solution**: Download and install Node.js from https://nodejs.org/, then run the script again.

### Problem: PowerShell execution policy error
**Solution**: 
1. Open PowerShell as Administrator
2. Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Type `Y` and press Enter
4. Run the `start.ps1` script again

### Problem: Port 3000 is already in use
**Solution**: The scripts automatically find another available port (3001, 3002, etc.)

### Problem: Browser doesn't open automatically
**Solution**: Manually open http://localhost:3000 in your browser (or the port shown in the console)

### Problem: "npm: command not found"
**Solution**: Node.js installation didn't add npm to PATH
1. Restart your computer
2. If still not working, reinstall Node.js

---

## File Structure

```
SAP_SOAP_Client/
├── start.bat              ← Double-click this (Windows Batch)
├── start.ps1              ← Double-click this (PowerShell)
├── server.js              ← Backend server
├── index.html             ← Web interface
├── package.json           ← Dependencies
└── README.md              ← Full documentation
```

---

## Features

✅ **No Installation Required** - Just double-click and run
✅ **Automatic Dependency Installation** - First run installs everything
✅ **Browser Auto-Launch** - Opens http://localhost:3000 automatically
✅ **Multiple Options** - Choose batch, PowerShell, or manual setup
✅ **Port Auto-Detection** - Finds available port automatically
✅ **Full SOAP Support** - Test SAP web services directly
✅ **PC Miler Integration** - Geocoding from address to coordinates
✅ **Saved Resources** - Persist resources across sessions
✅ **Credentials Management** - Secure credential storage

---

## Usage

Once the application opens in your browser:

1. **Configure SAP System**
   - Enter SAP System URL
   - Provide credentials
   - Configure PC Miler API Key (optional)

2. **Manage Resources**
   - Add resource ID and name
   - Save to local storage

3. **Add Position Data**
   - Select a saved resource
   - Enter address
   - Click "Get Coordinates from Address"
   - Coordinates auto-populate from PC Miler API

4. **Send SOAP Request**
   - Click "Send Request"
   - View response in right panel

---

## Support & Documentation

- Full documentation: See README.md
- API documentation: https://pcmiler.alk.com
- SAP RFC documentation: Contact your SAP administrator

---

## Tips

💡 **Save Your Credentials**: Click "Save Credentials" to persist settings across sessions

💡 **PC Miler API**: Configure your own API key in Configuration → PC Miler API Configuration

💡 **Multiple Positions**: Click "+ Add Position" to handle batch requests

💡 **Clear Data**: Use "Clear All" to reset all forms and start fresh

---

## Version

SAP SOAP Client v1.0.0
Built with Node.js, Express, and vanilla JavaScript
