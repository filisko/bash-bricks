#!/usr/bin/env bash

my_curl() {
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

    # 200,201,2xx is 0 (success in "bash" language)
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