#!/bin/bash

# Get deployment name and its ReplicaSet
DEPLOYMENT_NAME="kubelab-deployment"
RS_NAME=$(kubectl get deployment $DEPLOYMENT_NAME -o jsonpath='{.status.observedGeneration}' 2>/dev/null)
if [ $? -ne 0 ]; then
    echo "Deployment '$DEPLOYMENT_NAME' not found"
    exit 1
fi

# Get the desired replicas from the ReplicaSet annotation
DESIRED_REPLICAS=$(kubectl get rs -l app=kubelab -o jsonpath='{.items[0].metadata.annotations.deployment\.kubernetes\.io/desired-replicas}')
if [ -z "$DESIRED_REPLICAS" ]; then
    echo "Could not find desired replicas annotation in ReplicaSet"
    exit 1
fi

# Get the ReplicaSet events
RS_EVENTS=$(kubectl get events --field-selector involvedObject.kind=ReplicaSet --no-headers 2>/dev/null | grep "Created pod" | wc -l)

# Count how many unique pods were created and compare with desired replicas
if [ "$RS_EVENTS" -le "$DESIRED_REPLICAS" ]; then
    echo "The ReplicaSet has not scaled beyond its desired size ($DESIRED_REPLICAS). Found only $RS_EVENTS pod creation events"
    exit 1
fi

# If we get here, the ReplicaSet has created more pods than its desired state
/usr/local/bin/kubelab/complete-task 106
exit 0