#!/bin/bash
set -e

echo "🚀 Starting Docker..."
sudo systemctl start docker || echo "Docker already running"

echo "🐳 Starting Minikube..."
minikube start --driver=docker

# Make sure shell is using Minikube's Docker
eval $(minikube -p minikube docker-env)

echo "📦 Building Docker image hello-app..."
docker build -t hello-app:latest .

echo "🔧 Deploying to Kubernetes..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "✅ Application deployed!"

# Jenkins setup
echo "🔹 Starting Jenkins container (persistent volume)..."
# Check if the container exists
if [ "$(docker ps -a -q -f name=jenkins)" ]; then
    echo "Jenkins container exists. Starting..."
    docker start jenkins
else
    echo "Creating Jenkins container with persistent volume..."
    docker run -d \
      --name jenkins \
      -p 8080:8080 \
      -p 50000:50000 \
      -v jenkins_home:/var/jenkins_home \
      jenkins/jenkins:lts
fi

echo "✅ Jenkins should be running at http://localhost:8080"
echo "   Initial admin password (if first run) can be found with:"
echo "   docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword"

# Optional: print Minikube service URL
echo "🌐 Get your hello-app URL with:"
echo "   minikube service hello-service --url"

