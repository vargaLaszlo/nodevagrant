#!/bin/bash

# Print versions in fancy colors

tput setaf 1
lsb_release -a

tput sgr0
echo '----------------------------'
tput setaf 2

echo 'node version'
node --version
echo 'npm version'
npm --version

tput sgr0
echo '----------------------------'
tput setaf 3

mongo --version
mongod --version

tput sgr0
echo '----------------------------'
tput setaf 6

docker --version
docker-compose --version

tput sgr0
