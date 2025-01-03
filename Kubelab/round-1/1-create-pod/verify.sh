#!/bin/bash

POD_STATUS=$(kubectl get pod kubelab-pod -o jsonpath='{.status.phase}' 2>/dev/null)

if [ "$POD_STATUS" = "Running" ]; then
    /usr/local/bin/kubelab/complete-task 2
    exit 0
else
    echo "Pod 'kubelab-pod' is not running. Current status: $POD_STATUS"
    exit 1
fi 