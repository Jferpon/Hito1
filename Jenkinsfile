pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                sh '''
                    echo "Ejecutando tests..."
                    for test in tests/*.sh; do
                        echo "Ejecutando $test"
                        bash "$test"  
                    done
                '''
            }
        }

        stage('Build') {
            steps {
                echo "Ejecutando build..."
                sh 'echo "Hola, esto es un artefacto" > build.txt'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build.txt', fingerprint: true
            }
        }
    }
}

