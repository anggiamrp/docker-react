# Base image
FROM node:alpine as builder

# Working directory
WORKDIR '/app'

# Copy json package
COPY package.json .

# Install dependency
RUN npm install

# Copy source code to working directory
COPY . .

# npm build
RUN npm run build

# Build 2nd image & copy from 1st image to default location nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
