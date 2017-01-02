node {
    checkout scm

    stage 'Docker Build'
    sh 'docker build -t parku/docs --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S) .'

    stage 'Build Docs'
    withDockerContainer('parku/docs') {
        sh "make clean all"
    }

    stage 'Store'
    archive 'build/**'

    stage 'Test Publish'
    publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'build', reportFiles: 'index.html', reportName: 'Parku Developer Documentation'])

    stage 'Docker push to Amazon ECR'

    docker.withRegistry('https://715994263731.dkr.ecr.eu-central-1.amazonaws.com/parku/docs ', 'ecr:eu-central-1:jenkins-iam-credentials') {
        sh '`aws ecr get-login --region eu-central-1`'
        docker.image('parku/docs').push(env.BRANCH_NAME)
    }

    stage 'Publish to website'
    if (env.BRANCH_NAME == "master") {
        sh 'make publish'
    }
}
