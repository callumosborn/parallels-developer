#!/bin/bash

# repo-update.sh -Callum Osborn (callumosborn@pm.me)

script_name="repo-update"
script_error="$script_name: Error"
script_warning="$script_name: Warning"

echo "$script_name: Running"

if [[ $# -lt 1 ]]; then
  echo "$script_error: Expecting at least 1 argument to be provided"
  exit 1
fi

repos=("$@")

pushd ~/projects > /dev/null

for repo in "${repos[@]}"; do
  if [[ -d $repo ]]; then
    echo "$script_warning: ~/projects/$repo already exists"
  else
    git clone "git@github.com:$repo.git" $repo

    if [[ $? -ne 0 ]]; then
      echo "$script_warning: Cannot clone repository $repo from git@github.com:$repo.git"
    fi
  fi
done

popd > /dev/null

exit 0