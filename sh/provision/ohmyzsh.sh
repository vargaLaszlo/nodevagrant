#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

# Install zsh

sudo $PACKAGE_MANAGER -q -y install zsh

# Install oh-my-zsh

if [ -f $HOME_FOLDER/sh/oh-my-zsh-install.sh ]; then
  :
else
  wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
  mv install.sh $HOME_FOLDER/sh/oh-my-zsh-install.sh
fi

sudo sh -c $HOME_FOLDER/sh/oh-my-zsh-install.sh