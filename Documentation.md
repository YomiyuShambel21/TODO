# Containerizing a 3-Tier To-Do List Application with Docker

## 1. Introduction

This guide provides clear instructions on how to containerize a full-stack To-Do List application following a 3-tier architecture: Frontend, Backend, and Database. Docker and Docker Compose are used to ensure the application runs smoothly and consistently across different environments.

## 2. Prerequisites

Before proceeding, make sure the following software is installed on your system:

- Docker
- Docker Compose
- Git

## 3. Setup Instructions

### Step 1: Clone the Repository

Clone the project repository to your local machine:
git clone https://github.com/yourusername/todo-3tier-app.git 
cd todo-3tier-app

### Step 2: Dockerizing the Components

Each component of the application is containerized separately:

#### Frontend (React App)
- Uses the node image to install dependencies and build the React application.
- The production build is served using nginx.

#### Backend (Express Server)
- Uses the node image to install dependencies and run the Express.js server.
- Communicates with the MongoDB database.

#### Database (MongoDB)
- Uses the official mongo image from Docker Hub.
- Stores data in a Docker volume to persist across container restarts.

### Step 3: Docker Compose

Docker Compose manages the three services: Frontend, Backend, and Database.
The docker-compose.yml file:

- Defines each service
- Creates a shared Docker network for seamless communication
- Configures volumes for data persistence
- Manages environment variables and port mappings

## 4. Running the Application

### 4.1 Build and Start the Containers

Run the following command to build images and start the containers:
docker-compose up --build -d

This will:
- Build Docker images for the Frontend and Backend
- Start the Frontend, Backend, and MongoDB containers in detached mode
- Establish networking between services

### 4.2 Stop and Remove the Containers

To stop and clean up the running containers, run:
docker-compose down

### 4.3 Verify the Setup

Check the status of running containers:
docker ps

Access the application at:
- Frontend: http://localhost:80
- Backend API: http://localhost:5000/api/todos
- MongoDB runs on port 27017 (internal only)

## 5. Network Configurations

### Frontend:
- Runs on port 80
- Access via: http://localhost

### Backend (Express API):
- Runs on port 5000
- Access via: http://localhost:5000/api/todos

### Database (MongoDB):
- Runs on port 27017
- This port is typically used internally by the backend to connect to MongoDB.
- Example connection string: mongodb://mongo:27017/tododb (assuming your service name is mongo in Docker Compose)

## 6. Troubleshooting Guide

### Issue 1: Containers won't start

Run this to view logs and identify the problem:
docker-compose logs

### Issue 2: Port conflicts (80, 5000, 27017)

Check for processes using these ports:
sudo lsof -i :80 
sudo lsof -i :5000 
sudo lsof -i :27017

Kill any conflicting process:
kill -9 <PID>

### Issue 3: Application is not accessible

Restart the containers:
docker-compose restart

## 7. Container Testing Script

A test.sh script is included to verify that all services are running correctly.

### 7.1 Make the script executable
chmod +x test.sh

### 7.2 Run the script
./test.sh

The script will perform the following checks:
- Test if the Frontend is accessible and returns HTTP 200
- Test if the Backend API responds with HTTP 201
- Confirm MongoDB connectivity and provide status output