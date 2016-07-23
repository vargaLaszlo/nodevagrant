#!/bin/bash

# Install, sass compass

sudo gem update --system
sudo gem install sass compass

echo '>>> sass version' && sass --version
echo '>>> compass version' && compass --version
