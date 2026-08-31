# Cloud Kitchen — Indian States & Famous Dishes

This repository is a minimal "Cloud Kitchen" listing famous dishes from Indian states and union territories. It includes:

- Node.js + Express API and simple static frontend
- dataset of states → dishes (data/dishes.json)
- Dockerfile and docker-compose.yml
- GitHub Actions workflow to build & push Docker image to GitHub Container Registry (GHCR)
- init_repo.sh to automate initial commit & push

Quick start (local)
1. Install dependencies:
   npm install

2. Seed data (optional; data is included):
   npm run seed

3. Start:
   npm start
   - App will be served at http://localhost:3000
   - API endpoints:
     GET /api/states               -> list of { state, dish, description }
     GET /api/states/:stateSlug    -> entry for a given state slug (use lowercase with dashes)

Docker
- Build locally:
  docker build -t cloud-kitchen:latest .

- Run:
  docker run -p 3000:3000 cloud-kitchen:latest

Docker Compose
- docker-compose up --build

CI / CD (GitHub Actions)
- Workflow file: .github/workflows/docker-build-and-push.yml
- It builds the Docker image and pushes to GHCR (ghcr.io/OWNER/cloud-kitchen).
- You need to set repository secrets:
  - CR_PAT (a Personal Access Token with `write:packages` and `read:packages` privileges) OR use the default GITHUB_TOKEN (suitable for ghcr in many orgs/repos)
  - Optionally set IMAGE_REGISTRY (defaults to ghcr.io)

Automated commit script
- init_repo.sh does git init, initial commit, and optionally adds a remote and pushes.

License: MIT
