# Install and run nodevagrant

## Install new nodevagrant box

    git clone https://github.com/vargaLaszlo/nodevagrant.git
    
    cd nodevagrant
    
## Start box, and login
    
    vagrant up
    
    vagrant ssh
    
## Suspending/halting the machine

    vagrant suspend
    
    vargant halt

## Updating existing nodevagrant box

    git pull origin master
    
    vagrant up
    
    vagrant provision

## Reset, and updataing box

    git pull origin master
    
    vagrant destroy
    
    vagrant up
