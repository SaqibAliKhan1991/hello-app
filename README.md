**Hello App**

A simple Node.js web application deployed using Docker, Kubernetes (Minikube), and automated through a Jenkins CI/CD pipeline. This project demonstrates modern DevOps practices including containerization, continuous integration, and deployment automation.

**Table of Contents**

Features

Tech Stack

Project Structure

Setup & Installation

Deployment

CI/CD Pipeline

Usage

Troubleshooting

Contributing



**Features**

Containerized Node.js application using Docker

Kubernetes deployment using Minikube

Automated build, push, and deployment using Jenkins

Easy testing with kubectl port-forward or minikube service

Demonstrates proper Docker image management and imagePullPolicy configuration

**Tech Stack**

Language: Node.js

Containerization: Docker

Orchestration: Kubernetes (Minikube)

CI/CD: Jenkins

Version Control: Git/GitHub

**Project Structure**
hello-app/
├── Dockerfile            # Defines Docker image
├── Jenkinsfile           # Pipeline configuration for CI/CD
├── app.js                # Main Node.js application
├── package.json          # Node.js dependencies
├── public/               # Static assets
├── k8s/
│   ├── deployment.yaml   # Kubernetes deployment manifest
│   └── service.yaml      # Kubernetes service manifest
└── deploy.sh             # Optional script to build, push, and deploy

**Setup & Installation**
**Prerequisites**

Docker installed and running

Minikube installed

Kubectl configured for your cluster

Jenkins installed and configured (optional for CI/CD)

**Local Setup**
# Clone the repository
git clone git@github.com:SaqibAliKhan1991/curriculum-vitae.git
cd curriculum-vitae

# Build Docker image locally
docker build -t hello-app:latest .

# Run locally to test
docker run -p 3000:3000 hello-app:latest

**Deployment**
**Using Minikube**
# Start Minikube
minikube start --driver=docker

# Point Docker CLI to Minikube
eval $(minikube docker-env)

# Build Docker image inside Minikube
docker build -t hello-app:latest .

# Apply Kubernetes manifests
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Check pods
kubectl get pods -w

# Access the service
kubectl port-forward svc/hello-service 8080:80

******CI/CD Pipeline**
****
The project includes a Jenkins Pipeline for automated builds and deployments:

**Checkout code from GitHub**

**Build Docker image** using docker build

**Push Docker image** to Docker Hub (or private registry)

**Update Kubernetes deployment** with new image

**Rollout monitoring** to ensure pods are running

****Example Jenkinsfile snippet**:
pipeline {
    agent any
    environment {
        DOCKER_HOST = 'unix:///var/run/docker.sock'
    }
    stages {
        stage('Checkout') {
            steps {
                git 'git@github.com:SaqibAliKhan1991/curriculum-vitae.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hello-app:latest .'
            }
        }
        stage('Push & Deploy') {
            steps {
                sh 'docker tag hello-app:latest saqib321/hello-app:latest'
                sh 'docker push saqib321/hello-app:latest'
                sh 'kubectl set image deployment/hello-app hello-app=saqib321/hello-app:latest'
                sh 'kubectl rollout status deployment/hello-app'
            }
        }
    }
}

**Usage**

Once deployed, access the app:

Locally via port-forward: http://localhost:8080

Using Minikube service: minikube service hello-service --url

**Troubleshooting**

ImagePullBackOff / ErrImageNeverPull: Ensure Docker image is built inside Minikube or accessible via a registry.

Port conflicts: Check if another process is using the port with sudo lsof -i :8080.

Minikube issues: Delete and recreate cluster with minikube delete && minikube start --driver=docker.

**Contributing**

Fork the repository

Create a feature branch (git checkout -b feature/my-feature)

Commit changes (git commit -m 'Add feature')

Push branch (git push origin feature/my-feature)

Create a pull request
