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
                echo "Construyendo la aplicación React"
                sh 'CI=false npm run build'
            }
        }

        stage('Archive') {
            steps {
                echo "Archivando artefactos del build"
                archiveArtifacts artifacts: 'build/**', fingerprint: true
            }
        }

        stage('Deploy') {
            agent { label 'master' }
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo "Desplegando aplicación en ${DEPLOY_PATH}"
                sh """
                    rm -rf ${DEPLOY_PATH}/*
                    cp -r build/* ${DEPLOY_PATH}/
                """
            }
        }

        stage('Verify Deployment') {
            agent { label 'master' }
            steps {
                echo "Verificando despliegue"
                sh """
                    if [ -f ${DEPLOY_PATH}/index.html ]; then
                        echo "index.html encontrado"
                        ls -lh ${DEPLOY_PATH}
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
            echo "Pipeline completado correctamente"
            echo "Aplicación desplegada en http://localhost/hitoJenkins"
        }
        failure {
            echo "El pipeline ha fallado"
        }
        always {
            echo "Pipeline finalizado"
        }
    }
}
