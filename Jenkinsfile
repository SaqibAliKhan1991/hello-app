pipeline {
  agent any

  stages {
    stage("Build Docker Image") {
      steps {
        sh 'docker build -t saqib321/hello-app:latest .'
      }
    }

    stage("Push Image") {
      steps {
        sh 'docker push saqib321/hello-app:latest'
      }
    }

    stage("Deploy to Kubernetes") {
      steps {
        sh 'kubectl apply -f k8s/'
      }
    }
  }
}
