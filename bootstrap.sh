sudo apt-get -q -y update
sudo apt-get -q -y upgrade
sudo apt-get -q -y autoremove
sudo apt-get -q -y --force-yes install git wget curl build-essential libssl-dev # zsh htop mc ruby cowsay

git config --global credential.helper 'cache --timeout=6000'

sudo apt-get -q -y --force-yes install nodejs npm

wget https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh
sh install.sh
sudo cp -arv /root/.nvm /home/vagrant/.nvm
sudo chmod 777 -R .nvm

echo 'export NVM_DIR="/home/vagrant/.nvm"' >> /home/vagrant/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> /home/vagrant/.bashrc
