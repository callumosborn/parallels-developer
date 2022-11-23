#!/bin/bash

ip_address=$1

host="tcp://$ip_address:2375"

docker context create deploy --docker host=$host

docker context use deploy

exit 0