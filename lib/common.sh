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
    separator="$3"
    
    declare -i inside_match=0
    declare tmp_group_content=""
    declare -a group_contents=()

    while read LINE; do
        if [[ "$LINE" =~ $start ]]; then
            inside_match=1
        fi

        if [[ $inside_match -eq 1 ]]; then
            if [[ -z "$tmp_group_content" ]]; then
                tmp_group_content="${LINE}"
            else
                tmp_group_content="${tmp_group_content}\n${LINE}"
            fi
        fi

        if [[ $inside_match -eq 1 ]] && [[ "$LINE" =~ $end ]]; then
            group_contents=("${group_contents[@]}" "${tmp_group_content}")
            
            inside_match=0
            tmp_group_content=""
        fi

        if [[ $inside_match -eq 1 ]] && [[ "$LINE" =~ $start ]]; then
            tmp_group_content="${LINE}"
        fi
    done <<< "$(cat -)"

    for key in "${!group_contents[@]}"; do
        content="${group_contents[$key]}"
        if ! [[ -z "$separator" ]]; then
            printf "$separator\n"
        fi
        printf "$content\n"
    done
}