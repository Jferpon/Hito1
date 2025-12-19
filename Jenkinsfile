pipeline {
    agent {
        docker { 
            image 'node:24' 
            args '-u 1000:1000' // Corre como usuario no root, evita problemas de permisos
        }
    }

    environment {
        // Cache local dentro del workspace
        NPM_CONFIG_CACHE = "${env.WORKSPACE}/.npm-cache"
        // Configuración de npm para que use un npmrc dentro del workspace
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
                // Configura cache y npmrc locales
                sh 'npm config set cache $NPM_CONFIG_CACHE --global'
                sh 'npm config set userconfig $NPM_CONFIG_USERCONFIG'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                // Corre los tests sin watch, exit code detiene pipeline si falla
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
