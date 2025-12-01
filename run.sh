#!/bin/bash

# vStellar Report - Docker Compose Startup Script
# This script sets all environment variables and starts the services
#
# Service URLs:
# - Frontend: http://localhost:4201
# - Backend API: http://localhost:3000
# - PostgreSQL: localhost:5432

# PostgreSQL Configuration
export POSTGRES_USER=${POSTGRES_USER:-postgres}
export POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-postgres123}
export POSTGRES_DB=${POSTGRES_DB:-vstellar-report-db}
export POSTGRES_PORT=${POSTGRES_PORT:-5432}

# Backend Configuration
export BACKEND_IMAGE=${BACKEND_IMAGE:-outbounds/vstellar-report:backend}
export BACKEND_PORT=${BACKEND_PORT:-3000}
export NODE_ENV=${NODE_ENV:-production}

# Backend Application Environment Variables
export SECRET_JWT=${SECRET_JWT:-your-secret-jwt-key-change-this}
export REFRESH_JWT=${REFRESH_JWT:-your-refresh-jwt-key-change-this}
export APP_VERSION=${APP_VERSION:-V1}
export ENV=${ENV:-production}
export SERVER_URL=${SERVER_URL:-http://backend:3000}

# Email Configuration (Optional)
export EMAIL_USER=${EMAIL_USER:-}
export EMAIL_PASS=${EMAIL_PASS:-}
export EMAIL_HOST=${EMAIL_HOST:-smtp.gmail.com}
export EMAIL_PORT=${EMAIL_PORT:-465}

# API Token (Optional)
export API_TOKEN=${API_TOKEN:-}

# Frontend Configuration
export FRONTEND_IMAGE=${FRONTEND_IMAGE:-outbounds/vstellar-report:frontend}
export FRONTEND_PORT=${FRONTEND_PORT:-4201}

# Frontend API Configuration
export API_URL=${API_URL:-http://localhost:3000/v1}
export SSO_URL=${SSO_URL:-https://portal.outboundsinc.com/api/v1/sso}
export SSO_PROD_ID=${SSO_PROD_ID:-5442e96b-659f-4332-8658-c5963ab7ab05}

# Start Docker Compose
echo "🚀 Starting vStellar Report services..."
echo "📋 Configuration:"
echo "   - PostgreSQL: ${POSTGRES_USER}@localhost:${POSTGRES_PORT}/${POSTGRES_DB}"
echo "   - Backend: ${BACKEND_IMAGE} on port ${BACKEND_PORT}"
echo "   - Frontend: ${FRONTEND_IMAGE} on port ${FRONTEND_PORT}"
echo ""

docker-compose up -d

