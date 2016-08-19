# Custom settings

## Custom settings

Use this to overwrite the default settings or insert your own Vagrant config lines.

If a custom settings file named "settings" exists in the same directory as the Vagrantfile, it will be evaluated as ruby inline as it loads.

To overwrite the default settings place the settings variables in the file like this:

    node_install = "NVM"
    node_version_nvm = "6.2.2"
    docker_remote_install = "NONE"

Insert additional items to list like settings:

    forvarded_ports << 7777
    provision_shellscripts << "compass.sh"
    required_plugins << "vagrant-cucumber"

If the forvarded port on the host and on the guest is not the same:

    forvarded_ports << [9999, 8888] # [guest, host]
    
To get te modifications run provision in command line:

    vagrant provision

Check the settings variables at the beginning of the Vagrantfile

Note that if you find yourself using a Customfile for anything crazy or specifying different provisioning, then you may want to consider a new Vagrantfile entirely.

## Custom gitconfig

Copy your .gitconfig file in the same directory as the Vagrantfile, vagrant will copy it in the box home folder.

## Custom shellscript

Place your own shelscript named "user.sh" in "sh/provision" folder to run it in provision process