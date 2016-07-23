#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

# Install MongoDB

sudo mkdir -p /data/db
sudo chmod -R 776 /data

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# Ubuntu Precise 12.04 (LTS)
# echo "deb http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Ubuntu Trusty 14.04 (LTS)
# echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Ubuntu Xenial 16.04 (LTS)
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo $PACKAGE_MANAGER update
sudo $PACKAGE_MANAGER install -y mongodb-org

# Print versions

export LC_ALL=C
echo '>>> mongo versions' && mongo --version && mongod --version
