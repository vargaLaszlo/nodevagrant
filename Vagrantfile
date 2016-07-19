# vi: set ft=ruby :

# To install environment
#
# 1 Install VirtualBox
# https://www.virtualbox.org/wiki/Downloads
#
# 2 Install Vagrant - Download installer (On windows after the install reboot host machine)
# https://www.vagrantup.com/downloads.html
#
# 3 Run in command line (powershell) to install vagrant plugins:
# vagrant plugin install vagrant-triggers vagrant-share vagrant-hostsupdater vagrant-cachier vagrant-multi-putty
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
# 3 vagrant up halts at ssh authentication => Install openssh/Git for windows and set enviroment variable "Path" to ssh.exe (settings > system > about > system info > advenced system settings > enviroment variables > path > edit > new ~ "C:/Program Files/OpenSSH/bin"), or delete the private key ".vagrant.d/insecure_private_key", or enable "Shh connect errors/timeouts" and or "Change network card to PCnet-FAST III" blocks in the Vagrantfile (all chases stop/start the box)
#
# More about vagrant
# https://www.vagrantup.com/about.html

# Install required vagrant plugins
required_plugins = %w(vagrant-triggers vagrant-share vagrant-hostsupdater vagrant-cachier vagrant-multi-putty)

plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

Vagrant.configure(2) do |config|
  config.vm.host_name = "nodevagrant"
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false

  ENV['LC_ALL'] = "en_US.UTF-8"

  # Shh connect errors/timeouts, use if ssh connect fails
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  # config.ssh.username = "vagrant"
  # config.ssh.password = "vagrant"
  # config.ssh.insert_key = false

  # Shared folders
  # config.vm.synced_folder ".", "/home/vagrant"
  config.vm.synced_folder "dev", "/home/vagrant/dev"
  config.vm.synced_folder "sh", "/home/vagrant/sh"

  # Virtualbox gui, memory, network cad
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = "2048"
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/dev", "1"]
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
  config.vm.network "forwarded_port", guest: 27017, host: 27777 # Mongo
  config.vm.network "forwarded_port", guest: 2375, host: 2375 # Docker Remote Api

  # config.vm.hostname = "dev.nodevagrant.com"
  config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  # Copy files into the virtual machine
  config.vm.provision "file", source: "files/docker-tcp.socket", destination: "/etc/systemd/system/docker-tcp.socket"

  # Copy your gitconfig file into the vm
  # config.vm.provision "file", source: ".gitconfig", destination: ".gitconfig"

  # Install tools via shellscripts
  config.vm.provision :shell, :path => "sh/provision-apt-fast.sh"
  config.vm.provision :shell, :path => "sh/provision-bootstrap.sh"
  config.vm.provision :shell, :path => "sh/provision-samba.sh"
  config.vm.provision "shell" do |s|
   s.path = "sh/provision-node.sh"
   s.keep_color = true
   s.env = {
    "NODE_INSTALL" => "APT", # NVM | APT | NONE
    "NODE_VERSION_NVM" => "4.4.4", # works with NVM
    "NODE_VERSION_APT" => "4.x" # works with APT
   }
  end
  config.vm.provision :shell, :path => "sh/provision-mongo.sh"
  config.vm.provision :shell, :path => "sh/provision-docker.sh"
  config.vm.provision :shell, :path => "sh/provision-phantomjs.sh"
  # config.vm.provision :shell, :path => "sh/provision-compass.sh"

  # Welcome message
  config.vm.post_up_message = 'Welcome! See vagrant comand line help: "vagrant --help" To log into the virtual machine type "vagrant ssh" (if you need username/password:vagrant/vagrant)'
end
