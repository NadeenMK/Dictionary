#!/bin/bash

# Variables
GIT_REPO="https://github.com/NadeenMK/Dictionary.git"  
BRANCH_NAME="main"  
JENKINS_JOB_URL="http://localhost:8080/job/Dictionary/build" 
JENKINS_AUTH_TOKEN="1122117b8540d8a2c52874490785cbffe1" # Replace with your Jenkins job URL
SERVER_SSH="root@dictionary_www_1"
APP_DIR="/var/www/html/testgit1"  # Corrected path to application directory

# Step 4: Develop and commit changes locally (manual step, not automated)

# Step 5: Push code to the remote Git repository
echo "Pushing code to Git repository..."
git add .
git commit -m "Automated commit: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin $BRANCH_NAME
if [ $? -ne 0 ]; then
    echo "Error: Failed to push code to Git repository."
    exit 1
fi

# Step 6: Trigger Jenkins job to pull, compile, run, and deploy
echo "Triggering Jenkins job..."
curl -X POST "$JENKINS_JOB_URL/build?token=$JENKINS_AUTH_TOKEN" --user "omaima:$JENKINS_AUTH_TOKEN"
if [ $? -ne 0 ]; then
    echo "Error: Failed to trigger Jenkins job."
    exit 1
fi

# Optional: Verify deployment inside the Docker container
echo "Verifying deployment inside the Docker container..."

# Start the Docker container if it's not already running
docker start dictionary_www_1
if [ $? -ne 0 ]; then
    echo "Error: Failed to start Docker container."
    exit 1
fi

# Call deploy.sh to handle Docker container rebuilding and restarting
echo "Calling deploy.sh to rebuild Docker containers..."
./deploy.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to execute deploy.sh."
    exit 1
fi

# Check if the services are up and running
docker ps

echo "Automation complete!"
