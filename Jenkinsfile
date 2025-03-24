pipeline {
  agent {
    kubernetes {
      cloud "kubernetes"
      yamlFile "agent-build.yaml"
    }
  }
  stages {
    stage('Build and Push to GCR') {
      steps {
        container("gcloud-builder") {
          script {
            // Ensure Git repository is trusted (if needed)
            sh 'git config --global --add safe.directory $WORKSPACE'
            // Generate a unique tag using the commit hash
            def commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
            env.dockerTag = "dev-commit-${commitHash}-${BUILD_NUMBER}"
            env.gkeClusterName = 'test-cluster-1'
            env.Zone = 'us-central1-c'
            env.gkeProject = 'cloud-computing-sp25'

            // Build Docker image
            sh "docker build -t portfolio-app:${env.dockerTag} ."

            // Authenticate to GCR using credentials (ideally using Jenkins credentials or Workload Identity)
            withCredentials([file(credentialsId: 'gcr-id', variable: 'SERVICE_ACCOUNT_KEY')]) {
              sh 'gcloud auth activate-service-account --key-file=$SERVICE_ACCOUNT_KEY'
              sh "gcloud auth configure-docker"
            }

            // Tag and push image to GCR
            env.gcrImage = "gcr.io/${env.gkeProject}/portfolio-app:${env.dockerTag}"
            sh "docker tag portfolio-app:${env.dockerTag} ${env.gcrImage}"
            sh "docker push ${env.gcrImage}"
          }
        }
      }
    }
    stage('Deploy to GKE') {
      steps {
        container("gcloud-builder") {
          script {
            // Update the deployment image in GKE
            sh "kubectl set image deployment/portfolio-app portfolio-app=${env.gcrImage} -n portfolio"
          }
        }
      }
    }
  }
post {
  always {  
      cleanWs()
      deleteDir()  
  }
}
}
