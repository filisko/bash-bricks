#!/usr/bin/env bash

bb_log() {
    local message="$1"
    local level="$2"
    local priority=$(bb_log_level_to_priority "$level")

    local script_logging_level=${LOG_LEVEL:-DEBUG}
    local env_priority=$(bb_log_level_to_priority "$script_logging_level")

    if [[ -z "$priority" ]]; then
        return 1
    fi

    # check if level is enough
    [[ $priority -le $env_priority ]] || return 2
    
    local datetime=`date +"%Y-%m-%d %T"`
    local date=`date +"%Y-%m-%d"`
    echo "[$datetime] ${level}: ${message}" >> "$LOGS_DIR/$date.log"
}

bb_log_level_to_priority() {
    # https://www.ietf.org/rfc/rfc3164.txt
    case $1 in
        'EMERGENCY') printf 0;;
        'ALERT') printf 1;;
        'CRITICAL') printf 2;;
        'ERROR') printf 3;;
        'WARNING') printf 4;;
        'NOTICE') printf 5;;
        'INFO') printf 6;;
        'DEBUG') printf 7;;
    esac
}