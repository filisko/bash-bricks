#!/usr/bin/env bash

valid_date() {
    local input="$1"

    regex='^([0-9]{4})-([0-9]{2})-([0-9]{2})$'
    if ! [[ "$input" =~ $regex ]]; then
        return 1
    fi

    year=${BASH_REMATCH[1]}
    month=${BASH_REMATCH[2]}
    day=${BASH_REMATCH[3]}

    if [[ $month -gt 12 ]] || [[ $month -lt 1 ]]; then
        return 1
    fi

    declare -a max_day_by_month=([1]=31 [2]=29 [3]=31 [4]=30 [5]=31 [6]=30 [7]=31 [8]=31 [9]=30 [10]=31 [11]=30 [12]=31)

    max_day=${max_day_by_month[month]}
    
    if [[ $day -lt 1 ]] || [[ $day -gt $max_day ]]; then
        return 1
    fi
}

valid_number() {
    local input="$1"    
    local regex='^[0-9]+$'

    if ! [[ "$input" =~ $regex ]]; then
        return 1
    fi
}
