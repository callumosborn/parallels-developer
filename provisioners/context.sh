#!/bin/bash

ip_address=$1
context=$2

host="tcp://$ip_address:2375"

docker context create $context --docker host=$host

docker context use $context

exit 0