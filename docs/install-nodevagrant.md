# Install nodevagrant

## Install new nodevagrant box

    git clone https://github.com/vargaLaszlo/nodevagrant.git
    
    cd nodevagrant
    
    vagrant up

## Updating existing nodevagrant box

    git pull origin master
    
    vagrant up
    
    vagrant provision

## Reset, and updataing box

    git pull origin master
    
    vagrant destroy
    
    vagrant up
