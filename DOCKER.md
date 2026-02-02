# Docker Setup Guide - SAP SOAP Client

## 📦 What is Docker?

Docker packages your application and all dependencies into a **container** - think of it as a lightweight virtual machine that runs anywhere (Windows, Mac, Linux).

---

## ⚙️ Prerequisites

### Windows / Mac / Linux

1. **Download Docker Desktop**
   - Go to https://www.docker.com/products/docker-desktop
   - Download for your OS
   - Install and run

2. **Verify Installation**
   ```bash
   docker --version
   docker run hello-world
   ```

---

## 🚀 Quick Start with Docker

### Option 1: Using Docker Compose (Easiest)

```bash
# Navigate to project directory
cd SAP_SOAP_Client

# Build and start container
docker-compose up --build

# Open browser
http://localhost:3000
```

**That's it!** Container is running.

To stop:
```bash
docker-compose down
```

---

### Option 2: Using Docker Directly

```bash
# Build the image
docker build -t sap-soap-client .

# Run the container
docker run -p 3000:3000 sap-soap-client

# Open browser
http://localhost:3000
```

---

## 📋 Commands Reference

### Build
```bash
# Build image with tag
docker build -t sap-soap-client:latest .

# Build with specific Node version
docker build --build-arg NODE_VERSION=18 -t sap-soap-client .
```

### Run
```bash
# Basic run
docker run -p 3000:3000 sap-soap-client

# Run in background (detached)
docker run -d -p 3000:3000 --name sap-client sap-soap-client

# Run with custom port
docker run -p 8080:3000 sap-soap-client

# Run with environment variable
docker run -p 3000:3000 -e NODE_ENV=development sap-soap-client

# Run with volume mount (for logs)
docker run -p 3000:3000 -v $(pwd)/logs:/app/logs sap-soap-client
```

### Manage Containers
```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop container
docker stop <container-id>

# Start container
docker start <container-id>

# View logs
docker logs <container-id>

# View logs in real-time
docker logs -f <container-id>

# Execute command in container
docker exec -it <container-id> sh

# Remove container
docker rm <container-id>

# Remove image
docker rmi sap-soap-client
```

---

## 🐳 Docker Compose Commands

### Start Services
```bash
# Build and start (foreground)
docker-compose up --build

# Start in background
docker-compose up -d --build

# Start without rebuilding
docker-compose up

# Start in background
docker-compose up -d
```

### Stop Services
```bash
# Stop containers (keep them)
docker-compose stop

# Stop and remove containers
docker-compose down

# Stop and remove everything including volumes
docker-compose down -v
```

### View Logs
```bash
# View logs
docker-compose logs

# Follow logs in real-time
docker-compose logs -f

# View logs for specific service
docker-compose logs sap-soap-client

# Follow specific service
docker-compose logs -f sap-soap-client
```

### Status
```bash
# View running services
docker-compose ps

# View service status
docker-compose status

# Health check
curl http://localhost:3000/health
```

---

## 📁 File Structure

```
SAP_SOAP_Client/
├── Dockerfile              ← Container recipe
├── docker-compose.yml      ← Orchestration config
├── .dockerignore           ← Exclude files from image
├── index.html              ← Web UI
├── server.js               ← Node.js app
├── package.json
├── README.md
└── DOCKER.md               ← This file
```

---

## 🔧 Configuration

### Change Port

**In docker-compose.yml:**
```yaml
ports:
  - "8080:3000"  # Access on port 8080
```

Or with docker run:
```bash
docker run -p 8080:3000 sap-soap-client
```

### Custom Environment Variables

**In docker-compose.yml:**
```yaml
environment:
  - NODE_ENV=production
  - PORT=3000
  - LOG_LEVEL=debug
```

Or with docker run:
```bash
docker run -p 3000:3000 \
  -e NODE_ENV=production \
  -e LOG_LEVEL=debug \
  sap-soap-client
```

### Mount Volumes

**For persistent logs:**
```bash
docker run -p 3000:3000 \
  -v $(pwd)/logs:/app/logs \
  sap-soap-client
```

---

## 🐛 Troubleshooting

### Container won't start
```bash
# View logs
docker logs <container-id>

# Check if port is in use
netstat -an | grep 3000  # Mac/Linux
netstat -ano | findstr :3000  # Windows

# Use different port
docker run -p 8080:3000 sap-soap-client
```

### Permission denied
```bash
# On Mac/Linux, might need sudo
sudo docker ps

# Or add user to docker group
sudo usermod -aG docker $USER
```

### Docker daemon not running
- Open Docker Desktop application
- Wait for it to fully start
- Try again

### Container keeps restarting
```bash
# View logs for errors
docker logs <container-id>

# Run interactively to debug
docker run -it sap-soap-client sh

# Inside container, test
node server.js
```

---

## 📊 Docker Compose Advanced

### Multiple Services Example

```yaml
version: '3.8'

services:
  sap-soap-client:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - logs-server
    environment:
      - LOG_SERVER=logs-server:8000
  
  logs-server:
    image: nginx:alpine
    ports:
      - "8001:80"
    volumes:
      - ./logs:/usr/share/nginx/html/logs:ro
```

### Resource Limits

```yaml
deploy:
  resources:
    limits:
      cpus: '1'
      memory: 1G
    reservations:
      cpus: '0.5'
      memory: 512M
```

---

## 🔐 Security Best Practices

### Don't Include Secrets
```bash
# ❌ BAD - Don't do this
docker run -e SAP_PASSWORD=mypassword sap-soap-client

# ✅ GOOD - Use .env file
docker run --env-file .env sap-soap-client
```

### Create .env file
```
SAP_PASSWORD=your-password
SAP_USERNAME=your-username
```

### Use Environment File in Compose
```yaml
services:
  sap-soap-client:
    env_file: .env
```

### Keep Image Small
- Use Alpine Linux base (already done)
- Exclude unnecessary files (.dockerignore)
- Install only production dependencies

---

## 📈 Production Deployment

### Push to Docker Registry

```bash
# Login to Docker Hub
docker login

# Tag image
docker tag sap-soap-client:latest username/sap-soap-client:latest

# Push to Docker Hub
docker push username/sap-soap-client:latest

# Use from registry
docker run username/sap-soap-client:latest
```

### Deploy to Kubernetes
```bash
# Create deployment file (deployment.yaml)
kubectl apply -f deployment.yaml

# View deployment
kubectl get deployments
kubectl logs -f deployment/sap-soap-client
```

---

## 🛠️ Build Multi-Platform Images

```bash
# Build for multiple platforms
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t username/sap-soap-client:latest \
  --push .
```

---

## 📝 Complete Workflow

### Development
```bash
# Start with docker-compose
docker-compose up --build

# Make changes to code
# Container auto-reloads if you mounted volumes

# Stop when done
docker-compose down
```

### Testing
```bash
# Build image
docker build -t sap-soap-client:test .

# Run tests
docker run sap-soap-client:test npm test

# Check coverage
docker run sap-soap-client:test npm run coverage
```

### Production
```bash
# Build final image
docker build -t sap-soap-client:1.0.0 .

# Tag for registry
docker tag sap-soap-client:1.0.0 myregistry/sap-soap-client:1.0.0

# Push
docker push myregistry/sap-soap-client:1.0.0

# Deploy
docker run -d \
  --restart always \
  -p 80:3000 \
  --name sap-client-prod \
  myregistry/sap-soap-client:1.0.0
```

---

## 📚 Useful Docker Tips

### View Image Size
```bash
docker images sap-soap-client
```

### Inspect Image
```bash
docker inspect sap-soap-client:latest
```

### Interactive Shell
```bash
docker exec -it <container-id> /bin/sh
docker exec -it <container-id> npm list
```

### Health Status
```bash
# Check health
docker inspect --format='{{.State.Health.Status}}' <container-id>

# View health details
docker inspect <container-id> | grep -A 5 Health
```

---

## 🎯 Quick Reference Cheat Sheet

```bash
# Build and run
docker build -t sap-soap-client .
docker run -p 3000:3000 sap-soap-client

# Or with compose
docker-compose up --build

# View what's running
docker ps

# View logs
docker logs <id>

# Stop
docker stop <id>

# Clean up
docker system prune
```

---

## 🚀 Next Steps

1. **Install Docker** from https://www.docker.com/
2. **Navigate to project**: `cd SAP_SOAP_Client`
3. **Start**: `docker-compose up --build`
4. **Access**: http://localhost:3000
5. **Stop**: `docker-compose down`

That's it! Your app is containerized. 🎉
