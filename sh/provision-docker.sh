#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

# Install Docker

sudo apt-get -q -y install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# On Ubuntu Precise 12.04 (LTS)
# deb https://apt.dockerproject.org/repo ubuntu-precise main
# On Ubuntu Trusty 14.04 (LTS)
# deb https://apt.dockerproject.org/repo ubuntu-trusty main
# Ubuntu Wily 15.10
# deb https://apt.dockerproject.org/repo ubuntu-wily main
# Ubuntu Xenial 16.04 (LTS)
# deb https://apt.dockerproject.org/repo ubuntu-xenial main

sudo echo deb https://apt.dockerproject.org/repo ubuntu-xenial main > /etc/apt/sources.list.d/docker.list

sudo $PACKAGE_MANAGER -q -y update
sudo apt-get -q -y purge lxc-docker -y
sudo apt-cache policy docker-engine

sudo $PACKAGE_MANAGER -q -y update
sudo $PACKAGE_MANAGER -q -y install docker-engine
sudo usermod -aG docker $USER

sudo service docker start

# Install docker-compose

# 15.10 +
sudo $PACKAGE_MANAGER -q -y install docker-compose

# older ubuntu
# sudo curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# Docker Remote API

sudo docker pull jarkt/docker-remote-api
sudo docker run -p 2375:2375 -v /var/run/docker.sock:/var/run/docker.sock --name docker-remote-api jarkt/docker-remote-api
sudo docker start docker-remote-api

#sudo service docker restart

# Print versions

echo '>>> docker versions' && docker --version && docker-compose --version
