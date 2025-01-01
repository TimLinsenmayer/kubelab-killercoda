# Create directories
mkdir -p /root/.kubelab
mkdir -p /tmp/kubelab
mkdir -p /usr/local/bin/kubelab

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

# Create the task completion script
cat > /usr/local/bin/kubelab/complete-task << 'EOF'
#!/bin/bash

# Check if task ID is provided
if [ -z "$1" ]; then
    echo "Error: Task ID is required"
    exit 1
fi

TASK_ID=$1
PARTICIPANT_ID=$(cat /root/.kubelab/participant_id)

if [ -z "$PARTICIPANT_ID" ]; then
    echo "Error: No participant ID found. Please register first."
    exit 1
fi

# Create temporary files for completion status
mkdir -p /tmp/kubelab
COMPLETION_SUCCESS="/tmp/kubelab/completion_success_$TASK_ID"
COMPLETION_ERROR="/tmp/kubelab/completion_error_$TASK_ID"

# Call the completion API
response=$(curl -s -X POST "https://kubelab.tim.it.com/api/complete" \
    -H "Content-Type: application/json" \
    -d "{\"participantId\": $PARTICIPANT_ID, \"taskId\": $TASK_ID}")

if echo "$response" | grep -q "pointsGranted"; then
    points=$(echo "$response" | grep -o '"pointsGranted":[0-9]*' | cut -d':' -f2)
    position=$(echo "$response" | grep -o '"position":[0-9]*' | cut -d':' -f2)
    echo "🎉 Task completed successfully!"
    echo "Points awarded: $points"
    echo "Completion position: $position"
    touch "$COMPLETION_SUCCESS"
    exit 0
else
    error_msg=$(echo "$response" | grep -o '"error":"[^"]*"' | cut -d'"' -f4)
    if [ -z "$error_msg" ]; then
        error_msg="Unknown error occurred"
    fi
    echo "❌ Error completing task: $error_msg"
    echo "$error_msg" > "$COMPLETION_ERROR"
    exit 1
fi
EOF

# Make the completion script executable
chmod +x /usr/local/bin/kubelab/complete-task