# Use a Node LTS. Match the repo’s .node-version if you can.
FROM node:20-bullseye

# Git is needed to clone (and the app calls git at runtime for metadata).
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

ENV NODE_OPTIONS=""

WORKDIR /app
RUN git clone --depth=1 https://github.com/Ajaxy/telegram-tt.git .

# Install deps from lockfile
RUN npm ci

# Copy your filled .env (see repo’s .env.example) or pass --env-file at runtime
# COPY .env .    # uncomment if you want to bake it in

# Webpack dev server needs to bind to 0.0.0.0 to work from Docker
EXPOSE 1234
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "1234"]
