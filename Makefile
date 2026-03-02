.PHONY: help build build-prod run run-docker stop clean install test lint format dev prod image-build image-push image-clean

# Variables
DOCKER_IMAGE := assessment-script
DOCKER_REGISTRY := docker.io
DOCKER_USERNAME ?= $(shell echo $$DOCKER_USERNAME)
VENV := venv
PYTHON := python3
PIP := pip

help:
	@echo "Assessment Script - Available Commands"
	@echo "======================================"
	@echo ""
	@echo "Development:"
	@echo "  make install       Install dependencies"
	@echo "  make run           Run the application locally"
	@echo "  make dev           Run in development mode"
	@echo "  make test          Run tests"
	@echo "  make lint          Check code style"
	@echo "  make format        Format code"
	@echo "  make clean         Clean up temporary files"
	@echo ""
	@echo "Docker:"
	@echo "  make image-build   Build Docker image"
	@echo "  make image-clean   Remove Docker image"
	@echo "  make run-docker    Run using Docker Compose"
	@echo "  make stop          Stop Docker containers"
	@echo ""
	@echo "Production:"
	@echo "  make prod          Build production image"
	@echo "  make image-push    Push image to registry (requires credentials)"
	@echo ""

# Installation targets
install:
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r logic/requirements.txt

install-dev:
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r logic/requirements.txt

# Local execution
run:
	$(PYTHON) main.py

dev:
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r logic/requirements.txt
	$(PYTHON) main.py

# Testing and code quality
test:
	@if [ -f logic/test_risk_calculation.py ]; then \
		$(PYTHON) -m pytest logic/test_risk_calculation.py -v; \
	elif [ -f logic/test_risk.py ]; then \
		$(PYTHON) -m pytest logic/test_risk.py -v; \
	else \
		echo "No test files found"; \
	fi

lint:
	@echo "Running code lint checks..."
	@$(PYTHON) -m pylint logic/ main.py || echo "pylint not installed. Install with: pip install pylint"

format:
	@echo "Formatting code..."
	@$(PYTHON) -m black . || echo "black not installed. Install with: pip install black"

# Docker targets
image-build:
	docker build -t $(DOCKER_IMAGE):latest -t $(DOCKER_IMAGE):$$(date +%Y%m%d%H%M%S) .

image-prod: image-build
	@echo "Production image built: $(DOCKER_IMAGE):latest"

image-clean:
	docker rmi $(DOCKER_IMAGE):latest

run-docker: image-build
	docker-compose up -d

stop:
	docker-compose down

logs:
	docker-compose logs -f assessment-app

shell:
	docker-compose exec assessment-app /bin/bash

# Utility targets
clean:
	@echo "Cleaning up..."
	rm -rf __pycache__ .pytest_cache .coverage htmlcov
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	rm -rf $(VENV)
	@echo "Clean complete"

venv:
	$(PYTHON) -m venv $(VENV)
	. $(VENV)/bin/activate && pip install --upgrade pip

.DEFAULT_GOAL := help
