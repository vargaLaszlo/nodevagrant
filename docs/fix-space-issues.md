# :package: Fix Box space issues

Start, and log into nodevagrant

```
    vagrant up
    vagrant ssh
```

## Get volume information

```
    df -h
```

## Remove old kernels

```
  # List installed kernels
  
  dpkg --list | grep linux-image 
  
  # Get used kernel version
  
  uname -r 
  
  # Delete old kernel, but do not delete your used kernel!
  
  sudo apt-get purge linux-image-x.x.x-x-generic 
```

## Clean apt-get

```
  sudo apt-get clean && sudo apt-get autoclean && sudo apt-get autoremove
```

## Clone box and increase max size

```
  # Clone to resizable format (vdi)
  
  VBoxManage clonehd box-disk1.vmdk box-disk1.vdi --format vdi
  
  # Resize cloned vdi
  
  VBoxManage modifyhd box-disk1.vdi --resize 20000
  
  # After clone, go to Oracle VM VirtualBox Manager remove old disc, add new disc...
```
