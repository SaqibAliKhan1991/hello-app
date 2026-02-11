#!/bin/bash
set -e

echo "🛑 Stopping hello-app Kubernetes deployment..."
kubectl delete deployment hello-app --ignore-not-found
kubectl delete service hello-service --ignore-not-found

echo "🐳 Stopping Minikube..."
minikube stop || echo "Minikube is not running"

echo "🔹 Stopping Jenkins container (persistent volume kept)..."
if [ "$(docker ps -q -f name=jenkins)" ]; then
    docker stop jenkins
    echo "Jenkins stopped"
else
    echo "Jenkins container not running"
fi

echo "✅ All services stopped safely!"
echo "   Jenkins data and Docker images are preserved."

