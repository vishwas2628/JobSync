#!/bin/bash

# Configuration
CONTAINER_NAME="mongodb"
MONGO_IMAGE="mongo:latest"
MONGO_USER="admin"
MONGO_PASS="password"
PORT=27017

echo "🚀 Starting JobSync Local Environment Setup..."

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if the container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "✅ MongoDB container is already running."
else
    # Check if the container exists but is stopped
    if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
        echo "🔄 Starting existing MongoDB container..."
        docker start $CONTAINER_NAME
    else
        echo "📦 Creating and starting new MongoDB container..."
        docker run -d \
          --name $CONTAINER_NAME \
          -p $PORT:$PORT \
          -e MONGO_INITDB_ROOT_USERNAME=$MONGO_USER \
          -e MONGO_INITDB_ROOT_PASSWORD=$MONGO_PASS \
          $MONGO_IMAGE
    fi
fi

echo "🕒 Waiting for MongoDB to initialize (5s)..."
sleep 5

echo "🔗 Connection String: MONGODB_URI=mongodb://$MONGO_USER:$MONGO_PASS@localhost:$PORT"
echo "🚀 Starting the application..."

# Start the Node.js application
export MONGODB_URI=mongodb://$MONGO_USER:$MONGO_PASS@localhost:$PORT
npm run dev

