pipeline {
    agent {
        docker {
            image 'node:24'
        }
    }

    environment {
        NPM_CONFIG_CACHE = "${WORKSPACE}/.npm-cache"
        DEPLOY_PATH = "/var/www/html/hitoJenkins"
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
            agent any
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo "Desplegando aplicación al host Jenkins"
                sh """
                    mkdir -p $DEPLOY_PATH
                    cp -r build/* $DEPLOY_PATH/
                """
                echo "Archivos copiados a $DEPLOY_PATH"
            }
        }

        stage('Verify Deployment') {
            agent any
            steps {
                echo "Verificando despliegue"
                sh """
                    if [ -f $DEPLOY_PATH/index.html ]; then
                        echo "index.html encontrado en $DEPLOY_PATH"
                        ls -lh $DEPLOY_PATH
                    else
                        echo "index.html NO encontrado"
                        exit 1
                    fi
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline completado correctamente. Aplicación desplegada en $DEPLOY_PATH"
        }
        failure {
            echo "Hubo fallos en el pipeline, Deploy no ejecutado"
        }
        always {
            echo "Pipeline finalizado"
        }
    }
}
