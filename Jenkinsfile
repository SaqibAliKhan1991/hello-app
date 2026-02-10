pipeline {
    agent any
    environment {
        DOCKER_HOST = 'unix:///var/run/docker.sock'
    }
    stages {
        stage('Check Docker') {
            steps {
                sh 'docker info'
                sh 'docker images'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hello-app:latest .'
            }
        }
        stage('Tag & Push') {
            steps {
                sh 'docker tag hello-app:latest saqib321/hello-app:latest'
                sh 'docker push saqib321/hello-app:latest'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl set image deployment/hello-app hello-app=saqib321/hello-app:latest'
                sh 'kubectl rollout status deployment/hello-app'
            }
        }
    }
}

