#!/usr/bin/env bash
#: This script will:
#: - install Git
#: - configure Git

full_name=$(echo $1 | tr '-' ' ')
email_address=$2

sudo apt-get update && sudo apt-get install git-all -y

git config --global user.name $full_name
git config --global user.email $email_address
git config --global init.defaultBranch master

exit 0
