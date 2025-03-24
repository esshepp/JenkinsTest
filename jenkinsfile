Jenkinsfile (Declarative Pipeline)
/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { image 'golang:1.24.1-alpine3.21' } }
    stages {
        stage('build') {
            steps {
                sh 'go version'
            }
        }
    }
}
