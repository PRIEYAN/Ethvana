# Ethvana

Multi-module blockchain application with Frontend, Backend, and Blockchain components.

## Architecture

- **Frontend**: Next.js 16 with React 19
- **Backend**: Express.js with TypeScript
- **Blockchain**: Hardhat development environment

## Quick Start

### Development Mode

```bash
docker-compose -f docker-compose.dev.yml up
```

Access:
- Frontend: http://localhost:3000
- Backend: http://localhost:8000
- Blockchain RPC: http://localhost:8545

### Production Mode

```bash
docker-compose up -d
```

## Manual Development

### Frontend
```bash
cd frontend
npm install
npm run dev
```

### Backend
```bash
cd backend
npm install
npm run dev
```

### Blockchain
```bash
cd blockchain
npm install
npx hardhat node
```

## CI/CD

### Production Pipeline (`.github/workflows/ci.yml`)
- Triggered on push to `main` or `develop`
- Installs dependencies
- Runs tests and linting
- Builds all modules
- Creates Docker images

### Development Pipeline (`.github/workflows/dev.yml`)
- Triggered on push to `develop` or feature branches
- Runs in dev mode
- Integration testing with Docker Compose

## Docker Commands

Build images:
```bash
docker-compose build
```

Start services:
```bash
docker-compose up -d
```

Stop services:
```bash
docker-compose down
```

View logs:
```bash
docker-compose logs -f
```

## Module Structure

```
Ethvana/
├── frontend/          # Next.js application
├── backend/           # Express.js API
├── blockchain/        # Hardhat contracts
├── docker-compose.yml # Production config
├── docker-compose.dev.yml # Development config
└── .github/workflows/ # CI/CD pipelines
```
