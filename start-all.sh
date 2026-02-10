#!/bin/bash
set -e

# ===============================
# START ALL SERVICES SCRIPT
# ===============================
# Usage: bash start-all.sh
# This script starts Docker, Minikube, builds the app image, and deploys it on Kubernetes.
# ===============================

# --- Set variables ---
PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
IMAGE_NAME="hello-app"
IMAGE_TAG="latest"
DEPLOYMENT_FILE="$PROJECT_ROOT/k8s/deployment.yaml"
SERVICE_FILE="$PROJECT_ROOT/k8s/service.yaml"

echo "🚀 Starting Docker..."
sudo systemctl start docker || echo "Docker already running"

echo "🐳 Starting Minikube..."
minikube start --driver=docker

# Ensure we are using Minikube's Docker environment
echo "🔧 Configuring shell to use Minikube Docker..."
eval "$(minikube -p minikube docker-env)"

# Move to project root to ensure Dockerfile is accessible
cd "$PROJECT_ROOT"

echo "📦 Building Docker image $IMAGE_NAME:$IMAGE_TAG ..."
docker build -t "$IMAGE_NAME:$IMAGE_TAG" .

echo "📤 Applying Kubernetes manifests..."
kubectl apply -f "$DEPLOYMENT_FILE"
kubectl apply -f "$SERVICE_FILE"

echo "✅ Deployment triggered. Use below command to get the service URL:"
echo "   minikube service hello-service --url"

