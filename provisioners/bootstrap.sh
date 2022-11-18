#!/bin/bash

# bootstrap.sh - Callum Osborn (callumosborn@pm.me)

script_name="bootstrap"

echo "$script_name: Running"

mkdir ~/downloads
mkdir ~/projects

echo "$script_name: Updating, upgrading and installing software packages"
sudo apt-get update
sudo apt-get upgrade -y

exit 0