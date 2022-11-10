#!/bin/bash

# docker.sh - Callum Osborn (callumosborn@pm.me)

script_name="docker"
echo "$script_name: Running"

curl -fsSL https://get.docker.com -o ~/downloads/get-docker.sh
sudo sh ~/downloads/get-docker.sh
sudo usermod -aG docker $USER

exit 0