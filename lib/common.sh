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

get_lines_between() {
    # input=$()

    cat - | awk '/line1/,/line4/'
    
    # cat - | awk '/line1/ {nr = NR} /line5/ {exit} nr && NR > nr+6'
    # cat - | awk '/line1/,/line5/'
    # cat - | awk '/line1/,/A/&&!/line5/'

    # printf "$input"
}