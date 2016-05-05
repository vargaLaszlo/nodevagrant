#!/bin/bash

sudo apt-get -q -y update
sudo apt-get -q -y upgrade
sudo apt-get -q -y autoremove
sudo apt-get -q -y --force-yes install git wget curl build-essential libssl-dev htop mc cowsay

git config --global credential.helper 'cache --timeout=6000'
