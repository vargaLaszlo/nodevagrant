#!/bin/bash

# Docker compose halt
docker-compose kill
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)
# List containers
docker ps
