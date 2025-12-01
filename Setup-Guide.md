# Docker Compose Setup Guide

This project uses Docker Compose to orchestrate three services: Frontend, Backend, and PostgreSQL.

## Prerequisites

- Docker and Docker Compose installed
- Docker images pushed to Docker Hub:
  - Frontend image: `fe:latest` (or specify tag via `FRONTEND_TAG`)
  - Backend image: `be:latest` (or specify tag via `BACKEND_TAG`)

## Quick Start

1. **Create a `.env` file** in the root directory (see `cr-backend/ENV_VARIABLES.md` for all variables):

```bash
# Minimum required variables
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres123
POSTGRES_DB=vstellar-report-db
BACKEND_IMAGE=be
FRONTEND_IMAGE=fe
SECRET_JWT=your-secret-jwt-key
REFRESH_JWT=your-refresh-jwt-key
```

2. **Start all services**:

```bash
docker-compose up -d
```

3. **Access the application**:
   - Frontend: http://localhost:4200
   - Backend API: http://localhost:3000
   - PostgreSQL: localhost:5432

## Services

### PostgreSQL (`postgres`)
- **Image**: `postgres:14`
- **Container Name**: `cr-postgres`
- **Port**: 5432 (configurable via `POSTGRES_PORT`)
- **Data Persistence**: Data is stored in a Docker volume `postgres_data`

### Backend (`backend`)
- **Image**: From Docker Hub (default: `be:latest`)
- **Container Name**: `vstellar-report-backend`
- **Port**: 3000 (configurable via `BACKEND_PORT`)
- **Database Connection**: Uses service name `postgres` to connect to PostgreSQL
- **Environment Variables**: See `cr-backend/ENV_VARIABLES.md`

### Frontend (`frontend`)
- **Image**: From Docker Hub (default: `fe:latest`)
- **Container Name**: `vstellar-report-frontend`
- **Port**: 4200 (configurable via `FRONTEND_PORT`)
- **API Connection**: Connects to backend via `http://localhost:3000/v1`

## Network

All services are connected via a bridge network named `cr-network`, allowing them to communicate using service names:
- Backend can connect to PostgreSQL using hostname: `postgres`
- Frontend can connect to Backend using hostname: `backend` (for server-side requests)
- Browser connects to services via exposed ports (localhost:3000, localhost:4201)

## Environment Variables

See `cr-backend/ENV_VARIABLES.md` for a complete list of environment variables.

Key variables:
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`: Database credentials
- `BACKEND_IMAGE`, `BACKEND_TAG`: Backend Docker image name and tag
- `FRONTEND_IMAGE`, `FRONTEND_TAG`: Frontend Docker image name and tag
- `SECRET_JWT`, `REFRESH_JWT`: JWT secret keys (change in production!)
- `BACKEND_PORT`, `FRONTEND_PORT`: Exposed ports

## Common Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Stop and remove volumes (WARNING: deletes database data)
docker-compose down -v

# Restart a specific service
docker-compose restart backend

# View service status
docker-compose ps
```

## Troubleshooting

1. **Backend can't connect to PostgreSQL**:
   - Ensure PostgreSQL service is healthy: `docker-compose ps`
   - Check database credentials in `.env` file
   - Verify `DB_HOST=postgres` in backend environment

2. **Frontend can't connect to Backend**:
   - Ensure backend is running: `docker-compose ps`
   - Check that `BACKEND_PORT` matches the port in frontend's environment file
   - Frontend environment file uses `localhost:3000` (browser-side connection)

3. **Port conflicts**:
   - Change ports in `.env` file (e.g., `BACKEND_PORT=3001`, `FRONTEND_PORT=4201`)

## Notes

- The frontend environment file (`environment.prod.ts`) is configured to use `http://localhost:3000/v1` for the API URL
- This works because Angular runs in the browser, which accesses services via exposed ports
- Backend uses the service name `postgres` to connect to the database (container-to-container communication)
- Database data persists in a Docker volume, so data survives container restarts

