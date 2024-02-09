#!/usr/bin/env bash
#
# Script to download and install Git on Linux
#
# Author: Callum Osborn
#
# This script automates the process of downloading and installing Git
# on a Linux system.
#
# Prerequisites:
# - sudo: for performing actions with superuser privileges
#
# Usage:
# - Make sure to run this script with superuser privileges.
# - Run the script using "./install_git.sh"
#
# Exit Codes:
# - 0: Success
# - 1: Error occurred during installation

# Check if correct number of arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <full_name> <email_address>"
  exit 1
fi

# Extracting full name and email address from command line arguments
full_name=$(echo "$1" | tr '-' ' ')
email_address="$2"

# Update package list and install Git
sudo apt-get update && sudo apt-get install git-all -y

# Configure Git with user name, email address, and default branch
git config --global user.name "$full_name"
git config --global user.email "$email_address"
git config --global init.defaultBranch master

exit 0