# Use official Node LTS
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package.json ./
COPY package-lock.json* ./

# Install dependencies (use `npm ci` when lockfile exists, otherwise fallback to `npm install`)
RUN if [ -f package-lock.json ]; then npm ci --omit=dev; else npm install --omit=dev; fi

# Copy app source
COPY . .

# Expose port
EXPOSE 3000

# Run seeding so data is created if script exists
RUN node scripts/seed.js || true

# Start app
CMD ["node", "server.js"]
