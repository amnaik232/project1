# Use official Node LTS
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package.json & package-lock if present
COPY package.json ./
COPY package-lock.json* ./

# Install dependencies
RUN npm ci --omit=dev

# Copy app source
COPY . .

# Expose port
EXPOSE 3000

# Run seeding so data is created if script exists
RUN node scripts/seed.js || true

# Start app
CMD ["node", "server.js"]
