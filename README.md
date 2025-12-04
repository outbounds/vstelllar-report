# vStellar Report - Docker Compose Setup

Complete Docker Compose orchestration for the vStellar Report application stack, including frontend, backend, and PostgreSQL database services.

## 🚀 Quick Start

### Prerequisites

- **Docker** (version 20.10 or higher)
- **Docker Compose** (version 2.0 or higher)
- Ensure Docker is running on your machine before proceeding.

### Installation

1. **Clone this repository**:
   ```bash
   git clone https://github.com/outbounds/vstelllar-report.git
   cd vstelllar-report
   ```

2. **Start all services**:
   ```bash
   docker compose up -d
   ```

3. **Access the application**:
   ⚠️ Important: The customer-facing application is served from the Frontend URL below. Please ensure this port is accessible and not blocked by any local firewall or security rules.
   
   - **Frontend**: http://localhost:4201
   - **Backend API**: http://localhost:3000
   - **PostgreSQL**: localhost:5432

That's it! The setup uses pre-built Docker images from Docker Hub and requires no additional configuration for basic usage.

## 📋 What's Included

This repository contains a production-ready Docker Compose configuration that orchestrates:

- **Frontend Service** (`vstellar-report-frontend`)
  - Image: `outbounds/vstellar-report:frontend`
  - Port: `4201` (maps to container port 80)
  - Built with Angular and served via Nginx

- **Backend Service** (`vstellar-report-backend`)
  - Image: `outbounds/vstellar-report:backend`
  - Port: `3000`
  - Node.js/Express REST API

- **PostgreSQL Database** (`vstellar-report-db-postgres`)
  - Image: `postgres:14`
  - Port: `5432`
  - Database: `vstellar-report-db`
  - Persistent data storage via Docker volumes

## 🏗️ Architecture

```
┌─────────────────────────┐
│   Frontend Container    │
│  vstellar-report-       │
│  frontend               │
│  Port: 4201            │
└───────────┬─────────────┘
            │ HTTP
            ▼
┌─────────────────────────┐
│   Backend Container     │
│  vstellar-report-       │
│  backend                │
│  Port: 3000             │
└───────────┬─────────────┘
            │ PostgreSQL
            ▼
┌─────────────────────────┐
│   PostgreSQL Container  │
│  vstellar-report-db-     │
│  postgres               │
│  Port: 5432             │
└─────────────────────────┘
```

All services communicate via the `vstellar-report-network` Docker bridge network.

## ⚙️ Configuration

The `docker-compose.yml` file includes all necessary environment variables with sensible defaults. No `.env` file is required for basic operation.

### Default Configuration

- **Database**:
  - User: `postgres`
  - Password: `postgres123`
  - Database: `vstellar-report-db`
  - Port: `5432`


To customize settings, edit the `docker-compose.yml` file directly or use environment variables:

```bash
# Example: Override database password
POSTGRES_PASSWORD=mySecurePassword docker compose up -d
```

Or use the provided `run.sh` script:

```bash
./run.sh
```

## 💻 Common Commands

### Service Management

```bash
# Start all services
docker compose up -d

# Start with logs visible
docker compose up

# Stop all services
docker compose down

# Stop and remove volumes (⚠️ WARNING: deletes database data)
docker compose down -v

# View service status
docker compose ps
```

### Viewing Logs

```bash
# View all logs
docker compose logs -f

# View specific service logs
docker compose logs -f backend
docker compose logs -f frontend
docker compose logs -f postgres
```

### Database Operations

```bash
# Access PostgreSQL CLI
docker compose exec postgres psql -U postgres -d vstellar-report-db

# Backup database
docker compose exec postgres pg_dump -U postgres vstellar-report-db > backup.sql

# Restore database
docker compose exec -T postgres psql -U postgres vstellar-report-db < backup.sql

# View database logs
docker compose logs postgres
```

## 🔄 Updating Images

To pull and use the latest images from Docker Hub:

```bash
# Pull latest images
docker compose pull

# Restart services with new images
docker compose up -d
```

## 🔐 Security Notes

⚠️ **Important for Production**:

1. **Change Default Passwords**: Update `POSTGRES_PASSWORD` in `docker-compose.yml`
2. **Restrict Database Access**: Consider removing PostgreSQL port exposure in production
3. **Use Environment Variables**: For sensitive data, use environment variables instead of hardcoding

## 🐛 Troubleshooting

### Port Already in Use

If port 4201, 3000, or 5432 is already in use:

```bash
# Find process using the port
lsof -i :4201
lsof -i :3000
lsof -i :5432

# Or change ports in docker-compose.yml
```

### Services Won't Start

```bash
# Check logs for errors
docker compose logs

# Verify images exist
docker images | grep vstellar-report

# Check service health
docker compose ps
```

### Backend Can't Connect to Database

```bash
# Verify PostgreSQL is healthy
docker compose ps postgres

# Check network connectivity
docker compose exec backend ping postgres

# View database logs
docker compose logs postgres
```

### Frontend Can't Connect to Backend

```bash
# Verify backend is running
docker compose ps backend

# Check backend logs
docker compose logs backend

# Test backend API
curl http://localhost:3000/v1
```

### Container Name Conflicts

If you see errors about container names already in use:

```bash
# Remove existing containers
docker compose down

# Or remove specific container
docker rm vstellar-report-backend
```


## 🌐 Network Details

- **Network Name**: `vstellar-report-network`
- **Network Type**: Bridge
- **Internal Communication**: Services use service names (e.g., `postgres`, `backend`)
- **External Access**: Via exposed ports on `localhost`

## 📊 Health Checks

- **PostgreSQL**: Health check ensures database is ready before backend starts
- **Backend**: Health check verifies API is responding (checks for status 200, 401, or 404)

## 🗄️ Data Persistence

Database data is stored in a Docker volume (`postgres_data`) and persists across:
- Container restarts
- Service updates
- Docker Compose down/up cycles

⚠️ **Note**: Data is lost if you use `docker compose down -v`

## 🔗 Related Resources

- **Docker Hub Repository**: https://hub.docker.com/r/outbounds/vstellar-report
- **Frontend Image**: `outbounds/vstellar-report:frontend`
- **Backend Image**: `outbounds/vstellar-report:backend`

## 📝 Requirements

- Docker 20.10+
- Docker Compose 2.0+
- Internet connection (to pull images from Docker Hub)
- Minimum 2GB RAM recommended
- 5GB free disk space


## 🆘 Support

For issues and questions:
- Check the [Troubleshooting](#-troubleshooting) section
- Review service logs: `docker compose logs`
- Open an issue in the repository
- visit: vstellar.io

---

**Last Updated**: December 2025

**Maintained by**: OutboundsInc.

