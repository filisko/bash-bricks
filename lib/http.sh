#!/usr/bin/env bash

bb_curl() {
    # store the whole response with the status at the and
    HTTP_RESPONSE=$(curl --silent --show-error --write-out "HTTPSTATUS:%{http_code}" $@ 2>&1)
    curl_status=$?
    
    HTTP_BODY=$(echo $HTTP_RESPONSE | sed -E 's/HTTPSTATUS\:[0-9]{3}$//')
    HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')
    FIRST_NUMBER_HTTP_STATUS=$(echo "$HTTP_STATUS" | sed 's/..$//') # 400 -> 4

    if [ $curl_status -ne 0 ]; then
        printf "$HTTP_BODY"
        return $curl_status
    fi

    # 200,201,2xx will return 0 status
    if [ $FIRST_NUMBER_HTTP_STATUS -eq 2 ]; then
        FIRST_NUMBER_HTTP_STATUS=0
    fi

    # print the body and return the code
    printf "$HTTP_BODY"
    return $FIRST_NUMBER_HTTP_STATUS
}
# example
# response=$(my_curl -X POST -F 'grant_type=password' \
#   -F "client_id=$SALESFORCE_CLIENT_ID" \
#   -F "client_secret=$SALESFORCE_CLIENT_SECRET" \
#   -F "username=$SALESFORCE_USERNAME" \
#   -F "password=$SALESFORCE_PASSWORD" \
#   $URL)
# code=$?
# if [ $code -eq 0 ]; then
#   echo "success"
# else
#   echo "failed"
# fi

bb_http_check() {
    if [[ -z "$BB_PACKAGES_LOADED" ]]; then
        echo "packages.sh helpers must be loaded before http.sh"
        exit 1
    fi

    if ! binary_exists "curl"; then
        echo "Install curl please"
        exit 1
    fi
}


bb_http_check
BB_HTTP_LOADED=1