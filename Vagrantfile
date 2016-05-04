# -*- mode: ruby -*-
# vi: set ft=ruby :

# To install environment
#
# 1 Install VirtualBox
# https://www.virtualbox.org/wiki/Downloads
#
# 2 Install Vagrant - Download windows installer, install it, and after the install reboot host machine
# https://www.vagrantup.com/downloads.html
#
# 3 Run in command line (powershell) to install vagrant plugins:
# vagrant plugin install vagrant-triggers vagrant-share vagrant-hostupdater vagrant-cachier
#
# 4 cd to vagrant box folder in command line (powershell), and hit:
# vagrant up
#
# Troubleshooting on Windows
# 1 Virtualbox throws error on 64 bit image => Windows features > Deactivate Hyper-V, or enable VT-x in bios, or use 32bit image (config.vm.box = "ubuntu/wily32")
# 2 Vagrant can't dowload vagrant box with "Download failed. Will try another box URL if there is one" error message => Windows usernam contains accents (íéáűúőóüö, etc.) => Set environmental variable "VAGRANT_HOME" to vagrant program folder (like c:/HashiCorp/Vagrant)
# 3 vagrant up halts at ssh authentication => Install openssh, or delete the private key ".vagrant.d/insecure_private_key", or enable "Shh connect errors/timeouts" and or "Change network card to PCnet-FAST III" blocks in the Vagrantfile (all chases stop/start the box)
#
# More about vagrant
# https://www.vagrantup.com/about.html

Vagrant.configure(2) do |config|
  config.vm.host_name = 'nodevagrant'
  config.vm.box = "ubuntu/wily64"

  # Shared folders
  # config.vm.synced_folder ".", "/home/vagrant"
  config.vm.synced_folder "dev", "/home/vagrant/dev"
  #config.vm.synced_folder "www", "/var/www"

  # Virtualbox gui, memory, network cad
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = "2048"
    # Change network card to PCnet-FAST III
    # For NAT adapter
    # v.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
    # For host-only adapter
    # v.customize ["modifyvm", :id, "--nictype2", "Am79C973"]
  end

  # Install tools via shellscript
  config.vm.provision :shell, :path => "bootstrap.sh"

  # Set vagrant chache / Needs vagrant-cachier plugin
  if Vagrant.has_plugin?("vagrant-cachier")
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  # Forvarded ports
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  # config.vm.network "forwarded_port", guest: 8081, host: 8081

  # config.vm.hostname = "dev.nodevagrant.com"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  config.vm.provision "shell", inline: "echo 'node version' && nodejs --version && echo 'npm version' && npm --version"

  # Welcome message / Needs vagrant-triggers plugin
  config.vm.post_up_message = 'Welcome! To log into the virtual machine type "vagrant ssh" (if you need username/password:vagrant/vagrant)'
end
