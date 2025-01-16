# Stop and remove running containers
#ls -ld /var/www/html/testgit1/deploy.sh 
#ls -l /var/www/html/testgit1/deploy.sh 

docker-compose down
 
# Build and run containers
docker-compose up --build -d