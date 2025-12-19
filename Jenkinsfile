pipeline {
    agent {
        docker { 
            image 'node:24' 
        }
    }

    environment {
        // Opcional: forzar cache de npm en workspace
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
                // Configura cache local y luego instala dependencias
                sh 'npm config set cache $NPM_CONFIG_CACHE --global'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                // Ejecuta los tests y falla si alguno no pasa
                sh 'npm test -- --watchAll=false'
            }
            post {
                always {
                    // Guardar los resultados de Jest (opcional, si quieres reportes)
                    junit '**/test-results/**/*.xml'
                }
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
