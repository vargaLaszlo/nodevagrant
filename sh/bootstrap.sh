#!/bin/bash

# Upgrade/install packages

sudo apt-fast -q -y update
sudo apt-fast -q -y upgrade
sudo apt-fast -q -y autoremove
sudo apt-fast -q -y --force-yes install git wget curl build-essential libssl-dev htop mc cowsay

# settings

git config --global credential.helper 'cache --timeout=6000'
chmod +x /home/vagrant/sh/*
