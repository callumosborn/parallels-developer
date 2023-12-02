#!/usr/bin/env bash
#: This script will:
#: - download and install the GitHub CLI
#: - authenticate with the GitHub host
#: - add public SSH authentication key to a GitHub account

title=$1
token=$2

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt-get update && sudo apt-get install gh -y

cat <<< $token | gh auth login --git-protocol ssh --with-token

gh ssh-key add ~/.ssh/id_ed25519.pub --title $title

ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts

ssh -T git@github.com &> /dev/null

exit 0
