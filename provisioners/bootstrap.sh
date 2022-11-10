#!/bin/bash

# bootstrap.sh - Callum Osborn (callumosborn@pm.me)

script_name="bootstrap"
script_error="$script_name: Error"

echo "$script_name: Running"

if [[ $# -ne 2 ]]; then
  echo "$script_error: Expecting 2 arguments to be provided: name and email"
  exit 1
fi

full_name=$(echo $1 | tr '-' ' ')
email_address=$2

mkdir ~/downloads
mkdir ~/projects

echo "$script_name: Updating, upgrading and installing software packages"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install \
  git-all \
  -y

echo "$script_name: Configuring Git"
git config --global user.name $full_name
git config --global user.email $email_address
git config --global init.defaultBranch master

exit 0