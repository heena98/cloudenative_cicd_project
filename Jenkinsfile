
pipeline {
  agent any

  environment {
    IMAGE_NAME = "heena-demo-app"
    DOCKER_REGISTRY = "heenadevops.jfrog.io/docker-virtual"
    AWS_DEFAULT_REGION = "us-east-1"
    IMAGE_TAG = "1.0"
  }

  stages {
    stage('Checkout Code') {
      steps {
        git branch: 'main', credentialsId: 'your-github-creds-id', url: 'https://github.com/your/repo.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG .'
      }
    }

    stage('Tag Docker Image') {
      steps {
        sh 'docker tag heena-demo-app:1.0 $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG'
      }
    }

    stage('Push to JFrog') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'jfrog-creds-id', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
          sh '''
            echo "$PASS" | docker login -u "$USER" --password-stdin $DOCKER_REGISTRY
            docker push $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG
          '''
        }
      }
    }

    stage('Update K8s Deployment') {
      steps {
        sh '''
          sed -i 's|image:.*|image: $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG|' deployment.yaml
        '''
      }
    }

    stage('Deploy to EKS') {
      steps {
        sh 'kubectl apply -f deployment.yaml'
        sh 'kubectl apply -f service.yaml'
      }
    }
  }

  post {
    success {
      echo "✅ Deployment successful: $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG"
    }
    failure {
      echo "❌ Deployment failed. Check logs for details."
    }
  }
}

