# 🚀 SAP SOAP Client - Complete Setup Guide

## What You Have

I've created a complete **local web-based SOAP client** for testing `/SCMTMS/RES_POSITION_UPDATE`. No server or SAP configuration needed - just fill in the form and send!

### Files Created:
```
SAP_SOAP_Client/
├── index.html          → Beautiful web UI (fill this out)
├── server.js           → Node.js backend (proxies SOAP calls)
├── package.json        → Dependencies list
├── setup.sh            → One-time setup script
├── start.sh            → Run this to start
└── README.md           → Full documentation
```

---

## ⚡ Quick Start (5 minutes)

### Step 1: Navigate to Project
```bash
cd /Users/reydaou/Documents/SAP_SOAP_Client
```

### Step 2: Install Dependencies (First Time Only)
```bash
npm install
# or run the setup script
bash setup.sh
```

### Step 3: Start Server
```bash
npm start
# or use the start script
bash start.sh
```

You'll see:
```
╔════════════════════════════════════════════════════════════════╗
║                  SAP SOAP Client Server                        ║
╠════════════════════════════════════════════════════════════════╣
║                                                                ║
║  🌐 Server running at: http://localhost:3000                  ║
║  📝 Open your browser and navigate to http://localhost:3000   ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
```

### Step 4: Open in Browser
```bash
open http://localhost:3000
```

Or manually navigate to: **http://localhost:3000**

---

## 📝 How to Use

### 1. Enter SAP Details (Left Side)

**SAP System URL:**
```
https://sap-host.your-realm.com:8443/sap/bc/srt/wsocdata/sap/ZYTM_UPDATE_RES_POSITION
```

**Username:** Your SAP user  
**Password:** Your SAP password  

### 2. Add Position Data

Fill in each field:
- **Resource ID**: 32-character hex UUID (automatic Base64 conversion)
- **Timestamp**: 14-digit format (YYYYMMDDhhmmss) - auto-filled with current time
- **Resource Name**: Max 40 characters
- **Longitude**: Decimal (e.g., 9.278645)
- **Latitude**: Decimal (e.g., 53.199566)
- **Location UUID**: 32-character hex UUID

### 3. Send Request

Click **"Send Request"** button

- Response appears on the right side
- See full SOAP request and server response
- Any errors are displayed clearly

### 4. Add More Positions (Optional)

Click **"+ Add Position"** to send multiple records in one batch

### 5. Clear All (Optional)

Click **"Clear All"** to reset the form

---

## 📚 Example Data

### Position 1
```
Resource ID:  005056043C401EEBA0CAB30F10DB978E
Timestamp:    20260202003807
Name:         TM2FTL-00
Longitude:    9.278645
Latitude:     53.199566
Location UUID: 005056043C401EEBA0CAB30F10DB978E
```

### Position 2
```
Resource ID:  005056043C401EEBA0CAB30F10DB978F
Timestamp:    20260202003808
Name:         TM2FTL-01
Longitude:    9.597519
Latitude:     53.383018
Location UUID: 005056043C401EEBA0CAB30F10DB978F
```

---

## 🔑 Key Features

✅ **Automatic UUID Conversion**
- Enter as 32-char hex: `005056043C401EEBA0CAB30F10DB978E`
- Sends as Base64: `AFVQBDwAHrosCsMLENuXjg==`

✅ **SPNEGO/Kerberos Support**
- Run `kinit username@REALM` before starting
- Server automatically negotiates Kerberos

✅ **HTTPS Handling**
- Works with self-signed SAP certificates
- No SSL warnings or errors

✅ **Batch Updates**
- Send multiple positions in one SOAP request
- Add/remove positions with ease

✅ **Real-time Feedback**
- See exactly what's being sent
- See exact response from SAP
- Error messages are clear

---

## 🔧 Troubleshooting

### "Connection refused"
```bash
# Check if server is running
curl http://localhost:3000

# If not, restart:
npm start
```

### "401 Unauthorized"
- ✓ Check username/password
- ✓ Verify SAP user exists in system
- ✓ For SPNEGO: run `kinit username@REALM` first

### "Cannot reach SAP host"
```bash
# Test connectivity
ping sap-host.your-realm.com
telnet sap-host.your-realm.com 8443

# Check URL format in the web form
```

### "UUID must be 32 hex characters"
- ✓ Remove any dashes: `00505604-3C40-1EEB...` → `005056043C401EEB...`
- ✓ Use uppercase letters
- ✓ Total length must be exactly 32 characters

### "Web page won't load"
```bash
# Make sure server is running
npm start

# Check port 3000 is available
lsof -i :3000

# Try different port
PORT=3001 npm start
```

---

## 🛠️ Advanced Usage

### Use Different Port
```bash
PORT=8080 npm start
# Then open: http://localhost:8080
```

### Enable Debug Logging
```bash
NODE_DEBUG=* npm start
```

### Test with cURL (Without Web UI)
```bash
# Generate request
cat > request.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
    <soapenv:Body>
        <urn:_-SCMTMS_-RES_POSITION_UPDATE>
            <IT_RESOURCE_POSITIONS>
                <item>
                    <RESOURCE_ID>AFVQBDwAHrosCsMLENuXjg==</RESOURCE_ID>
                    <TIMESTAMP>20260202003807</TIMESTAMP>
                    <RESOURCE_NAME>TM2FTL-00</RESOURCE_NAME>
                    <LONGITUDE>9.278645</LONGITUDE>
                    <LATITUDE>53.199566</LATITUDE>
                    <LOCATION_UUID>AFVQBDwAHrosCsMLENuXjg==</LOCATION_UUID>
                </item>
            </IT_RESOURCE_POSITIONS>
        </urn:_-SCMTMS_-RES_POSITION_UPDATE>
    </soapenv:Body>
</soapenv:Envelope>
EOF

# Send request with basic auth
curl -v -u username:password \
  -H "Content-Type: text/xml" \
  -H "sap-client: 400" \
  -H "SOAPAction: " \
  -d @request.xml \
  https://sap-host.realm.com:8443/sap/bc/srt/wsocdata/sap/ZYTM_UPDATE_RES_POSITION

# Or with SPNEGO
curl -v --negotiate --user : \
  -H "Content-Type: text/xml" \
  -H "sap-client: 400" \
  -d @request.xml \
  https://sap-host.realm.com:8443/sap/bc/srt/wsocdata/sap/ZYTM_UPDATE_RES_POSITION
```

---

## 📖 What Happens Behind the Scenes

1. **You fill in the form** → Web browser collects data
2. **Click Send** → Browser sends data to Node.js server
3. **Server validates** → Checks all fields are present
4. **Converts UUIDs** → Hex → Base64 encoding
5. **Builds SOAP envelope** → Creates proper XML structure per WSDL
6. **Adds auth** → Includes username/password as Basic Auth
7. **Opens HTTPS connection** → Connects to SAP system
8. **Sends SOAP request** → Raw XML over HTTPS
9. **Gets response** → SAP returns result XML
10. **Shows in browser** → You see success/error message

---

## 📋 File Descriptions

| File | Purpose |
|------|---------|
| `index.html` | Beautiful web form - **the interface you use** |
| `server.js` | Express.js backend - proxies requests to SAP |
| `package.json` | Lists dependencies (express, cors) |
| `setup.sh` | Installation helper script |
| `start.sh` | Start script wrapper |
| `README.md` | Complete technical documentation |
| `QUICKSTART.md` | This file - quick reference |

---

## 🎯 Next Steps

1. **Run setup** (first time only):
   ```bash
   bash setup.sh
   ```

2. **Start server**:
   ```bash
   bash start.sh
   # or: npm start
   ```

3. **Open browser**:
   ```bash
   open http://localhost:3000
   ```

4. **Fill in your details**:
   - SAP URL
   - Username & Password
   - Position data

5. **Send request** and see results!

---

## 🆘 Need Help?

- **Check README.md** for detailed docs
- **Look at browser console** (F12) for errors
- **Check server terminal output** for debug info
- **Test SAP connectivity**: `ping your-sap-host`
- **Verify credentials**: Test in SAP GUI first

---

**You're all set! 🎉**

Start the server and point your browser to `http://localhost:3000`
