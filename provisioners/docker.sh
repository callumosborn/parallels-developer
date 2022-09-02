#!/usr/bin/env bash

echo "Installing Docker using convenience script..."
curl -fsSL https://get.docker.com -o ~/downloads/get-docker.sh
sudo sh ~/downloads/get-docker.sh
sudo usermod -aG docker $USER