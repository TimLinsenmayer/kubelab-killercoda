#!/bin/bash

POD_STATUS=$(kubectl get pod invalid-pod -o jsonpath='{.status.containerStatuses[0].state.waiting.reason}' 2>/dev/null)

if [ "$POD_STATUS" = "ImagePullBackOff" ]; then
    /usr/local/bin/kubelab/complete-task 102
    exit 0
else
    echo "Status nicht wie erwartet: $POD_STATUS"
    exit 1
fi 