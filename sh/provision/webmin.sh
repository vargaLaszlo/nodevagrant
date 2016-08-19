#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi
 
if [ -f /etc/apt/sources.list.d/webmin.list ]; then
    :
else
    sudo echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list.d/webmin.list
    sudo echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list.d/webmin.list
fi

if [ -f $HOME_FOLDER/sh/bin/jcameron-key.asc ]; then
    :
else
    wget http://www.webmin.com/jcameron-key.asc
    mv jcameron-key.asc $HOME_FOLDER/sh/bin/jcameron-key.asc
fi

sudo apt-key add $HOME_FOLDER/sh/bin/jcameron-key.asc
sudo $PACKAGE_MANAGER -q -y update
sudo $PACKAGE_MANAGER -q -y install webmin

# https://IP_OF_UBUNTU_SERVER:10000
# http://www.techrepublic.com/article/how-to-install-ubuntu-server-16-04-and-the-web-based-admin-tool-webmin/