#!/bin/bash

# Clear the screen for a clean start
clear

# Create a temporary directory for communication if it doesn't exist
mkdir -p /tmp/kubelab

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