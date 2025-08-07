FROM docker.1ms.run/library/node:24-alpine

WORKDIR /app

# Copy all files
COPY . .
run npm install -g cnpm --registry=https://registry.npmmirror.com

run npm config set registry https://registry.npmmirror.com

# Install pnpm globally
RUN npm install -g pnpm --registry=https://registry.npmmirror.com

# Install dependencies
RUN pnpm install --frozen-lockfile --registry=https://registry.npmmirror.com

# Fix rollup optional dependencies issue
RUN cd ui && npm install --registry=https://registry.npmmirror.com

# Build the entire project including UI
RUN pnpm run build

# Expose port
EXPOSE 13456

# Start the router service
CMD ["node", "dist/cli.js", "start"]
