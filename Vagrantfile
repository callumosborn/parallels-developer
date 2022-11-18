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

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell",
    path: "provisioners/bootstrap.sh",
    privileged: false

  config.vm.provision "shell",
    path: "provisioners/docker.sh",
    privileged: false

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "provisioners", "/home/vagrant/provisioners"

  config.vm.define "develop" do |develop|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    develop.vm.box = configuration["develop"]["vm"]["box"]

    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    develop.vm.box_check_update = true

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    #
    develop.vm.provider "parallels" do |prl|
      # Customize the amount of memory on the VM:
      prl.memory = configuration["develop"]["vm"]["provider"]["memory"]

      # Customize the name of the VM
      prl.name = configuration["develop"]["vm"]["provider"]["name"]

      # Ensure the latest sets of Parallels utilities are installed
      prl.update_guest_tools = true

      # A full clone of th box is created
      prl.linked_clone = false
    end

    # Enable provisioning with a shell script. Additional provisioners such as
    # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
    # documentation for more information about their specific syntax and use.
    develop.vm.provision "shell",
      path: "provisioners/ssh.sh",
      args: [
        configuration["developer"]["email"]
      ],
      privileged: false

    develop.vm.provision "shell",
      path: "provisioners/git.sh",
      args: [
        configuration["developer"]["name"],
        configuration["developer"]["email"]
      ],
      privileged: false

    develop.vm.provision "shell",
      path: "provisioners/github.sh",
      args: [
        configuration["github"]["title"],
        configuration["github"]["token"]
      ],
      privileged: false

    develop.vm.provision "shell",
      path: "provisioners/repos.sh",
      args: configuration["repos"],
      run: "always",
      privileged: false

    develop.vm.provision "shell",
      path: "provisioners/vscode.sh",
      args: configuration["vscode"]["extensions"],
      run: "always",
      privileged: false

    develop.vm.provision "shell",
      path: "provisioners/docker-use-context.sh",
      args: configuration["develop"]["docker"]["context"],
      run: "always",
      privileged: false
  end

  config.vm.define "deploy" do |deploy|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    deploy.vm.box = configuration["deploy"]["vm"]["box"]

    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    deploy.vm.box_check_update = true

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    deploy.vm.network "private_network", ip: configuration["deploy"]["vm"]["network"]["ip"]

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    #
    deploy.vm.provider "parallels" do |prl|
      # Customize the amount of memory on the VM:
      prl.memory = configuration["deploy"]["vm"]["provider"]["memory"]

      # Customize the name of the VM
      prl.name = configuration["deploy"]["vm"]["provider"]["name"]

      # Ensure the latest sets of Parallels utilities are installed
      prl.update_guest_tools = true

      # A full clone of th box is created
      prl.linked_clone = false
    end
  end
end
