const express = require('express');
const https = require('https');
const http = require('http');
const fs = require('fs');
const path = require('path');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;
const CREDENTIALS_FILE = path.join(__dirname, '.credentials.json');

// Middleware
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.static(__dirname));

// SOAP Proxy Endpoint
app.post('/api/soap', (req, res) => {
    const { url, body, auth } = req.body;

    if (!url || !body) {
        return res.json({ success: false, error: 'URL and body are required' });
    }

    try {
        // Parse URL
        const urlObj = new URL(url);
        const isHttps = urlObj.protocol === 'https:';
        const protocol = isHttps ? https : http;

        // Prepare options
        const options = {
            hostname: urlObj.hostname,
            port: urlObj.port || (isHttps ? 443 : 80),
            path: urlObj.pathname + urlObj.search,
            method: 'POST',
            headers: {
                'Content-Type': 'text/xml; charset=UTF-8',
                'Content-Length': Buffer.byteLength(body),
                'SOAPAction': '',
                'sap-client': '400'
            },
            rejectUnauthorized: false // For self-signed certs
        };

        // Add authentication
        if (auth) {
            options.headers['Authorization'] = 'Basic ' + auth;
        }

        console.log(`[${new Date().toISOString()}] Sending SOAP request to:`, url);
        console.log('Request body:', body.substring(0, 200) + '...');

        // Make request
        const request = protocol.request(options, (response) => {
            let data = '';

            response.on('data', (chunk) => {
                data += chunk;
            });

            response.on('end', () => {
                console.log(`[${new Date().toISOString()}] Response status:`, response.statusCode);
                
                if (response.statusCode >= 200 && response.statusCode < 300) {
                    res.json({ success: true, body: data, status: response.statusCode });
                } else {
                    res.json({ 
                        success: false, 
                        error: `HTTP ${response.statusCode}`, 
                        response: data,
                        headers: response.headers
                    });
                }
            });
        });

        // Error handling
        request.on('error', (error) => {
            console.error(`[${new Date().toISOString()}] Request error:`, error.message);
            res.json({ 
                success: false, 
                error: error.message,
                details: error.toString()
            });
        });

        // Send request body
        request.write(body);
        request.end();

    } catch (error) {
        console.error(`[${new Date().toISOString()}] Server error:`, error.message);
        res.json({ 
            success: false, 
            error: error.message,
            stack: error.stack
        });
    }
});

// Credentials Endpoints
app.post('/api/credentials/save', (req, res) => {
    const { sapUrl, username, password } = req.body;

    if (!sapUrl || !username || !password) {
        return res.json({ success: false, error: 'All fields are required' });
    }

    try {
        const credentials = {
            sapUrl: sapUrl,
            username: username,
            password: password,
            savedAt: new Date().toISOString()
        };

        fs.writeFileSync(CREDENTIALS_FILE, JSON.stringify(credentials, null, 2), 'utf8');
        console.log(`[${new Date().toISOString()}] Credentials saved successfully`);
        res.json({ success: true, message: 'Credentials saved' });
    } catch (error) {
        console.error(`[${new Date().toISOString()}] Error saving credentials:`, error.message);
        res.json({ success: false, error: error.message });
    }
});

app.get('/api/credentials/load', (req, res) => {
    try {
        if (fs.existsSync(CREDENTIALS_FILE)) {
            const data = fs.readFileSync(CREDENTIALS_FILE, 'utf8');
            const credentials = JSON.parse(data);
            console.log(`[${new Date().toISOString()}] Credentials loaded successfully`);
            res.json({ success: true, data: credentials });
        } else {
            res.json({ success: true, data: null });
        }
    } catch (error) {
        console.error(`[${new Date().toISOString()}] Error loading credentials:`, error.message);
        res.json({ success: false, error: error.message });
    }
});

app.post('/api/credentials/clear', (req, res) => {
    try {
        if (fs.existsSync(CREDENTIALS_FILE)) {
            fs.unlinkSync(CREDENTIALS_FILE);
            console.log(`[${new Date().toISOString()}] Credentials cleared successfully`);
        }
        res.json({ success: true, message: 'Credentials cleared' });
    } catch (error) {
        console.error(`[${new Date().toISOString()}] Error clearing credentials:`, error.message);
        res.json({ success: false, error: error.message });
    }
});

// Serve index.html
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Health check
app.get('/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Start server
app.listen(PORT, () => {
    console.log(`
╔════════════════════════════════════════════════════════════════╗
║                  SAP SOAP Client Server                        ║
╠════════════════════════════════════════════════════════════════╣
║                                                                ║
║  🌐 Server running at: http://localhost:${PORT}                    
║  📝 Open your browser and navigate to http://localhost:${PORT}     
║                                                                ║
║  Features:                                                     ║
║  ✓ SOAP request builder                                       ║
║  ✓ Base64 UUID encoding                                       ║
║  ✓ HTTPS/HTTP proxy (ignores self-signed certs)              ║
║  ✓ SPNEGO/Kerberos compatible                                 ║
║  ✓ Real-time response display                                 ║
║                                                                ║
║  Quick Start:                                                 ║
║  1. Enter your SAP system URL                                 ║
║  2. Provide credentials                                       ║
║  3. Fill in position data                                     ║
║  4. Click "Send Request"                                      ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
    `);
});

// Graceful shutdown
process.on('SIGINT', () => {
    console.log('\nShutting down gracefully...');
    process.exit(0);
});
