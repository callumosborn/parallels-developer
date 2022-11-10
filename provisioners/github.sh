#!/bin/bash

# github.sh - Callum Osborn (callumosborn@pm.me)

script_name="github"
script_error="$script_name: Error"

echo "$script_name: Running"

if [[ $# -ne 2 ]]; then
  echo "$script_error: Expecting 2 arguments to be provided: title and token"
  exit 1
fi

title=$1
token=$2

echo "$script_name: Installing GitHub CLI"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update
sudo apt-get install gh -y

echo "$script_name: Logging into GitHub"
cat <<< $token | gh auth login --git-protocol ssh --with-token

echo "$script_name: Adding ~/.ssh/id_ed25519.pub to GitHub"
gh ssh-key add ~/.ssh/id_ed25519.pub --title $1
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts

echo "$script_name: Verifying connection to github.com"
ssh -T git@github.com &> /dev/null

if [[ $? -ne 1 ]]; then
  echo "$script_error: SSH connection cannot be established to github.com"
  exit 2
fi

exit 0