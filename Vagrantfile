# vi: set ft=ruby :

# To install environment
#
# 1 Install VirtualBox
# https://www.virtualbox.org/wiki/Downloads
#
# 2 Install Vagrant - Download installer, (On windows after the install reboot host machine)
# https://www.vagrantup.com/downloads.html
#
# 3 Run in command line (powershell) to install vagrant plugins:
# vagrant plugin install vagrant-triggers vagrant-share vagrant-hostsupdater vagrant-cachier
#
# 4 Create shared folders on host machine (dev folder)
#
# 5 cd to vagrant box folder in command line (powershell), and hit:
# vagrant up
#
# See vagrant comand line help:
# vagrant --help
#
# Troubleshooting on Windows
# 1 Virtualbox throws error on 64 bit image => Windows features > Deactivate Hyper-V, or enable VT-x in bios, or use 32bit image (config.vm.box = "ubuntu/wily32")
# 2 Vagrant can't dowload vagrant box with "Download failed. Will try another box URL if there is one" error message => Windows usernam contains accents (íéáűúőóüö, etc.) => Set environmental variable "VAGRANT_HOME" to vagrant program folder (like c:/HashiCorp/Vagrant)
# 3 vagrant up halts at ssh authentication => Install openssh, or delete the private key ".vagrant.d/insecure_private_key", or enable "Shh connect errors/timeouts" and or "Change network card to PCnet-FAST III" blocks in the Vagrantfile (all chases stop/start the box)
#
# More about vagrant
# https://www.vagrantup.com/about.html

Vagrant.configure(2) do |config|
  config.vm.host_name = "nodevagrant"
  config.vm.box = "ubuntu/trusty64"

  ENV['LC_ALL'] = "en_US.UTF-8"

  # Shh connect errors/timeouts, use if ssh connect fails
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  # config.ssh.username = "vagrant"
  # config.ssh.password = "vagrant"
  # config.ssh.insert_key = false

  # Shared folders
  # config.vm.synced_folder ".", "/home/vagrant"
  config.vm.synced_folder "dev", "/home/vagrant/dev"

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

  # Install tools via shellscripts
  config.vm.provision :shell, :path => "sh/bootstrap.sh"
  config.vm.provision :shell, :path => "sh/node.sh"
  config.vm.provision :shell, :path => "sh/mongo.sh"
  config.vm.provision :shell, :path => "sh/docker.sh"
  #config.vm.provision :shell, :path => "sh/compass.sh"

  # Welcome message
  config.vm.post_up_message = 'Welcome! See vagrant comand line help: "vagrant --help" To log into the virtual machine type "vagrant ssh" (if you need username/password:vagrant/vagrant)'
end
