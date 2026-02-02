#!/bin/bash

# SAP SOAP Client Setup Script
# Run this to quickly set up and start the server

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║        SAP SOAP Client - Quick Setup                           ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed."
    echo ""
    echo "To install Node.js:"
    echo "  macOS:   brew install node"
    echo "  Ubuntu:  sudo apt-get install nodejs npm"
    echo "  Windows: Download from https://nodejs.org/"
    exit 1
fi

echo "✓ Node.js found: $(node --version)"
echo "✓ npm found: $(npm --version)"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✓ Dependencies installed successfully"
    echo ""
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                  Setup Complete! 🎉                           ║"
    echo "╠════════════════════════════════════════════════════════════════╣"
    echo "║                                                                ║"
    echo "║  To start the server, run:                                    ║"
    echo "║  $ npm start                                                   ║"
    echo "║                                                                ║"
    echo "║  Then open your browser to:                                   ║"
    echo "║  http://localhost:3000                                        ║"
    echo "║                                                                ║"
    echo "║  Note: The server will wait for your SAP connection details   ║"
    echo "║        Enter them in the web interface                        ║"
    echo "║                                                                ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
else
    echo "❌ Failed to install dependencies"
    exit 1
fi
