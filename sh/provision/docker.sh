#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

# Install Docker

sudo apt-get -q -y install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Ubuntu Precise 12.04 (LTS)
# deb https://apt.dockerproject.org/repo ubuntu-precise main
# Ubuntu Trusty 14.04 (LTS)
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

if [ $DOCKER_REMOTE_INSTALL == "DOCKER" ]; then
  sudo docker pull -a --disable-content-trust=true jarkt/docker-remote-api
  sudo docker run -d -p 2375:2375 -v /var/run/docker.sock:/var/run/docker.sock --name docker-remote-api jarkt/docker-remote-api
  sudo docker start docker-remote-api
elif [ $DOCKER_REMOTE_INSTALL == "SOCKET" ]; then
  if [ -f /etc/systemd/system/docker-tcp.socket ]; then
    :
  else
    sudo cp $HOME_FOLDER/sh/files/docker-tcp.socket /etc/systemd/system/docker-tcp.socket
  fi

  sudo systemctl enable docker-tcp.socket
  sudo systemctl stop docker
  sudo systemctl start docker-tcp.socket

  if grep -q 'docker-tcp.socket' $HOME_FOLDER/.profile; then
    :
  else
    echo "sudo systemctl start docker-tcp.socket" >> $HOME_FOLDER/.profile
  fi
else
  :
fi

#sudo service docker restart

# Print versions

echo '>>> docker versions' && docker --version && docker-compose --version
