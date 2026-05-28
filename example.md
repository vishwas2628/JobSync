# Local MongoDB Setup with Docker

This project supports running MongoDB locally using Docker, which is recommended for development to avoid internet dependencies and DNS issues.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your machine.
- Node.js and npm installed.

## Quick Start

You can start both MongoDB and the application with a single command:

```bash
./start_local.sh
```

This script will:
1. Check if a MongoDB container named `mongodb` is already running.
2. If not, it will create and start a new container using the `mongo:latest` image.
3. Wait for 5 seconds for the database to initialize.
4. Start the application using `npm run dev`.

## Environment Configuration

Update your `.env` file with the following connection string:

```env
MONGODB_URI=mongodb://admin:password@localhost:27017
```


## Manual Docker Management

If you prefer to manage the Docker container manually:

### Start MongoDB
```bash
docker run -d \
  --name mongodb \
  -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password \
  mongo:latest
```

### Stop MongoDB
```bash
docker stop mongodb
```

### Remove Container (and data)
```bash
docker rm -f mongodb
```

## Using Docker Compose (Alternative)

A `docker-compose.yml` file is also provided. You can use it by running:

```bash
docker compose up -d
```
