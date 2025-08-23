# Use a Node LTS. Match the repo’s .node-version if you can.
FROM node:24

# Git is needed to clone (and the app calls git at runtime for metadata).
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

ENV NODE_OPTIONS=""
ENV TELEGRAM_API_ID=20045757
ENV TELEGRAM_API_HASH=7d3ea0c0d4725498789bd51a9ee02421

WORKDIR /app
RUN git clone https://github.com/slvreal/telegram-tt-railway.git .

# Install deps from lockfile
RUN npm ci

# Copy your filled .env (see repo’s .env.example) or pass --env-file at runtime
# COPY .env .    # uncomment if you want to bake it in

# Webpack dev server needs to bind to 0.0.0.0 to work from Docker
EXPOSE 1234
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "1234"]
