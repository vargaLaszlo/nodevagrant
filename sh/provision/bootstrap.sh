#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

# Upgrade/install packages

sudo $PACKAGE_MANAGER -q -y update
sudo $PACKAGE_MANAGER -q -y upgrade
sudo $PACKAGE_MANAGER -q -y autoremove
sudo $PACKAGE_MANAGER -q -y --force-yes install git wget curl vim dos2unix zfs nfs-common build-essential libssl-dev linux-image-extra-$(uname -r) apparmor ruby ruby-dev htop mc cowsay

# Third party shellscripts

# ESM'SH:  http://www.ezservermonitor.com/esm-sh/features
if [ -f $HOME_FOLDER/sh/eZServerMonitor.sh ]; then
  :
else
  git clone https://github.com/shevabam/ezservermonitor-sh.git /tmp/ezsh
  cp /tmp/ezsh/eZServerMonitor.sh $HOME_FOLDER/sh
fi

# docker check config
if [ -f $HOME_FOLDER/sh/docker-check-config.sh ]; then
  :
else
  wget https://raw.github.com/docker/docker/master/contrib/check-config.sh
  mv check-config.sh $HOME_FOLDER/sh/docker-check-config.sh
fi

# ubuntu kernel update shellscript
if [ -f $HOME_FOLDER/sh/ubuntu-kernel-upgrader-script.sh ]; then
  :
else
  git clone https://gist.github.com/8493727.git /tmp/ubuntu-kernel-upgrader
  mv /tmp/ubuntu-kernel-upgrader/Ubuntu\ Kernel\ Upgrader\ Script $HOME_FOLDER/sh/ubuntu-kernel-upgrader-script.sh
fi

# Settings

git config --global credential.helper 'cache --timeout=6000'

chmod +x $HOME_FOLDER/sh/*

sysctl -w kernel/keys/root_maxkeys=1000000 #docker

# Bash git functions, aliases, colored promt

if grep -q 'NodeVagrant' $HOME_FOLDER/.bashrc; then
  echo '>>> bash already configured'
else
  sudo cat $HOME_FOLDER/sh/files/bashrc >> $HOME_FOLDER/.bashrc
  dos2unix $HOME_FOLDER/.bashrc
fi
