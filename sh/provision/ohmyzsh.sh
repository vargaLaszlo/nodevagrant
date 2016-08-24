#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

OHMYZSH_PLUGINS="git docker docker-compose node npm nvm"
OHMYZSH_THEME=nodevagrant

# Install zsh

sudo $PACKAGE_MANAGER -q -y install zsh

# Download oh-my-zsh

if [ -d $HOME_FOLDER/.oh-my-zsh ]; then
  :
else
  git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME_FOLDER/.oh-my-zsh
fi

# Create & modify settings

if [ -f $HOME_FOLDER/.zshrc ]; then
  :
else
  cp $HOME_FOLDER/.oh-my-zsh/templates/zshrc.zsh-template $HOME_FOLDER/.zshrc
  sed -i "s|plugins=(git)|plugins=($OHMYZSH_PLUGINS)|g" $HOME_FOLDER/.zshrc
  sed -i "s|ZSH_THEME=\"robbyrussell\"|ZSH_THEME=$OHMYZSH_THEME|g" $HOME_FOLDER/.zshrc
fi

# Install nodevagrant theme

if [ -f $HOME_FOLDER/.oh-my-zsh/custom/nodevagrant.zsh-theme ]; then
  :
else
  cp $HOME_FOLDER/sh/files/nodevagrant.zsh-theme $HOME_FOLDER/.oh-my-zsh/custom/nodevagrant.zsh-theme
  sudo dos2unix $HOME_FOLDER/.oh-my-zsh/custom/nodevagrant.zsh-theme
fi

# Fix premissions

sudo chmod 777 $HOME_FOLDER/.zshrc
sudo chown $USER:$USER $HOME_FOLDER/.zshrc
sudo chmod -R 777 $HOME_FOLDER/.oh-my-zsh
sudo chown -R $USER:$USER $HOME_FOLDER/.oh-my-zsh/

# Set zsh as default command

chsh -s /bin/zsh $USER
