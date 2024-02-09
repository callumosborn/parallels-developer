#!/usr/bin/env bash
#
# Script to download and install GitHub on Linux
#
# Author: Callum Osborn
#
# This script automates the process of downloading and installing GitHub
# on a Linux system.
#
# Prerequisites:
# - curl: for downloading files from the internet
# - sudo: for performing actions with superuser privileges
#
# Usage:
# - Make sure to run this script with superuser privileges.
# - Run the script using "./install_github.sh"
#
# Exit Codes:
# - 0: Success
# - 1: Error occurred during installation

# Check if correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <key_title> <auth_token>"
    exit 1
fi

# Assign command-line arguments to variables
title="$1"
token="$2"

# Download and install the GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update && sudo apt-get install gh -y

# Authenticate with GitHub using token
echo "$token" | gh auth login --git-protocol ssh --with-token

if [ $? -ne 0 ]; then
  echo "Failed to authenticate with GitHub. Exiting."
  exit 1
fi

# Add public SSH key to GitHub account
gh ssh-key add ~/.ssh/id_ed25519.pub --title "$title"

if [ $? -ne 0 ]; then
  echo "Failed to add public SSH Key to GitHub. Exiting."
  exit 1
fi

# Add GitHub's SSH key to known_hosts file
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts

if [ $? -ne 0 ]; then
  echo "Failed to add GitHub's SSH key to known_hosts. Exiting."
  exit 1
fi

# Test SSH connection to GitHub
ssh -T git@github.com &> /dev/null

exit 0