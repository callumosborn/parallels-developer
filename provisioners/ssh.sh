#!/usr/bin/env bash
#: This script will:
#: - generate authentication keys for SSH
#: - add authetication keys to the authetication agent

ssh-keygen -t ed25519 -C $1 -f ~/.ssh/id_ed25519 -q -P ""

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519

exit 0
