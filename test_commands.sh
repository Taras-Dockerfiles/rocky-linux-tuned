# Go to the root of this project
cd ~/Documents/Workspaces/Docker/rocky-tuned

## If the Docker buildx instance is unusable, recreate it
docker buildx rm multiarch
docker buildx create --name multiarch --use

# Make sure the environment file exists
if [ ! -f ./env ]; then
  cp ./env.example ./env
fi

# Build the Docker image
./buildx

# Run a test container
./test
