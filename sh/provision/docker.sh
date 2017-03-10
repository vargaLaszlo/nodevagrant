#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

wget -qO- https://get.docker.com/ | sh

# Install docker-compose
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# Install docker-cleanup command
cd /tmp
git clone https://gist.github.com/76b450a0c986e576e98b.git
cd 76b450a0c986e576e98b
sudo mv docker-cleanup /usr/local/bin/docker-cleanup
sudo chmod +x /usr/local/bin/docker-cleanup

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
