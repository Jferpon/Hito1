pipeline {
    agent {
        docker { image 'node:24' }
    }
    stages {
        stage('Install') {
            steps { sh 'npm install' }
        }
        stage('Test') {
            steps { 
                sh 'npm test -- --watchAll=false' 
            }
            post {
                always {
                    junit '**/test-results/**/*.xml'
                }
            }
        }
        stage('Build') {
            steps { sh 'npm run build' }
        }
        stage('Archive') {
            steps { archiveArtifacts artifacts: 'build/**', fingerprint: true }
        }
    }
}
