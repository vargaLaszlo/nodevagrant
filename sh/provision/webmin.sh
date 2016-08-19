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

if grep -q $USER /etc/webmin/miniserv.users; then
    :
else
    sudo echo "$USER:x:0::" >> /etc/webmin/miniserv.users
    sudo echo "$USER: acl adsl-client ajaxterm apache at backup-config bacula-backup bandwidth bind8 burner change-user cluster-copy cluster-cron cluster-passwd cluster-shell cluster-software cluster-useradmin cluster-usermin cluster-webmin cpan cron custom dfsadmin dhcpd dovecot exim exports fail2ban fdisk fetchmail file filemin filter firewall firewall6 firewalld fsdump grub heartbeat htaccess-htpasswd idmapd inetd init inittab ipfilter ipfw ipsec iscsi-client iscsi-server iscsi-target iscsi-tgtd jabber krb5 ldap-client ldap-server ldap-useradmin logrotate lpadmin lvm mailboxes mailcap man mon mount mysql net nis openslp package-updates pam pap passwd phpini postfix postgresql ppp-client pptp-client pptp-server proc procmail proftpd qmailadmin quota raid samba sarg sendmail servers shell shorewall shorewall6 smart-status smf software spam squid sshd status stunnel syslog-ng syslog system-status tcpwrappers telnet time tunnel updown useradmin usermin vgetty webalizer webmin webmincron webminlog wuftpd xinetd" >> /etc/webmin/webmin.acl
fi

sudo /etc/init.d/webmin restart

echo ">>> Connect to webmin: https://$HOSTNAME:10000"
