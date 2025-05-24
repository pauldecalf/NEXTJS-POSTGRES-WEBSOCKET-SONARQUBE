# Étape 1 : build de l'app
FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json* pnpm-lock.yaml* ./
RUN npm install -g pnpm && pnpm install

COPY . .
RUN pnpm build

# Étape 2 : image allégée pour la prod
FROM node:18-alpine AS runner

WORKDIR /app

ENV NODE_ENV production

# Copie les fichiers nécessaires
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000

CMD ["node_modules/.bin/next", "start"]
