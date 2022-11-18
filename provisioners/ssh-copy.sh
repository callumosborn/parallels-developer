#!/bin/bash

# ssh-copy.sh - Callum Osborn (callumosborn@pm.me)

script_name="ssh-copy"
script_error="$script_name: Error"
echo "$script_name: Running"

if [[ $# -ne 1 ]]; then
  echo "$script_error: Expecting 1 argument to be provided: ip address"
  exit 1
fi

ip_address=$1

if [ ! -f ~/.ssh/id_ed25519 ]; then
  exit 1
fi

ssh-copy-id -i ~/.ssh/id_ed25519 vagrant@$ip_address

exit 0