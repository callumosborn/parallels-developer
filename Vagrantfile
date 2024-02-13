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
  config.vm.box = cfg["virtual_machine"]["box"]
  config.vm.box_version = cfg["virtual_machine"]["box_version"]

  # The hostname the machine should have.
  # If set to a string, the hostname will be set on boot.
  # If set, Vagrant will update /etc/hosts on the guest with the configured hostname.
  config.vm.hostname = cfg["virtual_machine"]["name"]

  # Vagrant will check for updates to the configured box on every vagrant up.
  # If an update is found, Vagrant will tell the user.
  # By default this is true.
  # Updates will only be checked for boxes that properly support updates.
  config.vm.box_check_update = true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: cfg["virtual_machine"]["ip"]

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "parallels" do |prl|

    # You can customize the virtual machine name that appears in the Parallels Desktop GUI.
    # By default, Vagrant sets it to the name of the folder containing the Vagrantfile plus a timestamp of when the machine was created.
    prl.name = cfg["virtual_machine"]["name"]

    # Full clone is a full image copy, which is totally independent from the box.
    prl.linked_clone = false

    # Sets the number of CPUs to be available to the virtual machine.
    prl.cpus = cfg["virtual_machine"]["cpus"]

    # Sets the amount of memory for the virtual machine (in megabytes).
    prl.memory = cfg["virtual_machine"]["memory"]

    # Automatically update Parallels tools.
    prl.update_guest_tools = true

  end

  if cfg["options"]["is_docker"]
    config.vm.provision "docker" do |d|
    end
  end

  if cfg["options"]["is_minikube"]
    config.vm.provision "minikube",
      type: "shell",
      path: "provisioners/install_minikube.sh",
      privileged: false

    config.vm.provision "helm",
      type: "shell",
      path: "provisioners/install_helm.sh",
      privileged: false
  end

  if cfg["options"]["is_source_control"]
    config.vm.provision "ssh",
      type: "shell",
      path: "provisioners/generate_ssh.sh",
      args: cfg["email"],
      privileged: false

    config.vm.provision "git",
      type: "shell",
      path: "provisioners/install_git.sh",
      args: [
        cfg["name"],
        cfg["email"]
      ],
      privileged: false

    config.vm.provision "github",
      type: "shell",
      path: "provisioners/install_github.sh",
      args: [
        cfg["github"]["title"],
        cfg["github"]["token"]
      ],
      privileged: false
  end

  if cfg["options"]["is_minikube"]
    config.trigger.after :up do |trigger|
      trigger.name = "minikube"
      trigger.info = "Starting a cluster..."
      trigger.run_remote = {
        inline: "minikube start",
        privileged: false
      }
    end

    config.trigger.before :halt do |trigger|
      trigger.name = "minikube"
      trigger.info = "Stopping a cluster..."
      trigger.run_remote = {
        inline: "minikube stop",
        privileged: false
      }
    end
  end
end
