# Check if we can connect to the MongoDB database
MONGO_CONTAINER_NAME='fullstack-todo-list-mongo-1'
echo "Checking the MongoDB Connection at localhost:27017..."

# Ensure that the MongoDB container is running
if ! docker ps -q -f name=$MONGO_CONTAINER_NAME; then
  print_result 1 "Oops! The MongoDB container is not running."
  exit 1
fi

# Try executing a command to get some stats from the MongoDB server
docker exec -i $MONGO_CONTAINER_NAME mongosh --eval 'db.stats()' > db_test_output.txt 2>&1

# Instead of checking for ok: 1, just confirm db.stats() runs without error
if grep -q '"ok": 1' db_test_output.txt; then
  print_result 0 "Successfully connected to MongoDB!"
else
  print_result 1 "Failed to connect to MongoDB, but the stats command was executed."
fi