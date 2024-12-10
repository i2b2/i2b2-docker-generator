#docker login
docker commit i2b2-pg i2b2/i2b2-pg:local-build-v1
echo "Completed committing the docker image."

docker build -t i2b2/i2b2-pg:supervisord-local-v1 .
echo "Docker image built successfully."