#!/bin/bash

# Checking if frontend is running
if curl -s http://localhost > /dev/null; then
  echo "Frontend is running."
else
  echo "Frontend is not running."
fi

# Checking if backend is running
if curl -s http://localhost:5000/api/todos > /dev/null; then
  echo "Backend is running."
else
  echo "Backend is not running."
fi

# Checking if MongoDB is running
if docker exec -it f2f4a391416a mongosh --eval "show dbs" > /dev/null; then
  echo "MongoDB is running."
else
  echo "MongoDB is not running."
fi