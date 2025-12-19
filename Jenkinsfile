pipeline {
    agent {
        docker {
            image 'node:24'
        }
    }

    environment {
        NPM_CONFIG_CACHE = "${WORKSPACE}/.npm-cache"
        APP_IMAGE = "hito-jenkins-app:latest"   // nombre de la imagen Docker
        DEPLOY_PORT = "3000"                    // puerto de la app
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

        stage('Deploy') {
            steps {
                echo "Desplegando la aplicación en Docker"

                // Construir imagen Docker usando build
                sh """
                docker build -t $APP_IMAGE .
                """

                // Detener contenedor existente si lo hay
                sh """
                if [ \$(docker ps -q -f name=hito-jenkins-container) ]; then
                    docker stop hito-jenkins-container
                    docker rm hito-jenkins-container
                fi
                """

                // Ejecutar nuevo contenedor
                sh """
                docker run -d --name hito-jenkins-container -p $DEPLOY_PORT:3000 $APP_IMAGE
                """

                echo "Aplicación desplegada en el puerto $DEPLOY_PORT"
            }
        }
    }

    post {
        always {
            echo "Pipeline terminado"
        }
        success {
            echo "Todo pasó correctamente, aplicación desplegada"
        }
        failure {
            echo "Hubo fallos en el pipeline, Deploy no ejecutado"
        }
    }
}
