#!/bin/bash

# Install apt-fast

sudo apt-get update;
sudo apt-get install -y aria2 --no-install-recommends;

if [ -f /home/vagrant/sh/bin/apt-fast ]; then
  echo ">>> apt fast already downloaded"
else
  wget -O /home/vagrant/sh/bin/apt-fast  https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast
  wget -O /home/vagrant/sh/bin/apt-fast.conf https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf
fi

sudo cp /home/vagrant/sh/bin/apt-fast /usr/bin/
sudo chmod +x /usr/bin/apt-fast
sudo cp /home/vagrant/sh/bin/apt-fast.conf /etc
