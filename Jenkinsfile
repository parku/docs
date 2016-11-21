node {
    checkout scm

    def image = docker.build('parku-dev-docs')
    image.inside() {
        stage 'Build'
        sh "make clean generate"


    }

    stage 'Store'
    archive '*.html'
    archive 'images/**'

    stage 'Test Publish'
    publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: './', reportFiles: 'index.html', reportName: 'Parku Developer Documentation'])
}
