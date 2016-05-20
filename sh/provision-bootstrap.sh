#!/bin/bash

# Upgrade/install packages

sudo apt-fast -q -y update
sudo apt-fast -q -y upgrade
sudo apt-fast -q -y autoremove
sudo apt-fast -q -y --force-yes install git wget curl build-essential libssl-dev htop mc cowsay

# settings

git config --global credential.helper 'cache --timeout=6000'

chmod +x /home/vagrant/sh/*

# bash git functions, colored promt

if grep -q 'parse_git_dirty' /home/vagrant/.bashrc; then
  echo '>>> bash already configured'
else
  echo 'function parse_git_dirty {' >> /home/vagrant/.bashrc
  echo '  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"' >> /home/vagrant/.bashrc
  echo '}' >> /home/vagrant/.bashrc
  echo 'function parse_git_branch {' >> /home/vagrant/.bashrc
  echo '  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"' >> /home/vagrant/.bashrc
  echo '}' >> /home/vagrant/.bashrc
  echo 'function parse_git_username {' >> /home/vagrant/.bashrc
  echo '  git config user.name 2> /dev/null | tail -n1' >> /home/vagrant/.bashrc
  echo '}' >> /home/vagrant/.bashrc
  echo 'export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\033[1;34m\][$(parse_git_username)]\[\033[0m\033[1;32m\]$(parse_git_branch)\[\033[0m\] \n$ '' >> /home/vagrant/.bashrc
fi

# Third party shellscripts

# ESM'SH:  http://www.ezservermonitor.com/esm-sh/features
if [ -f /sh/eZServerMonitor.sh ]; then
  :
else
  git clone https://github.com/shevabam/ezservermonitor-sh.git /tmp/ezsh
  cp /tmp/ezsh/eZServerMonitor.sh /home/vagrant/sh
fi