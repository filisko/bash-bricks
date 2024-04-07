#!/usr/bin/env bash

load_env() {
    local path="$1"

    if [ -f "$path" ]; then
        num_lines=$(cat .env | sed 's/#.*//g')

        if [ ! -z "$num_lines" ]; then
            export $(echo -n "$num_lines" | xargs)
        fi
    fi
}

