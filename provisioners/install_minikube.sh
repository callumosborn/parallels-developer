#!/usr/bin/env bash
#
# Script to download and install Minikube on Linux
#
# Author: Callum Osborn
#
# This script automates the process of downloading and installing Minikube
# on a Linux system.
#
# Prerequisites:
# - curl: for downloading files from the internet
# - tar: for extracting tarballs
# - sudo: for performing actions with superuser privileges
#
# Usage:
# - Make sure to run this script with superuser privileges.
# - Run the script using "./install_minikube.sh"
#
# Exit Codes:
# - 0: Success
# - 1: Error occurred during installation

DOWNLOAD_DIR="$HOME/downloads"
MINIKUBE_VERSION="latest"

# Create downloads directory
echo "Creating downloads directory..."
mkdir $DOWNLOAD_DIR

if [ $? -ne 0 ]; then
  echo "Failed to create $DOWNLOAD_DIR. Exiting."
  exit 1
fi

# Download Minikube
echo "Downloading Minikube..."
curl -Lo "$DOWNLOAD_DIR"/minikube https://storage.googleapis.com/minikube/releases/"$MINIKUBE_VERSION"/minikube-linux-amd64

if [ $? -ne 0 ]; then
  echo "Failed to download Minikube. Exiting."
  exit 1
fi

# Install Minikube
echo "Installing Minikube..."
chmod +x "$DOWNLOAD_DIR"/minikube
sudo mv "$DOWNLOAD_DIR"/minikube /usr/local/bin/minikube

if [ $? -ne 0 ]; then
  echo "Failed to install Minikube. Exiting."
  exit 1
fi

# Verify installation
echo "Verifying Minikube installation..."
minikube version

if [ $? -ne 0 ]; then
  echo "Minikube installation verification failed. Please check installation manually."
  exit 1
fi

# Remove downloads directory
echo "Removing downloads directory..."
rm -rf $DOWNLOAD_DIR

# Update configuration
echo "Updating configuration..."

if grep -q "alias kubectl" $HOME/.bashrc; then
  exit 0
else
  echo 'alias kubectl="minikube kubectl --"' >> $HOME/.bashrc

  if [ $? -ne 0 ]; then
    echo "Failed to update configuration file. Exiting."
    exit 1
  fi
fi

exit 0