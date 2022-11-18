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

# TODO: Check ~/.ssh/ed_25519 file exists.
# TODO: $ ssh-copy-id -i ~/.ssh/ed_25519 vagrant@ip_address

exit 0