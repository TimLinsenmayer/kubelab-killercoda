#!/bin/bash

# Configuration
API_URL="https://kubelab.vercel.app"
ROUND_ID=1  # Set this to your round ID

# Create directory for persistent data
mkdir -p /root/.kubelab

# Function to register participant
register_participant() {
  local name="$1"
  local response
  
  # Call the registration API
  response=$(curl -s -X POST "$API_URL/api/register" \
    -H "Content-Type: application/json" \
    -d "{\"name\": \"$name\", \"roundId\": $ROUND_ID}")
  
  # Check if the response contains participantId
  if echo "$response" | grep -q "participantId"; then
    # Extract participantId using grep and cut
    participant_id=$(echo "$response" | grep -o '"participantId":[0-9]*' | cut -d':' -f2)
    
    # Store the participant info
    echo "$participant_id" > /root/.kubelab/participant_id
    echo "$name" > /root/.kubelab/participant_name
    
    # Signal success to foreground script
    touch /tmp/kubelab/registration_success
  else
    # Extract error message or use default
    error_msg=$(echo "$response" | grep -o '"error":"[^"]*"' | cut -d'"' -f4)
    if [ -z "$error_msg" ]; then
      error_msg="Unknown error occurred"
    fi
    
    # Signal error to foreground script
    echo "$error_msg" > /tmp/kubelab/registration_error
  fi
}

# Main loop
while true; do
  # Check if there's a name to process
  if [ -f "/tmp/kubelab/participant_name" ]; then
    name=$(cat /tmp/kubelab/participant_name)
    rm /tmp/kubelab/participant_name
    
    # Try to register the participant
    register_participant "$name"
  fi
  
  sleep 1
done 