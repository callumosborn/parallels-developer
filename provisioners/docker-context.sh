#!/bin/bash

# docker-context.sh - Callum Osborn (callumosborn@pm.me)

script_name="docker-context"
script_error="$script_name: Error"
echo "$script_name: Running"

if [[ $# -ne 2 ]]; then
  echo "$script_error: Expecting 2 arguments to be provided: context and ip address"
  exit 1
fi

context_name=$1
ip_address=$2

docker context create $1 --docker "host=ssh://$2"

exit 0