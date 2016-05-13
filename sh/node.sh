#!/bin/bash

# Install Node.js, npm via package manager

if [ $NODE_INSTALL == "APT" ]; then
  echo ">>> NODE INSTALL VIA APT"

  curl -sL https://deb.nodesource.com/setup_$NODE_VERSION_APT | sudo -E bash -
  sudo apt-fast -q -y --force-yes install nodejs

  echo '>>> node version' && node --version
  echo '>>> npm version' && npm --version
fi

# Install nvm

curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | sh

sudo cp -arv /root/.nvm /home/vagrant/.nvm
sudo chmod 777 -R .nvm
sudo chmod 777 -R /home/vagrant/.nvm

echo 'export NVM_DIR="/home/vagrant/.nvm"' >> /home/vagrant/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> /home/vagrant/.bashrc

echo "source /home/vagrant/.nvm/nvm.sh" >> /home/vagrant/.profile
source /home/vagrant/.profile

# Install Node.js, npm via nvm

if [ $NODE_INSTALL == "NVM" ]; then
  echo ">>> NODE INSTALL VIA NVM"

  nvm install $NODE_VERSION_NVM
  nvm alias default $NODE_VERSION_NVM

  echo 'sudo chmod -R 777 /home/vagrant/.nvm' >> /home/vagrant/.profile
  echo 'sudo chmod -R 777 /home/vagrant/.npm' >> /home/vagrant/.profile

  echo '>>> node version' && node --version
  echo '>>> npm version' && npm --version
fi

echo 'alias npmi="npm install --no-bin-link"' >> /home/vagrant/.bashrc
echo 'alias npm="npm --no-bin-link"' >> /home/vagrant/.bashrc
