#!/bin/bash

if which apt-fast >/dev/null; then
    PACKAGE_MANAGER=apt-fast
else
    PACKAGE_MANAGER=apt-get
fi

# Install PhantomJS headless browser

ARCH=$(uname -m)

if ! [ $ARCH = "x86_64" ]; then
	$ARCH="i686"
fi

PHANTOM_JS=$PHANTOMJS_VERSION-linux-$ARCH

# sudo apt-get -y -q update
sudo $PACKAGE_MANAGER -q -y --force-yes install build-essential chrpath libssl-dev libxft-dev
sudo $PACKAGE_MANAGER -q -y --force-yes install libfreetype6 libfreetype6-dev
sudo $PACKAGE_MANAGER -q -y --force-yes install libfontconfig1 libfontconfig1-dev

if [ -f $HOME_FOLDER/sh/bin/$PHANTOM_JS.tar.bz2 ]; then
  echo ">>> phantomjs already downloaded"
else
  wget -O $HOME_FOLDER/sh/bin/$PHANTOM_JS.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
fi
  sudo tar xvjf $HOME_FOLDER/sh/bin/$PHANTOM_JS.tar.bz2 -C $HOME_FOLDER/sh/bin/
  sudo mv -f $HOME_FOLDER/sh/bin/$PHANTOM_JS /usr/local/share
  sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

echo '>>> phantomjs version' && phantomjs --version
