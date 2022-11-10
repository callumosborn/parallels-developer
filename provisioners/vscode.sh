#!/bin/bash

# vscode.sh - Callum Osborn (callumosborn@pm.me)

script_name="vscode"
script_warning="$script_name: Warning"

echo "$script_name: Running"

if [[ $# -lt 1 ]]; then
  echo "$script_error: Expecting at least 1 argument to be provided"
  exit 1
fi

extensions=("$@")

code --version &> /dev/null

if [[ $? -ne 0 ]]; then
  echo "$script_warning: Visual Studio Code is already installed"
else
  sudo snap install --classic code &> /dev/null
fi

for extension in "${extensions[@]}"; do
  code --install-extension $extension --force &> /dev/null

  if [[ $? -ne 0 ]]; then
    echo "$script_warning: Cannot install code extension $extension"
  fi
done