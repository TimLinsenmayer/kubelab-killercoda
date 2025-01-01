#!/bin/bash

# Check if participant is registered
if [ -f "/root/.kubelab/participant_id" ]; then
    exit 0
else
    echo "Please register first to continue"
    exit 1
fi
