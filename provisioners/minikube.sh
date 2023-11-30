#! /usr/bin/env bash

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo 'alias kubectl="minikube kubectl --"' >> ~/.bashrc

minikube start

minikube dashboard

minikube stop

rm minikube-linux-amd64