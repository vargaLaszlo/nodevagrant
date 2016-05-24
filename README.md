# nodevagrant

## Features

* Apt-fast - much faster apt-get installs
* Samba - folder share via network (devs)
* Virtualbox shared folder (dev)
* Node, NVM
* Mongo
* Docker, Docker Compose
* PhantomJS
* Utility shellscripts
* Command line tools (git, mc, htop, etc.)


## Install nodevagrant

### Install new nodevagrant box

git clone https://github.com/vargaLaszlo/nodevagrant.git

cd nodevagrant

vagrant up

### Updating existing nodevagrant box

git pull origin master

vagrant up

vagrant provision

### Reset, and updataing box

git pull origin master

vagrant destroy

vagrant up
