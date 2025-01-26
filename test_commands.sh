# Go to the root of this project
cd ~/Documents/Workspaces/Docker/rocky-tuned

## If the Docker buildx instance is unusable, recreate it
docker buildx rm multiarch
docker buildx create --name multiarch --use

# Build the Docker image
docker buildx build --no-cache --progress=plain --push --platform linux/amd64,linux/arm64/v8 --rm -t wujidadi/rocky-linux-tuned:3.7 -t wujidadi/rocky-linux-tuned:latest . 2>&1 | tee $D/docker-build-rlt-3.7.log

# Create testing container
docker run -d -p 50000:80 -it --name Test wujidadi/rocky-linux-tuned:3.7

# Test the container outside itself by each command
docker exec -it Test cat /etc/os-release | grep VERSION
docker exec -it Test vim --version | grep 'Included patches'
docker exec -it Test nano -V | grep 'GNU nano, version'

# Test the container outside itself by one command
docker exec -it Test bash -c "cat /etc/os-release | grep VERSION; \
vim --version | grep 'Included patches'; \
nano -V | grep 'GNU nano, version'"

# Delete the testing containter finally
docker stop Test; docker rm Test
