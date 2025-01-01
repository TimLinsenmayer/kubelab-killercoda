#!/bin/bash

# Wait for the prompt script to be created by background.sh
while [ ! -f "/tmp/kubelab/prompt.sh" ]; do
    sleep 1
done

# Make it executable and run it
chmod +x /tmp/kubelab/prompt.sh
/tmp/kubelab/prompt.sh