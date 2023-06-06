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

Vagrant.configure("2") do |config|
  config.vm.synced_folder "provisioners", "/home/vagrant/provisioners"

  config.vm.box = configuration["vm"]["box"]

  config.vm.box_check_update = true

  config.vm.network "private_network", ip: configuration["vm"]["network"]["ip"]

  config.vm.provider "parallels" do |prl|
    prl.memory = configuration["vm"]["provider"]["memory"]

    prl.name = configuration["vm"]["provider"]["name"]

    prl.update_guest_tools = false

    prl.linked_clone = false
  end

  config.vm.provision "shell",
    path: "provisioners/bootstrap.sh",
    privileged: false

  config.vm.provision "shell",
    path: "provisioners/docker.sh",
    privileged: false

  config.vm.provision "shell",
    path: "provisioners/ssh.sh",
    args: [
      configuration["developer"]["email"]
    ],
    privileged: false

  config.vm.provision "shell",
    path: "provisioners/git.sh",
    args: [
      configuration["developer"]["name"],
      configuration["developer"]["email"]
    ],
    privileged: false

  config.vm.provision "shell",
    path: "provisioners/github.sh",
    args: [
      configuration["github"]["title"],
      configuration["github"]["token"]
    ],
    privileged: false
end
