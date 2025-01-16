#!/bin/bash
#sudo chown -R $(whoami):$(whoami) /var/www/html/testgit1/.git
#chmod -R u+rw /var/www/html/testgit1/.git

# Variables
GIT_REPO="https://github.com/NadeenMK/Dictionary.git"
BRANCH_NAME="main"
JENKINS_JOB_URL="http://localhost:8080/job/Dictionary/build"
JENKINS_AUTH_TOKEN="1122117b8540d8a2c52874490785cbffe1"
DEPLOY_SCRIPT="deploy.sh"
APP_DIR="/var/www/html/testgit1"

# Step 1: Add and commit changes to Git
echo "Adding and committing changes..."
cd $APP_DIR || { echo "Error: Application directory not found!"; exit 1; }
git add .
git commit -m "Automated commit: $(date +'%Y-%m-%d %H:%M:%S')"

# Step 2: Push changes to the remote repository
echo "Pushing changes to the remote repository..."
git push origin $BRANCH_NAME
if [ $? -ne 0 ]; then
    echo "Error: Failed to push changes to the repository. Try 'git pull' to sync changes."
    exit 1
fi


# Step 3: Run the deploy.sh script
echo "Running deployment script..."
bash $DEPLOY_SCRIPT
if [ $? -ne 0 ]; then
    echo "Error: Deployment script failed."
    exit 1
fi

# Step 4: Trigger the Jenkins job
echo "Triggering Jenkins job..."
curl -X POST "$JENKINS_JOB_URL/build?token=$JENKINS_AUTH_TOKEN" --user "nadeen:$JENKINS_AUTH_TOKEN"
if [ $? -ne 0 ]; then
    echo "Error: Failed to trigger Jenkins job."
    exit 1
fi

echo "Automation complete!"
