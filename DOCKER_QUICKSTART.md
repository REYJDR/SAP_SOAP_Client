# 🐳 Docker Quick Start

## Install Docker

### Windows
1. Download: https://www.docker.com/products/docker-desktop
2. Install and restart computer
3. Verify: Open Command Prompt, run `docker --version`

### Mac
```bash
brew install docker docker-compose
# Or download from https://www.docker.com/products/docker-desktop
```

### Linux
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io docker-compose

# Start Docker service
sudo systemctl start docker
```

---

## 🚀 Run with Docker Compose (Easiest)

```bash
# Navigate to project
cd SAP_SOAP_Client

# Start container
docker-compose up --build

# Open browser
http://localhost:3000

# Stop container
docker-compose down
```

That's it! ✓

---

## 🎯 Common Commands

```bash
# View running containers
docker ps

# View all containers
docker ps -a

# View logs
docker logs -f <container-id>

# Stop container
docker stop <container-id>

# Remove container
docker rm <container-id>

# Clean up unused resources
docker system prune
```

---

## 📋 Docker vs Docker Compose

| | Docker | Docker Compose |
|---|--------|---|
| **Command** | `docker run` | `docker-compose up` |
| **Config** | Command line | docker-compose.yml file |
| **Simplicity** | Manual | Automated |
| **Best for** | Simple apps | Multi-service apps |

**For this project: Use Docker Compose** (easier)

---

## 🔧 Advanced Options

### Change Port
```bash
# Edit docker-compose.yml
ports:
  - "8080:3000"  # Use port 8080 instead of 3000

# Then: docker-compose up
```

### Production Setup
```bash
# Use production config with Nginx reverse proxy
docker-compose -f docker-compose.prod.yml up -d

# Access on port 80/443
http://localhost
```

### View Real-time Logs
```bash
docker-compose logs -f sap-soap-client
```

---

## 💾 Files Included

- **Dockerfile** - Container recipe
- **docker-compose.yml** - Basic setup (development)
- **docker-compose.prod.yml** - Production with Nginx
- **nginx.conf** - Reverse proxy config
- **.dockerignore** - Exclude files from image

---

## ✅ Verify It's Working

```bash
# Check if container is healthy
docker-compose ps

# Test API
curl http://localhost:3000/health

# View logs
docker-compose logs
```

---

**See DOCKER.md for complete documentation** 📚
