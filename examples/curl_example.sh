#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "$DIR/../boot.sh"
source "$BB_LIB_DIR/curl.sh"
source "$BB_LIB_DIR/logs.sh"

response=$(bb_curl htatp://example.com/notfound)
code=$?

echo "$code"
echo "$response"
