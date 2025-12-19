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
                echo "Construyendo la aplicación"
                sh 'CI=false npm run build'
            }
        }

        stage('Archive') {
            steps {
                echo "Archivando artefactos"
                archiveArtifacts artifacts: 'build/**', fingerprint: true
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo "Desplegando aplicación"
                sh """
                    rm -rf ${DEPLOY_PATH}/*
                    cp -r build/* ${DEPLOY_PATH}/
                """
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Verificando despliegue"
                sh """
                    if [ -f ${DEPLOY_PATH}/index.html ]; then
                        echo "Despliegue correcto"
                        ls -lh ${DEPLOY_PATH}
                    else
                        echo "Error: index.html no encontrado"
                        exit 1
                    fi
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline completado correctamente"
            echo "Aplicación disponible en http://localhost/hitoJenkins"
        }
        failure {
            echo "El pipeline ha fallado"
        }
        always {
            echo "Pipeline finalizado"
        }
    }
}
