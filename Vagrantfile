# vi: set ft=ruby :

# Settings
node_install = "APT", # NVM | APT | NONE
node_version_nvm = "4.4.4", # works with NVM
node_version_apt = "4.x" # works with APT

# Install required vagrant plugins
required_plugins = %w(vagrant-triggers vagrant-share vagrant-hostsupdater vagrant-cachier vagrant-multi-putty vagrant-vbguest)

plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

# Vagrant configure
Vagrant.configure(2) do |config|
  config.vm.host_name = "nodevagrant"
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box"
  config.vm.box_check_update = true

  ENV['LC_ALL'] = "en_US.UTF-8"

  ubuntu = "xenial"
  user = "ubuntu"
  home = "/home/ubuntu"

  # Shh connect errors/timeouts, use if ssh connect fails
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  # config.ssh.username = user
  # config.ssh.password = user
  # config.ssh.insert_key = false

  # Shared folders
  # config.vm.synced_folder ".", #{home}
  config.vm.synced_folder "dev", "#{home}/dev"
  config.vm.synced_folder "sh", "#{home}/sh"

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

  # Copy your gitconfig file into the vm
  # config.vm.provision "file", source: ".gitconfig", destination: ".gitconfig"

  # Install tools via shellscripts

  # Apt-fast
  config.vm.provision "shell" do |sh|
   sh.path = "sh/provision-apt-fast.sh"
   sh.keep_color = true
   sh.env = {
    "HOME_FOLDER" => home
   }
  end

  # Bootstrap
  config.vm.provision "shell" do |sh|
   sh.path = "sh/provision-bootstrap.sh"
   sh.keep_color = true
   sh.env = {
    "HOME_FOLDER" => home
   }
  end

  # Samba
  config.vm.provision "shell" do |sh|
   sh.path = "sh/provision-samba.sh"
   sh.keep_color = true
   sh.env = {
    "HOME_FOLDER" => home
   }
  end

  # Node.js
  config.vm.provision "shell" do |sh|
   sh.path = "sh/provision-node.sh"
   sh.keep_color = true
   sh.env = {
    "NODE_INSTALL" => node_install,
    "NODE_VERSION_NVM" => node_version_nvm,
    "NODE_VERSION_APT" => node_version_apt,
    "HOME_FOLDER" => home
   }
  end

  # Mongodb
  config.vm.provision "shell" do |sh|
   sh.path = "sh/provision-mongo.sh"
   sh.keep_color = true
  end

  # Docker
  config.vm.provision "shell" do |sh|
   sh.path = "sh/provision-docker.sh"
   sh.keep_color = true
   sh.env = {
    "USER" => user
   }
  end

  # Phantomjs
  config.vm.provision "shell" do |sh|
   sh.path = "sh/provision-phantomjs.sh"
   sh.keep_color = true
   sh.env = {
    "HOME_FOLDER" => home
   }
  end

  # SASS, Compass
  # config.vm.provision :shell, :path => "sh/provision-compass.sh"

  # Welcome message
  config.vm.post_up_message = 'Welcome! See vagrant comand line help: "vagrant --help" To log into the virtual machine type "vagrant ssh" (if you need username/password:#{user}/#{user})'
end
