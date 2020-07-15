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
    start="$1"
    end="$2"
    
    inside_match=0
    tmp_result=""
    
    declare -a results

    while read LINE; do
        if [[ "$LINE" =~ $start ]]; then
            inside_match=1
        fi

        if [[ $inside_match -eq 1 ]]; then
            if [[ -z "$tmp_result" ]]; then
                tmp_result="${LINE}"
            else
                tmp_result="${tmp_result}\n${LINE}"
            fi
        fi

        if [[ $inside_match -eq 1 ]] && [[ "$LINE" =~ $end ]]; then
            results=("${results[@]}" "${tmp_result}")
            
            inside_match=0
            tmp_result=""
        fi

        if [[ $inside_match -eq 1 ]] && [[ "$LINE" =~ $start ]]; then
            tmp_result="${LINE}"
        fi
    done <<< $(cat -)

    for key in "${!results[@]}"; do
        echo -e "${results[$key]}"
    done
}