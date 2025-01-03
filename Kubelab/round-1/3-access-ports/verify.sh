#!/bin/bash

CURL_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" localhost:30000)

if [ "$CURL_RESPONSE" = "200" ]; then
    /usr/local/bin/kubelab/complete-task 103
    exit 0
else
    echo "Service is not accessible on port 30000. HTTP response: $CURL_RESPONSE"
    exit 1
fi