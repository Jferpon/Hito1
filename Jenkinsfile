pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                    echo "Ejecutando build..." 
                 sh'  echo "Hola, esto es un artefacto" > build.txt'
                
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build.txt', fingerprint: true
            }
        }
    }
}

