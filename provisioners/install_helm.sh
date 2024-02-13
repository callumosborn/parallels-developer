#!/usr/bin/env bash
#
# Script to download and install Helm on Linux
#
# Author: Callum Osborn
# 
# This script automates the process of downloading and installing Helm
# on a Linux system.
# 
# Prerequisites:
# - curl: for downloading files from the internet
# - sudo: for performing actions with superuser privileges.
# 
# Usage:
# - Make sure to run this script with superuser privileges.
# - Run the script using "./install_helm.sh"
# 
# Exit Codes:
# - 0: Success
# - 1: Error occured during installation

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

sudo apt-get install apt-transport-https --yes

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

sudo apt-get update && sudo apt-get install helm --yes

exit 0