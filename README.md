# SAP SOAP Client - RES_POSITION_UPDATE

A lightweight web-based SOAP client for testing SAP Transportation Management `/SCMTMS/RES_POSITION_UPDATE` web service.

## Features

✓ **Easy to use** - No coding required, just fill in the form  
✓ **UUID Handling** - Automatically converts hex to Base64  
✓ **HTTPS Support** - Handles self-signed certificates  
✓ **SPNEGO/Kerberos** - Compatible with SAP SSO  
✓ **SOAP Request Builder** - Generates proper WSDL-compliant requests  
✓ **Real-time Response** - See full request/response in browser  
✓ **Multiple Positions** - Send batch updates in one request  

## Quick Start

### Option 1: Run with Node.js (Recommended)

```bash
# Navigate to project directory
cd SAP_SOAP_Client

# Install dependencies
npm install

# Start server
npm start

# Open browser
open http://localhost:3000
```

### Option 2: Use Python's Simple Server (No Dependencies)

```bash
cd SAP_SOAP_Client
python3 -m http.server 8000

# Then use a CORS proxy or postman for API calls
# Or use the provided curl script (see below)
```

## Usage

1. **Enter SAP Details**
   - SAP System URL (e.g., `https://sap-host:8443/sap/bc/srt/wsocdata/sap/...`)
   - Username
   - Password

2. **Add Position Data**
   - Resource ID (UUID as 32-char hex)
   - Timestamp (14-digit format: YYYYMMDDhhmmss)
   - Resource Name (max 40 chars)
   - Longitude (decimal)
   - Latitude (decimal)
   - Location UUID (UUID as 32-char hex)

3. **Send Request**
   - Click "Send Request"
   - Response appears on the right

## Configuration

### SAP Service URL Formats

**Standard SOAManager:**
```
https://sap-host.realm.com:8443/sap/bc/srt/wsocdata/sap/ZYTM_UPDATE_RES_POSITION
```

**With Path Prefix:**
```
https://sap-host.realm.com:8443/sap/bc/srt/wsdl_flv_001/sap/ZYTM_UPDATE_RES_POSITION
```

### Authentication Methods

- **Basic Auth** - Username/Password (HTTP Basic)
- **SPNEGO/Kerberos** - Run `kinit` first, server handles negotiation
- **SAP Client** - Header `sap-client: 400` is added automatically

## Data Field Reference

### UUID Fields (RESOURCE_ID, LOCATION_UUID)

Input format: **32-character hexadecimal string**

Example:
```
Input:  005056043C401EEBA0CAB30F10DB978E
Converts to Base64: AFVQBDwAHrosCsMLENuXjg==
```

### Timestamp

Format: **14-digit decimal** (YYYYMMDDhhmmss)

Examples:
```
20260202003807  →  Feb 2, 2026 at 00:38:07
20260215143000  →  Feb 15, 2026 at 14:30:00
```

### Coordinates

Format: **Decimal degrees** (±0.000001 precision)

Examples:
```
Longitude: 9.278645   (degrees East/West)
Latitude:  53.199566  (degrees North/South)
```

## Testing

### Test Data

Position 1:
```
Resource ID: 005056043C401EEBA0CAB30F10DB978E
Timestamp: 20260202003807
Name: TM2FTL-00
Longitude: 9.278645
Latitude: 53.199566
Location UUID: 005056043C401EEBA0CAB30F10DB978E
```

Position 2:
```
Resource ID: 005056043C401EEBA0CAB30F10DB978F
Timestamp: 20260202003808
Name: TM2FTL-01
Longitude: 9.597519
Latitude: 53.383018
Location UUID: 005056043C401EEBA0CAB30F10DB978F
```

### Using cURL

```bash
# Generate SOAP request
cat > request.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
    <soapenv:Header/>
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

# Send via curl (with SPNEGO)
curl -v --negotiate --user : \
  -H "Content-Type: text/xml" \
  -H "sap-client: 400" \
  -H "SOAPAction: " \
  -d @request.xml \
  https://sap-host.realm.com:8443/sap/bc/srt/wsocdata/sap/ZYTM_UPDATE_RES_POSITION

# Or with basic auth
curl -v -u username:password \
  -H "Content-Type: text/xml" \
  -H "sap-client: 400" \
  -H "SOAPAction: " \
  -d @request.xml \
  https://sap-host.realm.com:8443/sap/bc/srt/wsocdata/sap/ZYTM_UPDATE_RES_POSITION
```

## Troubleshooting

### "401 Unauthorized"
- ✓ Check username/password
- ✓ Verify SAP client is reachable: `ping sap-host`
- ✓ For SPNEGO: run `kinit username@REALM` first
- ✓ Check SAP transaction code `/nSOAMANAGER` - is service active?

### "Connection Refused"
- ✓ Verify SAP host and port are correct
- ✓ Check firewall rules
- ✓ Test with: `telnet sap-host 8443`

### "UUID must be 32 hex characters"
- ✓ Enter UUID as 32-character hex string (no dashes)
- ✓ Example: `005056043C401EEBA0CAB30F10DB978E` ✓
- ✓ Bad example: `00505604-3C40-1EEB-A0CA-B30F10DB978E` ✗

### Server Error (500)
- ✓ Check SAP error log: Transaction `SLG1` with timestamp
- ✓ Verify function module `/SCMTMS/RES_POSITION_UPDATE` exists
- ✓ Check required fields are populated
- ✓ Ensure data types match (floats for coordinates, etc)

## Advanced

### Environment Variables

```bash
PORT=3000          # Server port (default 3000)
NODE_DEBUG=*       # Enable debug logging
```

### Disable SSL Verification (Development Only)

The server is already configured to ignore self-signed certificates.  
For client-side, modify `server.js`:

```javascript
rejectUnauthorized: false  // Already enabled
```

### Custom Headers

Edit `server.js` in the options object:

```javascript
headers: {
    'Custom-Header': 'value',
    'sap-client': '400'
}
```

## Files

```
SAP_SOAP_Client/
├── index.html      → Web UI (open this in browser)
├── server.js       → Express.js proxy server
├── package.json    → Node.js dependencies
└── README.md       → This file
```

## Notes

- **CORS**: Server proxies requests to avoid browser CORS restrictions
- **Encoding**: UUIDs are automatically Base64-encoded from hex input
- **Timestamps**: Must be in 14-digit decimal format
- **Coordinates**: Use standard decimal degree notation
- **Client**: SAP client 400 is hardcoded - modify in `server.js` if needed

## Support

For issues with:
- **Web UI** → Check browser console (F12)
- **SOAP Request** → Copy request from response panel, test in SOAP UI
- **SAP Connection** → Check `/nSLG1` in SAP for error details
- **Authentication** → Verify kinit ticket: `klist`

---

**Built for SAP Transportation Management (TM) 9.x+**  
**Compatible with SPNEGO, Kerberos, and Basic Authentication**
