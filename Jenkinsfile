node {
    checkout scm

    timestamps {
        stage('Docker Build') {
            sh 'docker build -t parku/docs:${BRANCH_NAME} --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S) .'
        }

        stage('Build Docs') {
            withDockerContainer('parku/docs') {
                sh "make clean all"
            }
        }

        stage('Store') {
            archive 'build/**'
        }

        stage('Test Publish') {
            publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'build', reportFiles: 'index.html', reportName: 'Parku Developer Documentation'])
        }

        stage('Docker push to Amazon ECR') {
            sh 'docker tag parku/docs:${BRANCH_NAME} 715994263731.dkr.ecr.eu-central-1.amazonaws.com/parku/docs:${BRANCH_NAME}'
            sh 'docker push 715994263731.dkr.ecr.eu-central-1.amazonaws.com/parku/docs:${BRANCH_NAME}'
        }

        if (env.BRANCH_NAME == "master") {
            stage('Publish to website') {
                sh 'make publish'
            }
        }
    }
}
