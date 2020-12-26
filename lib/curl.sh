#!/usr/bin/env bash

bb_curl() {
    # store the response with the status code at the and
    http_response=$(curl --silent --show-error --write-out "#HTTPSTATUS#:%{http_code}" "$@" 2>&1)
    curl_status=$?

    http_body=$(echo $http_response | sed -E 's/#HTTPSTATUS#\:[0-9]{3}$//')
    http_status=$(echo $http_response | tr -d '\n' | sed -E 's/.*#HTTPSTATUS#:([0-9]{3})$/\1/')
    short_http_status=${http_status:0:1} # first number of http status code 400 -> 4

    if [ $curl_status -ne 0 ]; then
        printf "$http_body"
        return $curl_status
    fi

    # 200,201,2xx equals to bash success: 0
    if [ $short_http_status -eq 2 ]; then
        short_http_status=0
    fi

    printf "$http_body"
    return $short_http_status
}

bb_curl_check() {
    if [[ -z "$BB_COMMON_LOADED" ]]; then
        echo "common.sh must be loaded before http.sh"
        exit 1
    fi

    if ! binary_exists "curl"; then
        echo "Install curl please"
        exit 1
    fi
}
