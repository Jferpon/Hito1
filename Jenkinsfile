pipeline {
    agent {
        docker { image 'node:24' }
    }

    environment {
        // Cache local dentro del workspace
        NPM_CONFIG_CACHE = "${env.WORKSPACE}/.npm-cache"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install') {
            steps {
                
                sh 'npm config set cache $NPM_CONFIG_CACHE'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test -- --watchAll=false'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build/**', fingerprint: true
            }
        }
    }
}
