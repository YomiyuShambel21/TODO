# Frontend Dockerfile
FROM node:22 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .

# Build the application
RUN npm run build

# List the contents of the /app directory to verify build output
RUN ls -la /app && ls -la /app/dist  # Check both /app and /app/dist

FROM nginx:alpine

# Copy the built files from the correct directory
COPY --from=build /app/dist /usr/share/nginx/html  
# Ensure this path is correct

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]