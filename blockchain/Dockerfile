FROM node:20-alpine AS base

RUN apk add --no-cache git

FROM base AS deps
WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run compile || npx hardhat compile

FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production

RUN apk add --no-cache git

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hardhat

COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app .

USER hardhat

EXPOSE 8545

CMD ["npx", "hardhat", "node"]
