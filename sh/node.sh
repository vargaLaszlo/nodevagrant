#!/bin/bash

# Install Node.js, npm via package manager

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-fast -q -y --force-yes install nodejs

# Install nvm

curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | sh

sudo cp -arv /root/.nvm /home/vagrant/.nvm
sudo chmod 777 -R .nvm

echo 'export NVM_DIR="/home/vagrant/.nvm"' >> /home/vagrant/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> /home/vagrant/.bashrc

# Install Node.js, npm via nvm

#nvm install 4.4.4
#nvm alias default 4.4.4

# Print versions

echo '>>> node version' && nodejs --version
echo '>>> npm version' && npm --version
