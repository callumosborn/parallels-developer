#!/usr/bin/env bash

echo "Installing Git..."
sudo apt-get install git-all -y

echo "Generating SSH keys..."
ssh-keygen -t ed25519 -C $2 -f ~/.ssh/id_ed25519 -q -P ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Installing GitHub CLI..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update
sudo apt-get install gh

echo "Logging into GitHub..."
echo $3 > ~/github-token.txt
gh auth login --git-protocol ssh --with-token < ~/github-token.txt
rm ~/github-token.txt
gh ssh-key add ~/.ssh/id_ed25519.pub --title $1