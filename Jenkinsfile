node {
    checkout scm

    def image = docker.build('parku-dev-docs')
    image.inside() {
        stage 'Build'
        sh "make clean all"


    }

    stage 'Store'
    archive 'build/**'

    stage 'Test Publish'
    publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'build', reportFiles: 'index.html', reportName: 'Parku Developer Documentation'])
}
