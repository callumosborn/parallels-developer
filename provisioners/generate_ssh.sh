#!/usr/bin/env bash
#
# Script generates SSH authentication keys and adds them to the
# SSH authentication agent
#
# Author: Callum Osborn
#
# This script automates the process of generating SSH authentication keys
# on a Linux system.
#
# Usage:
# - Run the script using "./generate_ssh.sh"
#
# Exit Codes:
# - 0: Success
# - 1: Error occurred during installation

# Check if an email address is provided as a command-line argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <email_address>"
  exit 1
fi

# Generate SSH authentication keys
ssh-keygen -t ed25519 -C "$1" -f ~/.ssh/id_ed25519 -q -P ""

# Start SSH agent
eval "$(ssh-agent -s)"

# Add generated key to SSH agent
ssh-add ~/.ssh/id_ed25519

# Exit with success status
exit 0