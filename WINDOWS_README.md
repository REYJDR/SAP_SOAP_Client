# SAP SOAP Client - Windows Standalone Edition

A lightweight SOAP web service client for testing SAP RFC services on Windows. Supports **Standalone EXE** (no Node.js install) or **Node.js** mode.

## 🚀 What You Need

Choose one of the following:

- **Standalone EXE** (no installation required)
- **Node.js** (if you don't have the EXE)

- **Operating System**: Windows 7 or newer (Windows 10/11 recommended)
- **Node.js** (if needed): Download from https://nodejs.org/ (LTS version 18.x or 20.x)
- **Storage**: ~200 MB
- **RAM**: 512 MB minimum, 2 GB recommended

## ⚡ Quick Start (30 seconds)

1. **If you have the Standalone EXE**
   - Extract the ZIP
   - Double-click `start.ps1` or `start.bat`

2. **If you do NOT have the EXE (Node.js mode)**
   - Install Node.js from https://nodejs.org/
   - Run installer, restart computer

3. **Run the Application**
   - Double-click `start.ps1` (Windows 10/11) 
   - OR double-click `start.bat` (any Windows version)
   - Wait 1-2 minutes (first run installs dependencies)
   - Browser opens automatically

3. **Use the Application**
   - Enter SAP credentials
   - Configure PC Miler API (optional)
   - Test your SOAP services

## 📂 Files in This Package

```
SAP_SOAP_Client/
│
├── 🚀 START_HERE.txt              ← Read this first!
├── start.ps1                      ← Launcher for PowerShell (Windows 10/11)
├── start.bat                      ← Launcher for Batch (all Windows)
│
├── 📖 WINDOWS_QUICKSTART.txt      ← Quick start guide
├── WINDOWS_INSTALLATION.md        ← Detailed setup guide
│
├── server.js                      ← Backend Node.js server
├── index.html                     ← Web interface
├── package.json                   ← Dependencies configuration
│
└── .credentials.json              ← Saved credentials (auto-created)
```

## 🎯 How It Works

```
┌─────────────────────────────────────┐
│  double-click start.ps1/start.bat   │
└────────────────┬────────────────────┘
                 │
                 ├─ Check Node.js installed ✓
                 │
                 ├─ Install dependencies (npm packages)
                 │
                 ├─ Start Node.js server on http://localhost:3000
                 │
                 └─ Open browser automatically
                    │
                    ├─ Load index.html
                    │
                    ├─ Configure SAP system & PC Miler API
                    │
                    ├─ Build SOAP requests
                    │
                    └─ View responses
```

## 💻 Two Ways to Run

### Method 1: PowerShell Script (Recommended)
**For Windows 10/11 users**
```
Double-click: start.ps1
```

If you get an execution policy error:
1. Open PowerShell as Administrator
2. Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Type: Y and press Enter
4. Double-click `start.ps1` again

### Method 2: Batch Script
**Works on all Windows versions**
```
Double-click: start.bat
```

### Method 3: Manual (Command Prompt)
```powershell
# Open Command Prompt or PowerShell
cd C:\path\to\SAP_SOAP_Client
npm install
npm start
# Open: http://localhost:3000
```

## ⚙️ Features

### 🔧 SOAP Web Service Testing
- Build SOAP requests graphically
- Test SAP RFC services
- View full request/response
- Support for multiple positions

### 📍 Geocoding Integration
- Convert addresses to coordinates
- PC Miler ALK API integration
- Auto-populate latitude/longitude
- Support for international addresses

### 💾 Resource Management
- Save frequently used resources
- Quick selection from dropdown
- Persistent storage (browser localStorage)
- Import/export capabilities

### 🔐 Credentials
- Save SAP credentials locally
- Secure local storage only
- One-click clear option
- Never sent to external servers

### ⚡ Performance
- Lightweight (~5 MB with dependencies)
- Fast startup (< 3 seconds after first run)
- Real-time response display
- Instant resource switching

## 🛠️ Troubleshooting

| Problem | Solution |
|---------|----------|
| **"Node.js is not installed"** | Download from https://nodejs.org/ and install LTS version |
| **PowerShell execution error** | Run in Admin PowerShell: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| **Port 3000 in use** | Script auto-uses 3001, 3002, etc. Check console for port |
| **Browser won't auto-open** | Manually visit http://localhost:3000 |
| **Dependencies fail** | Delete `node_modules` folder and run script again |
| **npm not found** | Restart computer after installing Node.js |
| **Credentials don't save** | Check browser developer console (F12) for errors |

## 📋 System Compatibility

| Feature | Windows 7 | Windows 8 | Windows 10 | Windows 11 |
|---------|-----------|-----------|-----------|-----------|
| Batch Launcher | ✅ | ✅ | ✅ | ✅ |
| PowerShell Launcher | ✅ | ✅ | ✅ | ✅ |
| Credentials Storage | ✅ | ✅ | ✅ | ✅ |
| Geocoding | ✅ | ✅ | ✅ | ✅ |
| Browser Integration | ✅ | ✅ | ✅ | ✅ |

## 🔒 Security Notes

- Credentials stored **locally only** (browser localStorage)
- No data sent to external servers except:
  - SAP system (your own)
  - PC Miler API (for geocoding)
- All communication via HTTPS when available
- No telemetry or analytics

## 🎓 Usage Examples

### Example 1: Save a Resource
```
1. Expand "📦 Saved Resources"
2. Enter:
   - Resource ID: 005056043C401EEBA0CAB30F10DB978E
   - Resource Name: TM2FTL-00
3. Click "💾 Save New Resource"
```

### Example 2: Geocode an Address
```
1. Enter address fields:
   - Street: 123 Main Street
   - City: New York
   - State: NY
   - Country: US
   - Postcode: 10001
2. Click "Get Coordinates from Address"
3. Coordinates auto-populate
```

### Example 3: Send SOAP Request
```
1. Configure SAP credentials
2. Add position(s)
3. Click "Send Request"
4. View response in right panel
```

## 📊 Performance Tips

💡 **Save Credentials**: Click "Save Credentials" to avoid re-entering them

💡 **Batch Requests**: Add multiple positions at once with "+ Add Position"

💡 **Reuse Resources**: Save frequently used resources to dropdown

💡 **API Key**: Cache your PC Miler API key for faster geocoding

## 🆘 Getting Help

1. **Quick Issues**: Check START_HERE.txt
2. **Setup Problems**: Read WINDOWS_INSTALLATION.md
3. **Application Errors**: Press F12 for browser developer tools
4. **Console Output**: Check command prompt/PowerShell for error messages

## 📦 What Gets Installed

On first run, the scripts install:
- **express**: Web framework (~50 KB)
- **cors**: Cross-origin support (~10 KB)
- Supporting files: ~100 KB

**Total**: ~200 MB with Node.js runtime

## 🔄 Updating

To update to the latest version:
1. Delete the `node_modules` folder
2. Run `start.bat` or `start.ps1` again
3. It will install fresh dependencies

## 📝 License

MIT License - Free to use and modify

## 🎉 Ready to Go?

1. Install Node.js: https://nodejs.org/
2. Double-click `start.ps1` or `start.bat`
3. Wait for browser to open
4. Start testing!

---

**Version**: 1.0.0
**Last Updated**: February 2, 2026
**Supports**: Windows 7, 8, 10, 11
**Requires**: Node.js 14+ (18/20 LTS recommended)

For detailed information, see **WINDOWS_INSTALLATION.md**
