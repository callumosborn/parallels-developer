#!/usr/bin/env bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install unzip

echo "Installing AWS..."
pushd ~/downloads/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
popd
aws --version

echo "Configuring access to AWS..."
aws configure set aws_access_key_id $1
aws configure set aws_secret_access_key $2
aws configure set default.region $3
aws configure set default.output $4