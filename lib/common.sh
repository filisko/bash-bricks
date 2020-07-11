#!/usr/bin/env bash

is_linux() {
    if [[ "$OSTYPE" == "linux"* ]]; then
        return 0
    fi

    return 1
}

is_osx() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    fi
    return 1
}

binary_exists() {
    if ! which "$1" > /dev/null; then
        return 1
    fi
}

BB_COMMON_LOADED=1