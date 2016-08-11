# Install environment

## Windows

- Enable VT-x in bios

- Deactivate Hyper-V in Windows features

- Install Git for windows: https://git-scm.com/download/win

- Install VirtualBox: https://www.virtualbox.org/wiki/Downloads

- Install Vagrant: https://www.vagrantup.com/downloads.html

- Reboot host machine

- Set enviroment variable "Path" to ssh.exe (settings > system > about > system info > advenced system settings > enviroment variables > path > edit > new ~ "C:/Program Files/OpenSSH/bin")

- Create shared folders on host machine (dev folder)

- CD to vagrant box folder in command line (Git bash), and hit:

  vagrant up

### Troubleshooting on Windows

#### Vagrant can't dowload vagrant box with "Download failed.

Windows usernam contains accents (íéáűúőóüö, etc.) => Set environmental variable "VAGRANT_HOME" to vagrant program folder (like c:/HashiCorp/Vagrant)

#### Vagrant up halts at ssh authentication

Delete the private key ".vagrant.d/insecure_private_key"

# Linux

  - Enable VT-x in bios

  - Install VirtualBox https://www.virtualbox.org/wiki/Downloads

  - Install Vagrant Do not use the package manager, packages are outdated! (Ubuntu) https://www.vagrantup.com/downloads.html

  - CD to vagrant box folder in command line, and hit:

    vagrant up
