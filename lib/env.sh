#!/usr/bin/env bash

load_env() {
    local path="$1"

    if [ -f "$path" ]; then
        return 1;
    fi
    
    num_lines=$(cat "$path" | sed 's/#.*//g')

    if [ ! -z "$num_lines" ]; then
        export $(echo -n "$num_lines" | xargs)
    fi
}

