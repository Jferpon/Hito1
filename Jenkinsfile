pipeline {
    agent {
        docker { 
            image 'node:24'
            args '-u 1000:1000' // usuario no root para evitar permisos
        }
    }

    environment {
        NPM_CONFIG_CACHE = "${env.WORKSPACE}/.npm-cache"
        NPM_CONFIG_USERCONFIG = "${env.WORKSPACE}/.npmrc"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install') {
            steps {
                sh 'npm install --cache $NPM_CONFIG_CACHE --userconfig $NPM_CONFIG_USERCONFIG'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test -- --watchAll=false --ci'
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
