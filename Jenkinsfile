pipeline {
    agent {
        docker {
            image 'node:24'
            args '-v $WORKSPACE:$WORKSPACE:rw'
        }
    }

    environment {
        NPM_CONFIG_CACHE = "${WORKSPACE}/.npm-cache"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checkout del repositorio"
                checkout scm
            }
        }

        stage('Install') {
            steps {
                echo "Instalando dependencias"
                sh 'npm ci --cache $NPM_CONFIG_CACHE'
            }
        }

        stage('Test') {
            steps {
                echo "Ejecutando tests"
                sh 'npm test -- --ci --watchAll=false'
            }
        }

        stage('Build') {
            steps {
                echo "Construyendo la app"
                sh 'npm run build'
            }
        }

        stage('Archive') {
            steps {
                echo "Archivando artefactos"
                archiveArtifacts artifacts: 'build/**', fingerprint: true
            }
        }
    }

    post {
        always {
            echo "Pipeline terminado"
        }
        success {
            echo "Todo pasó correctamente"
        }
        failure {
            echo "Hubo fallos en el pipeline"
        }
    }
}
