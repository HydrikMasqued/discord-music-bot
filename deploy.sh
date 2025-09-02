#!/bin/bash

# Discord Music Bot - Cybrancee Cloud Deployment Script
# Author: HydrikMasqued
# Platform: https://panel.cybrancee.com

set -e

echo "🎵 Discord Music Bot - Cloud Deployment Script"
echo "=============================================="

# Configuration
PROJECT_NAME="discord-music-bot"
DOCKER_IMAGE_NAME="hydrikmasqued/discord-music-bot"
VERSION="latest"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check requirements
check_requirements() {
    log_info "Checking deployment requirements..."
    
    if ! command -v docker &> /dev/null; then
        log_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        log_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    if [ ! -f ".env" ]; then
        log_error "Environment file (.env) not found. Please create it from .env.example"
        exit 1
    fi
    
    if [ ! -f "config.txt" ]; then
        log_error "Configuration file (config.txt) not found. Please create it from config.example.txt"
        exit 1
    fi
    
    log_success "Requirements check passed!"
}

# Build Docker image
build_image() {
    log_info "Building Docker image..."
    docker build -t $DOCKER_IMAGE_NAME:$VERSION .
    log_success "Docker image built successfully!"
}

# Deploy to cloud
deploy() {
    log_info "Deploying to Cybrancee Cloud..."
    
    # Stop existing containers
    log_info "Stopping existing containers..."
    docker-compose down 2>/dev/null || true
    
    # Pull latest changes and rebuild
    log_info "Starting deployment..."
    docker-compose up -d --build
    
    # Wait for container to be healthy
    log_info "Waiting for bot to start..."
    sleep 30
    
    # Check container status
    if docker-compose ps | grep -q "Up"; then
        log_success "Bot deployed successfully!"
        log_info "Bot is now running in the cloud!"
        
        # Show container logs
        log_info "Recent logs:"
        docker-compose logs --tail=20 musicbot
    else
        log_error "Deployment failed. Checking logs..."
        docker-compose logs musicbot
        exit 1
    fi
}

# Show status
show_status() {
    log_info "Current deployment status:"
    docker-compose ps
    echo ""
    log_info "Resource usage:"
    docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
}

# Show logs
show_logs() {
    log_info "Showing bot logs (last 50 lines):"
    docker-compose logs --tail=50 -f musicbot
}

# Restart bot
restart_bot() {
    log_info "Restarting bot..."
    docker-compose restart musicbot
    log_success "Bot restarted!"
}

# Stop deployment
stop_deployment() {
    log_info "Stopping deployment..."
    docker-compose down
    log_success "Deployment stopped!"
}

# Clean up
cleanup() {
    log_info "Cleaning up unused Docker resources..."
    docker system prune -f
    log_success "Cleanup completed!"
}

# Main menu
show_menu() {
    echo ""
    echo "Available commands:"
    echo "  deploy     - Deploy bot to cloud"
    echo "  status     - Show deployment status"
    echo "  logs       - Show bot logs"
    echo "  restart    - Restart the bot"
    echo "  stop       - Stop the deployment"
    echo "  cleanup    - Clean up Docker resources"
    echo "  help       - Show this menu"
}

# Main script logic
case "${1:-help}" in
    "deploy")
        check_requirements
        build_image
        deploy
        ;;
    "status")
        show_status
        ;;
    "logs")
        show_logs
        ;;
    "restart")
        restart_bot
        ;;
    "stop")
        stop_deployment
        ;;
    "cleanup")
        cleanup
        ;;
    "help"|*)
        show_menu
        ;;
esac

echo ""
log_info "For more help, visit: https://panel.cybrancee.com"
echo "=============================================="
