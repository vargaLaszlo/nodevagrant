#!/bin/bash

# Install PhantomJS headless browser

PHANTOM_VERSION="phantomjs-1.9.8"
ARCH=$(uname -m)

if ! [ $ARCH = "x86_64" ]; then
	$ARCH="i686"
fi

PHANTOM_JS="$PHANTOM_VERSION-linux-$ARCH"

# sudo apt-get -y -q update
sudo apt-fast -q -y --force-yes install build-essential chrpath libssl-dev libxft-dev
sudo apt-fast -q -y --force-yes install libfreetype6 libfreetype6-dev
sudo apt-fast -q -y --force-yes install libfontconfig1 libfontconfig1-dev

if [ -f /home/vagrant/sh/bin/$PHANTOM_JS.tar.bz2 ]; then
  echo ">>> phantomjs already downloaded"
else
  wget -O /home/vagrant/sh/bin/$PHANTOM_JS.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
fi
  sudo tar xvjf /home/vagrant/sh/bin/$PHANTOM_JS.tar.bz2 -C /home/vagrant/sh/bin/
  sudo mv -f /home/vagrant/sh/bin/$PHANTOM_JS /usr/local/share
  sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

echo '>>> phantomjs version' && phantomjs --version
