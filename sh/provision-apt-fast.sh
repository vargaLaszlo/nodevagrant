#!/bin/bash

# Install apt-fast

sudo apt-get update;
sudo apt-get install -y aria2 --no-install-recommends;

if [ -f $HOME_FOLDER/sh/bin/apt-fast ]; then
  echo ">>> apt fast already downloaded"
else
  sudo wget -O $HOME_FOLDER/sh/bin/apt-fast  https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast
  sudo wget -O $HOME_FOLDER/sh/bin/apt-fast.conf https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf
fi

sudo cp $HOME_FOLDER/sh/bin/apt-fast /usr/bin/
sudo chmod +x /usr/bin/apt-fast
sudo cp $HOME_FOLDER/sh/bin/apt-fast.conf /etc
