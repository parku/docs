node {
    checkout scm

    timestamps {
        stage('Docker Build') {
            sh 'docker build -t parku/docs --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S) .'
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
            sh '`aws ecr get-login`'
            docker.image('parku/docs').push(env.BRANCH_NAME)
        }

        if (env.BRANCH_NAME == "master") {
            stage('Publish to website') {
                sh 'make publish'
            }
        }
    }
}
