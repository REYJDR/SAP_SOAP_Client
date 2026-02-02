#!/bin/bash

# Quick start script for SAP SOAP Client

if [ ! -f "package.json" ]; then
    echo "❌ Error: Run this script from the SAP_SOAP_Client directory"
    exit 1
fi

if [ ! -d "node_modules" ]; then
    echo "📦 First run - installing dependencies..."
    npm install
    echo ""
fi

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║            SAP SOAP Client - Starting Server                  ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

npm start
