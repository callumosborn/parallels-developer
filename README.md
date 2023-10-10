# Parallels Developer

This project contains a collection of recipes to create a fully featured developer virtual machine configured for a variety of activities.

## Recipes

The recipes for the project can be found in the provisioners directory. For a background around provisioners, you can go to this [link](https://www.vagrantup.com/docs/provisioning).

- [bootstrap.sh](provisioners/bootstrap.sh)
- [docker.sh](provisioners/docker.sh)
- [ssh.sh](provisioners/ssh.sh)
- [git.sh](provisioners/git.sh)
- [github.sh](provisioners/github.sh)

## Getting Started

[config.example.json](config.example.json) provides you the ability to customize a few details of the virtual machine that you will bring up.

_GitHub Token_, the [personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) must have the following scopes when created: `repo`, `admin:org`, `admin:public_key`.

## Launch a Virtual Machine

1. Populate a new file `config.json` from `config.example.json`.
2. Launch a virtual machine `$ vagrant up`.
3. Connect to the virtual machine `$ vagrant ssh`.
