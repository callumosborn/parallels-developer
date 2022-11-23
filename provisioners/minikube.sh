#!/bin/bash

pushd /home/vagrant/downloads

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "" >> /home/vagrant/.bashrc
echo 'alias kubectl="minikube kubectl --"' >> /home/vagrant/.bashrc

popd

exit 0