#!/bin/bash

POD_STATUS=$(kubectl get pod my-nginx -o jsonpath='{.status.phase}' 2>/dev/null)

if [ "$POD_STATUS" = "Running" ]; then
    /usr/local/bin/kubelab/complete-task 2
    exit 0
else
    echo "Pod 'my-nginx' is not running. Current status: $POD_STATUS"
    exit 1
fi 