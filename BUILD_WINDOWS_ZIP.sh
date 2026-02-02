#!/bin/bash
# Script to create Windows distribution ZIP for SAP SOAP Client

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  SAP SOAP Client - Windows Distribution ZIP Builder       ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

echo "Current location: $SCRIPT_DIR"
echo ""

# Check if we're in the right directory
if [ ! -f "$SCRIPT_DIR/package.json" ]; then
    echo "❌ Error: package.json not found"
    echo "Please run this script from the SAP_SOAP_Client directory"
    exit 1
fi

echo "Creating Windows distribution ZIP file..."
echo ""

# Create the ZIP file, excluding unnecessary directories
zip -r "$PARENT_DIR/SAP_SOAP_Client.zip" "$SCRIPT_DIR" \
  -x "$SCRIPT_DIR/node_modules/*" \
  -x "$SCRIPT_DIR/dist/*" \
  -x "$SCRIPT_DIR/.git/*" \
  -x "$SCRIPT_DIR/.dockerignore" \
  -x "$SCRIPT_DIR/Dockerfile*" \
  -x "$SCRIPT_DIR/docker-compose*" \
  -x "$SCRIPT_DIR/setup.sh" \
  -x "$SCRIPT_DIR/start.sh" \
  -x "$SCRIPT_DIR/*.sty"

echo ""
echo "✅ ZIP file created successfully!"
echo ""

# Show file info
ls -lh "$PARENT_DIR/SAP_SOAP_Client.zip"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                     NEXT STEPS                             ║"
echo "╠════════════════════════════════════════════════════════════╣"
echo "║                                                            ║"
echo "║  1. Test on Windows computer:                             ║"
echo "║     - Extract the ZIP                                     ║"
echo "║     - Double-click start.bat or start.ps1                 ║"
echo "║     - Verify Node.js prompt and browser opens             ║"
echo "║                                                            ║"
echo "║  2. Upload to distribution platform:                      ║"
echo "║     - GitHub Releases (recommended)                       ║"
echo "║     - OneDrive/Google Drive                               ║"
echo "║     - Your web server                                     ║"
echo "║                                                            ║"
echo "║  3. Share with users:                                     ║"
echo "║     - ZIP download link                                   ║"
echo "║     - Node.js link: https://nodejs.org/                   ║"
echo "║     - First readme: START_HERE.txt                        ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
