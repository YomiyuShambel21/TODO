#!/bin/bash

# Colors for output
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print pass/fail messages
print_result() {
  if [ $1 -eq 0 ]; then
    echo -e "${BLUE}[PASS]${NC} $2"
  else
    echo -e "${YELLOW}[FAIL]${NC} $2"
  fi
}

# Test Frontend
echo "🔍 Testing Frontend (http://localhost:80)"
FRONT_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)
if [ "$FRONT_STATUS" == "200" ]; then
  print_result 0 "Frontend is up and responding with HTTP 200"
else
  print_result 1 "Frontend returned HTTP $FRONT_STATUS"
fi

# Test Backend API
echo "🔍 Testing Backend API (http://localhost:5000/api/todos)"
BACKEND_STATUS=$(curl -s -o backend_response.json -w "%{http_code}" http://localhost:5000/api/todos)
if [ "$BACKEND_STATUS" == "200" ]; then
  print_result 0 "Backend API is up and responding with HTTP 200"
else
  print_result 1 "Backend API returned HTTP $BACKEND_STATUS"
fi

# Display Backend Response Sample
echo "📦 Backend response sample:"
cat backend_response.json

# Test MongoDB
MONGO_CONTAINER_NAME='fullstack-todo-list-mongo-1'
echo "🔍 Testing MongoDB Connection (localhost:27017)"

# Check if MongoDB container is running
if ! docker ps -q -f name=$MONGO_CONTAINER_NAME; then
  print_result 1 "MongoDB container is not running!"
  exit 1
fi

# Test MongoDB connection
docker exec -it $MONGO_CONTAINER_NAME mongosh --eval 'db.stats()' > db_test_output.txt 2>&1

# Check for successful connection
if grep -q '"ok": 1' db_test_output.txt; then
  print_result 0 "MongoDB connection successful!"
else
  print_result 1 "MongoDB connection failed!"
fi

# Display MongoDB test output
echo "📦 MongoDB test output:"
cat db_test_output.txt

echo "==============================="
echo -e "${BLUE}✅ Tests Completed${NC}"
echo "==============================="
