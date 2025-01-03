#!/bin/bash

# Get deployment info
DEPLOYMENT_NAME="kubelab-deployment"
DEPLOYMENT_INFO=$(kubectl get deployment $DEPLOYMENT_NAME -o json 2>/dev/null)

# Check if deployment exists
if [ $? -ne 0 ]; then
    echo "Deployment '$DEPLOYMENT_NAME' not found"
    exit 1
fi

# Check number of replicas (must be at least 3)
REPLICAS=$(echo "$DEPLOYMENT_INFO" | jq '.spec.replicas')
if [ "$REPLICAS" -lt 3 ]; then
    echo "Deployment should have at least 3 replicas, but has $REPLICAS"
    exit 1
fi

# Check image
IMAGE=$(echo "$DEPLOYMENT_INFO" | jq -r '.spec.template.spec.containers[0].image')
if [ "$IMAGE" != "timlinsenmayer/kubelab-insights:latest" ]; then
    echo "Wrong image. Expected 'timlinsenmayer/kubelab-insights:latest', but got '$IMAGE'"
    exit 1
fi

# Check container port
PORT=$(echo "$DEPLOYMENT_INFO" | jq -r '.spec.template.spec.containers[0].ports[0].containerPort')
if [ "$PORT" != "3000" ]; then
    echo "Wrong container port. Expected '3000', but got '$PORT'"
    exit 1
fi

# Check labels
APP_LABEL=$(echo "$DEPLOYMENT_INFO" | jq -r '.spec.template.metadata.labels.app')
if [ "$APP_LABEL" != "kubelab" ]; then
    echo "Wrong label. Expected 'app: kubelab', but got 'app: $APP_LABEL'"
    exit 1
fi

# Check selector matchLabels
MATCH_LABEL=$(echo "$DEPLOYMENT_INFO" | jq -r '.spec.selector.matchLabels.app')
if [ "$MATCH_LABEL" != "kubelab" ]; then
    echo "Wrong matchLabel. Expected 'app: kubelab', but got 'app: $MATCH_LABEL'"
    exit 1
fi

# If we get here, all checks passed
/usr/local/bin/kubelab/complete-task 105
exit 0
