#!/bin/bash

# Upgrade/install packages

sudo apt-fast -q -y update
sudo apt-fast -q -y upgrade
sudo apt-fast -q -y autoremove
sudo apt-fast -q -y --force-yes install git wget curl build-essential libssl-dev htop mc cowsay

# settings

git config --global credential.helper 'cache --timeout=6000'

chmod +x /home/vagrant/sh/*

echo 'alias npmi="npm install --no-bin-link"' >> /home/vagrant/.bashrc
echo 'alias npm="npm --no-bin-link"' >> /home/vagrant/.bashrc

echo 'sudo chmod -R 777 /home/vagrant/.nvm' >> /home/vagrant/.bashrc
echo 'sudo chmod -R 777 /home/vagrant/.npm' >> /home/vagrant/.bashrc
