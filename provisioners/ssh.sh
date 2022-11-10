#!/bin/bash

# ssh.sh - Callum Osborn (callumosborn@pm.me)

script_name="ssh"
script_error="$script_name: Error"

echo "$script_name: Running"

if [[ $# -ne 1 ]]; then
  echo "$script_error: Expecting 1 argument to be provided: email"
  exit 1
fi

email=$1

echo "$script_name: Generating SSH key ~/.ssh/id_ed25519"
ssh-keygen -t ed25519 -C $1 -f ~/.ssh/id_ed25519 -q -P ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

exit 0