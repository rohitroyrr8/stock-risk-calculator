# Docker Setup Guide

This guide explains how to build, run, and manage the Assessment Script using Docker.

## Table of Contents

- [Quick Start](#quick-start)
- [Using Docker Compose](#using-docker-compose)
- [Using Makefile](#using-makefile)
- [Docker Images](#docker-images)
- [Production Deployment](#production-deployment)
- [Troubleshooting](#troubleshooting)

## Quick Start

### Option 1: Using Docker Compose (Recommended)

```bash
# Build and run the application
docker-compose up -d

# View logs
docker-compose logs -f assessment-app

# Stop the application
docker-compose down
```

### Option 2: Using Makefile

```bash
# Build Docker image
make image-build

# Run with Docker Compose
make run-docker

# View logs
make logs

# Stop containers
make stop
```

### Option 3: Using Helper Script

```bash
chmod +x scripts/docker-helper.sh

# Build and run
./scripts/docker-helper.sh run

# View logs
./scripts/docker-helper.sh logs

# Cleanup
./scripts/docker-helper.sh clean
```

## Using Docker Compose

### Development

```bash
# Start the application
docker-compose up

# Start in background
docker-compose up -d

# View logs
docker-compose logs -f assessment-app

# Execute commands in container
docker-compose exec assessment-app bash

# Stop containers
docker-compose down

# Remove volumes too
docker-compose down -v
```

### Production

```bash
# Use production compose file
docker-compose -f docker-compose.prod.yml up -d

# With environment variables
export DOCKER_TAG=v1.0.0
docker-compose -f docker-compose.prod.yml up -d

# View logs
docker-compose -f docker-compose.prod.yml logs -f
```

## Using Makefile

### Available Commands

```bash
# View all available commands
make help

# Installation
make install          # Install dependencies
make install-dev      # Install with dev dependencies

# Local execution
make run              # Run application locally
make dev              # Install deps and run

# Testing
make test             # Run unit tests
make lint             # Check code style
make format           # Format code

# Docker operations
make image-build      # Build Docker image
make image-clean      # Remove Docker image
make run-docker       # Run with Docker Compose
make stop             # Stop containers
make logs             # View container logs
make shell            # Open shell in container

# Maintenance
make clean            # Clean temporary files
make venv             # Create Python virtual environment
```

## Docker Images

### Multi-Stage Build

The Dockerfile uses a multi-stage build process:

1. **Builder Stage**: Installs Python dependencies in a virtual environment
2. **Runtime Stage**: Copies only the virtual environment and application code

This approach:
- Reduces final image size
- Improves build performance
- Keeps dependencies isolated

### Image Information

```bash
# Build image
docker build -t assessment-script:latest .

# List images
docker images | grep assessment-script

# Remove image
docker rmi assessment-script:latest

# View image details
docker inspect assessment-script:latest
```

## Production Deployment

### Using Production Compose File

```bash
# Set up environment
cp .env.example .env

# Start production services
docker-compose -f docker-compose.prod.yml up -d

# Monitor health
docker-compose -f docker-compose.prod.yml ps

# View logs
docker-compose -f docker-compose.prod.yml logs -f
```

### Health Checks

The container includes a health check that runs every 30 seconds:

```bash
# Check container health
docker ps | grep assessment-script

# View health details
docker inspect --format='{{json .State.Health}}' assessment-script | python -m json.tool
```

### Resource Limits (Optional)

Add resource limits to `docker-compose.yml`:

```yaml
services:
  assessment-app:
    # ... existing config ...
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
```

## Troubleshooting

### Container won't start

```bash
# Check logs
docker-compose logs assessment-app

# Rebuild image
docker-compose build --no-cache

# Run with verbose output
docker-compose up (without -d flag)
```

### Module not found errors

```bash
# Rebuild image to ensure dependencies are installed
docker-compose build --no-cache

# Check installed packages in container
docker-compose exec assessment-app pip list
```

### Permission issues

```bash
# Make helper script executable
chmod +x scripts/docker-helper.sh

# Run with sudo if necessary
sudo docker-compose up -d
```

### Clean up everything

```bash
# Stop and remove containers
docker-compose down -v

# Remove images
docker-compose down --rmi all

# Prune all unused resources
docker system prune -a
```

## Environment Variables

See `.env.example` for available configuration options:

```bash
# Copy and modify
cp .env.example .env

# Use in compose
docker-compose --env-file .env up -d
```

## Building for Different Architectures

```bash
# Build for ARM64 (Apple Silicon, some cloud providers)
docker buildx build --platform linux/arm64 -t assessment-script:latest .

# Build for multiple architectures
docker buildx build --platform linux/amd64,linux/arm64 -t assessment-script:latest .
```

## Further Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Best Practices for Python Docker Images](https://docs.docker.com/language/python/build-images/)
