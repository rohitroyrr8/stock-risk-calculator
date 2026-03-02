#!/bin/bash

# Helper script to manage Docker containers

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to build the Docker image
build_image() {
    log_info "Building Docker image..."
    docker build -t assessment-script:latest .
    log_info "Build complete!"
}

# Function to run the container
run_container() {
    log_info "Starting container with docker-compose..."
    docker-compose up -d
    log_info "Container started!"
}

# Function to stop the container
stop_container() {
    log_info "Stopping container..."
    docker-compose down
    log_info "Container stopped!"
}

# Function to view logs
view_logs() {
    log_info "Displaying logs..."
    docker-compose logs -f assessment-app
}

# Function to run tests in Docker
run_tests() {
    log_info "Running tests in Docker..."
    docker-compose exec assessment-app python -m pytest logic/ -v
}

# Function to clean up
cleanup() {
    log_info "Cleaning up Docker resources..."
    docker-compose down -v
    docker system prune -f
    log_info "Cleanup complete!"
}

# Print help
print_help() {
    cat << EOF
Docker Helper Script for Assessment Script

Usage: $0 [COMMAND]

Commands:
    build       Build the Docker image
    run         Start the container with docker-compose
    stop        Stop the container
    logs        View container logs
    test        Run tests in Docker
    clean       Clean up Docker resources
    help        Show this help message

Examples:
    $0 build
    $0 run
    $0 logs
    $0 clean

EOF
}

# Main logic
case "${1:-help}" in
    build)
        build_image
        ;;
    run)
        build_image
        run_container
        ;;
    stop)
        stop_container
        ;;
    logs)
        view_logs
        ;;
    test)
        run_tests
        ;;
    clean)
        cleanup
        ;;
    help)
        print_help
        ;;
    *)
        log_error "Unknown command: $1"
        print_help
        exit 1
        ;;
esac
