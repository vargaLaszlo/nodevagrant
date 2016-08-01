#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

# Install Node.js, npm via package manager

if [ $NODE_INSTALL == "APT" ]; then
  echo ">>> NODE INSTALL VIA APT"

  curl -sL https://deb.nodesource.com/setup_$NODE_VERSION_APT | sudo -E bash -
  sudo $PACKAGE_MANAGER -q -y --force-yes install nodejs

  echo '>>> node version' && node --version
  echo '>>> npm version' && npm --version
fi

# Install nvm

curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | sh

sudo mkdir /.nvm
sudo cp -arv /root/.nvm $HOME_FOLDER/.nvm
sudo chmod 777 -R .nvm
sudo chmod 777 -R /.nvm
sudo chmod 777 -R $HOME_FOLDER/.nvm

echo 'export NVM_DIR="$HOME_FOLDER/.nvm"' >> $HOME_FOLDER/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> $HOME_FOLDER/.bashrc

if grep -q 'nvm.sh' $HOME_FOLDER/.profile; then
  :
else
  echo "source $HOME_FOLDER/.nvm/nvm.sh" >> $HOME_FOLDER/.profile
  source $HOME_FOLDER/.profile
fi

# Install Node.js, npm via nvm

if [ $NODE_INSTALL == "NVM" ]; then
  echo ">>> NODE INSTALL VIA NVM"

  nvm install $NODE_VERSION_NVM
  nvm alias default $NODE_VERSION_NVM

  echo 'sudo chmod -R 777 $HOME_FOLDER/.nvm' >> $HOME_FOLDER/.profile

  echo '>>> node version' && node --version
  echo '>>> npm version' && npm --version
fi
