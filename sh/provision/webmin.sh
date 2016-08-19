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

echo ">>> Connect to webmin: https://$HOSTNAME:10000"
