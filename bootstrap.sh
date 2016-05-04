sudo apt-get -q -y update
sudo apt-get -q -y upgrade
sudo apt-get -q -y autoremove
sudo apt-get -q -y --force-yes install git wget curl build-essential libssl-dev htop mc cowsay

git config --global credential.helper 'cache --timeout=6000'

# Install Node.js, npm

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

sudo apt-get -q -y --force-yes install nodejs

# Install nvm

curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | sh

sudo cp -arv /root/.nvm /home/vagrant/.nvm
sudo chmod 777 -R .nvm

echo 'export NVM_DIR="/home/vagrant/.nvm"' >> /home/vagrant/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> /home/vagrant/.bashrc

# Install MongoDB

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update
sudo apt-get install -y mongodb-org

# Print versions

export LC_ALL=C
echo 'node version' && nodejs --version
echo 'npm version' && npm --version
echo 'mongo versions' && mongo --version && mongod --version
