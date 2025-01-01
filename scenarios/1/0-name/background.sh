#!/bin/bash

# Configuration
API_URL="https://kubelab.vercel.app"
ROUND_ID=1  # Set this to your round ID

# Create directories
mkdir -p /root/.kubelab
mkdir -p /tmp/kubelab

# Generate the interactive script
cat > /tmp/kubelab/prompt.sh << 'EOF'
# Clear the screen for a clean start
clear

echo "Welcome to KubeLab! 🚀"
echo "Before we begin, please tell us your name:"

# Keep asking until we get a valid name
while true; do
  read -p "> " participant_name
  
  # Basic validation
  if [[ -z "${participant_name// }" ]]; then
    echo "Name cannot be empty. Please try again:"
    continue
  fi
  
  if [[ ${#participant_name} -lt 2 ]]; then
    echo "Name must be at least 2 characters long. Please try again:"
    continue
  fi
  
  # Write the name to a file for the background script
  echo "$participant_name" > /tmp/kubelab/participant_name
  
  # Wait for the background script to process the registration
  echo "Registering you for the lab..."
  
  # Check for registration status every second
  while true; do
    if [ -f "/tmp/kubelab/registration_success" ]; then
      echo "✅ Registration successful! You can now proceed with the lab."
      echo "Your progress will be tracked on the leaderboard."
      rm /tmp/kubelab/registration_success
      exit 0
    fi
    
    if [ -f "/tmp/kubelab/registration_error" ]; then
      error_msg=$(cat /tmp/kubelab/registration_error)
      echo "❌ Registration failed: $error_msg"
      echo "Please try again with a different name:"
      rm /tmp/kubelab/registration_error
      break
    fi
    
    sleep 1
  done
done
EOF

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