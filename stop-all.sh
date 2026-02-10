#!/bin/bash
set -e

# ===============================
# STOP ALL SERVICES SCRIPT
# ===============================
# Usage: bash stop-all.sh
# Stops Minikube, removes its Docker containers, and stops Docker if needed.
# ===============================

echo "🛑 Stopping Kubernetes deployment..."
kubectl delete deployment hello-app --ignore-not-found
kubectl delete service hello-service --ignore-not-found

echo "🐳 Stopping Minikube..."
minikube stop || echo "Minikube already stopped"

echo "💥 Deleting Minikube cluster to free resources (optional, will recreate on start)..."
minikube delete || echo "Minikube cluster already deleted"

echo "🧹 Stopping Docker containers related to Minikube..."
docker ps -a --filter "name=minikube" --format "{{.ID}}" | xargs -r docker rm -f

echo "✅ All services stopped. Your system resources are freed."

