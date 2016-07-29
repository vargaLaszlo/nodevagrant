#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

sudo $PACKAGE_MANAGER -q -y install samba

if grep -q 'NodeVagrant' /etc/samba/smb.conf; then
  echo '>>> samba already configured'
else
  sudo cat $HOME_FOLDER/sh/files/smb.conf >> /etc/samba/smb.conf
  sudo sed -i "s|HOMEFOLDER|$HOME_FOLDER|g" /etc/samba/smb.conf
fi

sudo mkdir -p  $HOME_FOLDER/devs/
sudo chown nobody.nogroup  $HOME_FOLDER/devs/
sudo chmod 777  $HOME_FOLDER/devs/

sudo /etc/init.d/samba restart
