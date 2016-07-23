#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

sudo $PACKAGE_MANAGER -q -y install samba

if grep -q 'Nodevagrant' /etc/samba/smb.conf; then
  echo '>>> samba already configured'
else
  sudo echo 'security = share' >> /etc/samba/smb.conf
  sudo echo '; guest account = nobody' >> /etc/samba/smb.conf
  sudo echo '#' >> /etc/samba/smb.conf
  sudo echo '##### NodeVagrant' >> /etc/samba/smb.conf
  sudo echo '[devs]' >> /etc/samba/smb.conf
  sudo echo '    comment = nodevagrant' >> /etc/samba/smb.conf
  sudo echo '    path = $HOME_FOLDER/devs/' >> /etc/samba/smb.conf
  sudo echo '    writable = yes' >> /etc/samba/smb.conf
  sudo echo '    public = yes' >> /etc/samba/smb.conf
  sudo echo '    browsable = yes' >> /etc/samba/smb.conf
  sudo echo '    guest ok = yes' >> /etc/samba/smb.conf
  sudo echo '    guest account = nobody' >> /etc/samba/smb.conf
  sudo echo '    guest only = yes' >> /etc/samba/smb.conf
  sudo echo '    read only = no' >> /etc/samba/smb.conf
  sudo echo '    create mask = 0775' >> /etc/samba/smb.conf
fi

sudo mkdir -p  $HOME_FOLDER/devs/
sudo chown nobody.nogroup  $HOME_FOLDER/devs/
sudo chmod 777  $HOME_FOLDER/devs/

sudo /etc/init.d/samba restart
