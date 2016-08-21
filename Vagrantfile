# vi: set ft=ruby :

# Settings
node_install = "APT" # NVM | APT | NONE
node_version_nvm = "4.4.4" # works with NVM
node_version_apt = "4.x" # works with APT
docker_remote_install = "DOCKER" # DOCKER | SOCKET | NONE
phantomjs_version = "phantomjs-1.9.8"
forvarded_ports = [8080, 8081, [27017, 27777], 2375, 9222] # 24017: mongodb; 2375: docker remote api; 9222: chrome remote debugger port
required_plugins = ["vagrant-triggers", "vagrant-share", "vagrant-hostsupdater", "vagrant-cachier", "vagrant-multi-putty", "vagrant-vbguest"]
provision_shellscripts = ["apt-fast.sh", "bootstrap.sh", "samba.sh", "node.sh", "docker.sh", "mongo.sh", "phantomjs.sh"] # compass.sh ohmyzsh.sh webmin.sh
box_hostname = "nodevagrant"
box_ip = "192.168.33.10"

# Install required vagrant plugins
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
  config.vm.hostname = "nodevagrant"
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box"
  config.vm.box_check_update = true
  config.vm.boot_timeout = 36000

  ENV['LC_ALL'] = "en_US.UTF-8"

  ubuntu = "xenial"
  user = "ubuntu"
  home = "/home/#{user}"

  # Custom settings file
  if File.exists?(File.join('settings')) then
    eval(IO.read(File.join('settings')), binding)
  end

  # Custom shellscript
  if File.exists?(File.join('sh/provision/user.sh')) then
    provision_shellscripts << "user.sh"
  end

  # Custom config files
  custom_files = [".gitconfig", ".bashrc", ".zshrc"]
  custom_files.each do |c|
    if File.exists?(File.join('c')) then
      config.vm.provision "file", source: c, destination: c
    end
  end

  # Shared folders
  config.vm.synced_folder "dev", "#{home}/dev", create: true
  config.vm.synced_folder "db", "/data/db", create: true
  config.vm.synced_folder "sh", "#{home}/sh"

  # Virtualbox gui, memory, network cad
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = "2048"
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/dev", "1"]
  end

  # Set vagrant chache
  if Vagrant.has_plugin?("vagrant-cachier")
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  # Forvarded ports
  forvarded_ports.each do |p|
    if p.kind_of?(Array) then
      config.vm.network "forwarded_port", guest: p[0], host: p[1]
    else
      config.vm.network "forwarded_port", guest: p, host: p
    end
  end

  config.vm.hostname = box_hostname
  config.vm.network "private_network", ip: box_ip

  # Vagrant putty
  if Vagrant.has_plugin?("vagrant-multi-putty") then
    config.putty.modal = true
    config.putty.after_modal do
      require 'win32/activate'
      Win32::Activate.active
    end
  end

  # Install tools via shellscripts
  provision_shellscripts.each do |i|
    config.vm.provision "shell" do |sh|
     sh.path = "sh/provision/#{i}"
     sh.keep_color = true
     sh.env = {
       "NODE_INSTALL" => node_install,
       "NODE_VERSION_NVM" => node_version_nvm,
       "NODE_VERSION_APT" => node_version_apt,
       "DOCKER_REMOTE_INSTALL" => docker_remote_install,
       "PHANTOMJS_VERSION" => phantomjs_version,
       "USER" => user,
       "HOME_FOLDER" => home,
       "HOSTNAME" => box_hostname
     }
    end
  end

  # Welcome message
  config.vm.post_up_message = "Welcome! See vagrant comand line help: \"vagrant --help\" To log into the virtual machine type \"vagrant ssh\". If you need username/password: #{user}/#{user}"
end
