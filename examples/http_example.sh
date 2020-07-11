#!/usr/bin/env bash

response=$(bb_curl -X POST -F 'grant_type=password' -F "client_id=1234" https://example.com)
code=$?

if [ $code -eq 0 ]; then
  echo "success"
  echo "response content $response"
else
  echo "failed"
fi
