pipeline {
    agent any
 
    environment {
        IMAGE_NAME = "heena98/myapp"  // Replace with your Docker Hub image name
    }
 
    stages {
        stage('Clone Repository') {
            steps {
                echo "Cloning GitHub repository..."
                checkout scm
            }
        }
 
        stage('Build Docker Image') {
            steps {
                script {
dockerImage = docker.build("${IMAGE_NAME}:latest")
                }
            }
        }
 
        stage('Push Docker Image') {
            steps {
                script {
docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        dockerImage.push()
                    }
                }
            }
        }
 
        stage('Cleanup') {
            steps {
                sh 'docker rmi ${IMAGE_NAME}:latest || true'
            }
        }
 
        // Optional: Add deploy to EKS in the next lesson
    }
 
    post {
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
