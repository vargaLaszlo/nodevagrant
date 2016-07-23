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
sudo $PACKAGE_MANAGER -q -y --force-yes install git wget curl build-essential libssl-dev linux-image-extra-$(uname -r) apparmor ruby htop mc cowsay

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

if grep -q 'Nodevagrant' $HOME_FOLDER/.bashrc; then
  echo '>>> bash already configured'
else
  echo '##### Nodevagrant #####' >> $HOME_FOLDER/.bashrc
  echo '# Gather git repository info' >> $HOME_FOLDER/.bashrc
  echo 'function parse_git_dirty {' >> $HOME_FOLDER/.bashrc
  echo '  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"' >> $HOME_FOLDER/.bashrc
  echo '}' >> $HOME_FOLDER/.bashrc
  echo 'function parse_git_branch {' >> $HOME_FOLDER/.bashrc
  echo '  git branch --no-color 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"' >> $HOME_FOLDER/.bashrc
  echo '}' >> $HOME_FOLDER/.bashrc
  echo 'function parse_git_username {' >> $HOME_FOLDER/.bashrc
  echo '  git config user.name 2> /dev/null | tail -n1' >> $HOME_FOLDER/.bashrc
  echo '}' >> $HOME_FOLDER/.bashrc
  echo '# Colored promt' >> $HOME_FOLDER/.bashrc
  echo 'export CLICOLOR=true' >> $HOME_FOLDER/.bashrc
  echo 'export LSCOLORS=ExFxCxDxBxegedabagacad' >> $HOME_FOLDER/.bashrc
  echo 'PS1="\[\033[0;31m\]> \[\033[0;32m\]\u@\h: \[\033[0;33m\]\w\[\033[0;36m\]$(__git_ps1)\[\033[00m\] \$ "' >> $HOME_FOLDER/.bashrc
  #echo 'PS1="\u@\h \[\033[1;33m\]\w\[\033[0m\033[1;34m\][$(parse_git_username)]\[\033[0m\033[1;32m\]$(parse_git_branch)\[\033[0m\] \n$ ' >> $HOME_FOLDER/.bashrc
fi
