FROM node:20

# Install Electron runtime dependencies
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libx11-xcb1 \
    libnss3 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxcomposite1 \
    libxrandr2 \
    libgbm1 \
    libgtk-3-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

ENV TELEGRAM_API_ID=20045757
ENV TELEGRAM_API_HASH=7d3ea0c0d4725498789bd51a9ee02421

CMD ["npm", "run", "dev"]
