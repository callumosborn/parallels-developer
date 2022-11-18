#!/bin/bash

# docker-use-context.sh - Callum Osborn (callumosborn@pm.me)

script_name="docker-use-context"
script_error="$script_name: Error"

if [[ $# -ne 1 ]]; then
  echo "$script_error: Expecting 1 argument to be provided: context"
  exit 1
fi

context_name=$1

contexts_str=$(docker context ls --format '{{.Name}}')

contexts=($contexts_str)

for i in "${contexts[@]}"
do
  if [ "$i" = $context_name ]; then
    docker context use $context_name

    if [ $? -ne 0 ]; then
      echo "$script_error: Cannot use Docker context $context_name"
    fi
  fi
done

exit 0