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

  config.vm.provision "shell",
    path: "provisioners/bootstrap.sh",
    privileged: false

  config.vm.provision "shell",
    path: "provisioners/docker.sh",
    privileged: false

  config.vm.synced_folder "provisioners", "/home/vagrant/provisioners"
  config.vm.synced_folder "confs", "/home/vagrant/confs"

  config.vm.define "develop" do |develop|

    develop.vm.box = configuration["develop"]["vm"]["box"]

    develop.vm.box_check_update = true

    develop.vm.network "private_network", ip: configuration["develop"]["vm"]["network"]["ip"]

    develop.vm.provider "parallels" do |prl|

      prl.memory = configuration["develop"]["vm"]["provider"]["memory"]

      prl.name = configuration["develop"]["vm"]["provider"]["name"]

      prl.update_guest_tools = true

      prl.linked_clone = false
    end

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
      path: "provisioners/minikube.sh",
      privileged: false

    develop.vm.provision "shell",
      path: "provisioners/repos.sh",
      args: configuration["repos"],
      run: "always",
      privileged: false

    if (!configuration["deploy"].nil?)
      develop.vm.provision "shell",
        path: "provisioners/context.sh",
        args: [
          configuration["deploy"]["vm"]["network"]["ip"],
          configuration["develop"]["docker"]["context"]
        ],
        privileged: false
    end
  end

  if (!configuration["deploy"].nil?)
    config.vm.define "deploy" do |deploy|

      deploy.vm.box = configuration["deploy"]["vm"]["box"]

      deploy.vm.box_check_update = true

      deploy.vm.network "private_network", ip: configuration["deploy"]["vm"]["network"]["ip"]

      deploy.vm.provider "parallels" do |prl|

        prl.memory = configuration["deploy"]["vm"]["provider"]["memory"]

        prl.name = configuration["deploy"]["vm"]["provider"]["name"]

        prl.update_guest_tools = true

        prl.linked_clone = false
      end

      deploy.vm.provision "shell",
        path: "provisioners/dockerd.sh",
        args: configuration["deploy"]["vm"]["network"]["ip"],
        privileged: false
    end
  end
end
