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

configuration = read

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = configuration["vm"]["box"]

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = true

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "provisioners", "/home/vagrant/provisioners"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "parallels" do |prl|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
  
    # Customize the amount of memory on the VM:
    # vb.memory = "1024"

    # Customize the name of the VM
    prl.name = configuration["vm"]["provider"]["name"]

    # Ensure the latest sets of Parallels utilities are installed
    prl.update_guest_tools = true

    # A full clone of th box is created
    prl.linked_clone = false
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell",
    path: "provisioners/bootstrap.sh",
    privileged: false

  config.vm.provision "shell",
    path: "provisioners/docker.sh",
    privileged: false

  config.vm.provision "shell",
    path: "provisioners/github.sh",
    args: [
      configuration["vm"]["provider"]["name"],
      configuration["github"]["email"],
      configuration["github"]["token"],
    ],
    privileged: false
end