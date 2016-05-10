#!/bin/bash

# Install ruby, sass compass

sudo apt-fast -q -y --force-yes install ruby

sudo gem update --system
sudo gem install sass compass

echo '>>> sass version' && sass --version
echo '>>> compass version' && compass --version
