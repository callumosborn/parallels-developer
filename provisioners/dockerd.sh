#!/bin/bash

ip_address="$1:2375"

sudo mkdir /etc/systemd/system/docker.service.d

sudo cp /home/vagrant/confs/docker.conf /etc/systemd/system/docker.service.d/docker.conf

output=$(jq -n --arg host "$ip_address" '{"hosts":["unix:///var/run/docker.sock",$host]}')

echo $output > /home/vagrant/daemon.json

sudo cp /home/vagrant/daemon.json /etc/docker/daemon.json

sudo systemctl daemon-reload

sudo systemctl restart docker.service

exit 0