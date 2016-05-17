#!/bin/bash

sudo apt-fast -q -y install samba

if grep -q 'nodevagrant' /etc/samba/smb.conf; then
  echo '>>> samba already configured'
else
  sudo echo 'security = share' >> /etc/samba/smb.conf
  sudo echo '; guest account = nobody' >> /etc/samba/smb.conf
  sudo echo '#' >> /etc/samba/smb.conf
  sudo echo '##### NodeVagrant' >> /etc/samba/smb.conf
  sudo echo '[devs]' >> /etc/samba/smb.conf
  sudo echo '    comment = nodevagrant' >> /etc/samba/smb.conf
  sudo echo '    path = /home/vagrant/devs/' >> /etc/samba/smb.conf
  sudo echo '    writable = yes' >> /etc/samba/smb.conf
  sudo echo '    public = yes' >> /etc/samba/smb.conf
  sudo echo '    browsable = yes' >> /etc/samba/smb.conf
  sudo echo '    guest ok = yes' >> /etc/samba/smb.conf
  sudo echo '    guest account = nobody' >> /etc/samba/smb.conf
  sudo echo '    guest only = yes' >> /etc/samba/smb.conf
  sudo echo '    read only = no' >> /etc/samba/smb.conf
  sudo echo '    create mask = 0775' >> /etc/samba/smb.conf
fi

sudo mkdir -p /home/vagrant/devs/
sudo chown nobody.nogroup /home/vagrant/devs/
sudo chmod 777 /home/vagrant/devs/

sudo /etc/init.d/samba restart
