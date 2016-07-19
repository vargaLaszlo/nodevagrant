#!/bin/bash

# Install Docker

sudo apt-get -q -y install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# On Ubuntu Precise 12.04 (LTS)
# deb https://apt.dockerproject.org/repo ubuntu-precise main
# On Ubuntu Trusty 14.04 (LTS)
# deb https://apt.dockerproject.org/repo ubuntu-trusty main
# Ubuntu Wily 15.10
# deb https://apt.dockerproject.org/repo ubuntu-wily main

sudo echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list

sudo apt-get -q -y update
sudo apt-get -q -y purge lxc-docker -y
sudo apt-cache policy docker-engine

sudo apt-get -q -y update
sudo apt-fast -q -y install docker-engine
sudo usermod -aG docker vagrant

# Install docker-compose

# 15.10 +
# sudo apt-get -q -y install docker-compose

sudo curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Docker Remote API
# Register the new systemd http socket and restart docker

sudo systemctl enable docker-tcp.socket
sudo systemctl stop docker
sudo systemctl start docker-tcp.socket

# Print versions

echo '>>> docker versions' && docker --version && docker-compose --version
