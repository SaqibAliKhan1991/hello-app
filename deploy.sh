#!/bin/bash

# Stop on any error
set -e

# Use Minikube Docker environment
eval $(minikube docker-env)

# Optional: generate unique tag (timestamp)
TAG=$(date +%s)

echo "Building Docker image hello-app:$TAG ..."
docker build -t hello-app:$TAG .

echo "Updating Kubernetes deployment ..."
kubectl set image deployment/hello-app hello-app=hello-app:$TAG

echo "Waiting for rollout to finish ..."
kubectl rollout status deployment hello-app

echo "Your app is now deployed!"

# Get the service URL
URL=$(minikube service hello-service --url)
echo "Open your app in browser: $URL"
