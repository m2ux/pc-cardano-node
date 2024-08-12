#!/usr/bin/bash

# Insert permissioned candidates into a chain config JSON file
# @params
# $1: The permissiomed-candidate JSON key file

  #read the permissioned candidate data from standard in
  cand_keys=$(</dev/stdin)

  # Make a temporary file to store the processed JSON
  tmp_json="$(mktemp)"

  # Replace initial permissioned candidates array content with remaining arguments
  jq --argjson ck "$cand_keys" '.initial_permissioned_candidates += [$ck]' "$1" > "$tmp_json"

  # Replace the JSON file by its modified version
  mv -- "$tmp_json" "$1"
