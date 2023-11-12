# -*- mode: ruby -*-
# vi: set ft=ruby :

require "json"

def read(filename = "config.json")
  file = nil
  data = nil

  if(!File.exist?(filename))
    puts "File '#{filename}' does not exist."
    return nil
  end

  begin
    file = File.read(filename)
  rescue
    puts "Cannot read in '#{filename}' file."
    return nil
  end

  begin
    data = JSON.parse(file)
  rescue
    puts "Unable to parse JSON from '#{filename}' file."
    return nil
  end

  return data
end

cfg = read

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessable to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "bento/ubuntu-22.04"

  # The hostname the machine should have.
  # If set to a string, the hostname will be set on boot.
  # If set, Vagrant will update /etc/hosts on the guest with the configured hostname.
  config.vm.hostname = "parallels-developer"

  # Vagrant will check for updates to the configured box on every vagrant up.
  # If an update is found, Vagrant will tell the user.
  # By default this is true.
  # Updates will only be checked for boxes that properly support updates.
  config.vm.box_check_update = true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.50.2"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "parallels" do |prl|

    # You can customize the virtual machine name that appears in the Parallels Desktop GUI.
    # By default, Vagrant sets it to the name of the folder containing the Vagrantfile plus a timestamp of when the machine was created.
    prl.name = "parallels-developer"

    # Full clone is a full image copy, which is totally independent from the box.
    prl.linked_clone = false

    # Sets the number of CPUs to be available to the virtual machine.
    prl.cpus = 4

    # Sets the amount of memory for the virtual machine (in megabytes).
    prl.memory = 8192

    # Automatically update Parallels tools.
    prl.update_guest_tools = true
  end

  # Enable provisioning with a shell script.
  # Path to a shell script to upload and execute.
  config.vm.provision "shell",
    path: "provisioners/bootstrap.sh",
    privileged: false

  # Enable provisioning with a shell script.
  # Path to a shell script to upload and execute.
  config.vm.provision "shell",
    path: "provisioners/docker.sh",
    privileged: false

  # Enable provisioning with a shell script.
  # Path to a shell script to upload and execute.
  config.vm.provision "shell",
    path: "provisioners/ssh.sh",
    args: cfg["email"],
    privileged: false

  # Enable provisioning with a shell script.
  # Path to a shell script to upload and execute.
  config.vm.provision "shell",
    path: "provisioners/git.sh",
    args: [
      cfg["name"],
      cfg["email"]
    ],
    privileged: false

  # Enable provisioning with a shell script.
  # Path to a shell script to upload and execute.
  config.vm.provision "shell",
    path: "provisioners/github.sh",
    args: [
      cfg["github"]["title"],
      cfg["github"]["token"]
    ],
    privileged: false
end
