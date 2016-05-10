#!/bin/bash

sudo apt-get update;
sudo apt-get install -y aria2 --no-install-recommends;

wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast
wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf

sudo cp apt-fast /usr/bin/
sudo chmod +x /usr/bin/apt-fast
sudo cp apt-fast.conf /etc
