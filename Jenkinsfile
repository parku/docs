node {
    checkout scm

    sh 'docker build -t parku-dev-docs --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S) .'

    withDockerContainer('parku-dev-docs') {
        stage 'Build'
        sh "make clean all"
    }

    stage 'Store'
    archive 'build/**'

    stage 'Test Publish'
    publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'build', reportFiles: 'index.html', reportName: 'Parku Developer Documentation'])
}
