# Task 1 – time-ip-app  (Dockerized Microservice)

This is a minimalist microservice named **time-ip-app**, built using **Node.js**, that returns the current timestamp and the IP address of the requester in pure JSON format when accessed at the root path `/`.

##  Prerequisites

- Docker Engine must be installed:  
  https://docs.docker.com/engine/install/

- (Linux only) To run Docker without sudo:
  sudo usermod -aG docker $USER
  newgrp docker

##  Running the App Locally

1. Navigate to the `app/` directory (where the Dockerfile is located).

2. Build the Docker image:
   docker build -t time-ip-image .

3. Run the container:
   docker run -d -p 3000:3000 time-ip-image

4. Access the app:
   http://localhost:3000

   Or test with curl:
   curl http://localhost:3000

   Example response:
   {
     "timestamp": "2025-07-13T14:22:10.234Z",
     "ip": "127.0.0.1"
   }

##  Container Best Practices

- Runs as a non-root user inside the container

## Project Structure

time-ip-app/
└── app/
    ├── Dockerfile
    └── index.js

## Public Docker Image

Available at:  
https://hub.docker.com/r/mridulbadgurjar4/time-ip-image


##

- App is containerized and can be built with `docker build`  
- App runs and stays running with `docker run`  
- JSON response is accurate with timestamp and client IP  
- README with deployment instructions is included  
- Container follows security and performance best practices

