#!/bin/bash

# bootstrap.sh - Callum Osborn (callumosborn@pm.me)

script_name="bootstrap"

echo "$script_name: Running"

mkdir ~/downloads
mkdir ~/projects

echo "$script_name: Updating software packages"
sudo apt-get update && \
  sudo apt-get install jq -y

chmod +x ~/provisioners/*.sh

exit 0
