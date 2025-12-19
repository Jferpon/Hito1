pipeline {
    agent {
        docker { image 'node:24' }  // Node 24 oficial
    }
    stages {
        stage('Install') {
            steps { sh 'npm install' }
        }
        stage('Build') {
            steps { sh 'npm run build' }
        }
        stage('Archive') {
            steps { archiveArtifacts artifacts: 'build/**', fingerprint: true }
        }
    }
}
