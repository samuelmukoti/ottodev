#!/bin/bash

# Process each line in .env.local, handling BINDING_TOKEN and VALUE_TOKEN constants
while read -r line; do
  if [[ "$line" != "##" ]] && [[ -n "$line" ]]; then # Skip lines that are comments or empty
    name=$(echo "$line" | cut -d '=' -f 1)
    value=$(echo "$line" | cut -d '=' -f 2)
    value=$(echo "$value" | sed 's/^"\(.*\)"$/\1/')
    bindings+="--binding ${name}=${value} "
  fi
done < .env.local

# Trim trailing white space
bindings=$(echo "${bindings%"$bindings##"}")

# Output the bindings with no trailing space, if necessary
echo "${bindings}##"