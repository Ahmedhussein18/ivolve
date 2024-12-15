// vars/BuildAndPush.groovy
def call(Map params) {
    // Extract parameters
    def githubCredentialsId = params.githubCredentialsId
    def githubRepo = params.githubRepo
    def dockerhubCredentialsId = params.dockerhubCredentialsId
    def dockerhubUserName = params.dockerhubUserName
    def imageName = params.imageName
    def imageTag = params.imageTag ?: "latest"  // Default to 'latest' if not provided

    // Clone repository
    stage('Clone Repository') {
        withCredentials([usernamePassword(credentialsId: githubCredentialsId, usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
            git(branch: 'main', credentialsId: githubCredentialsId, url: githubRepo)
        }
    }

    // Build Docker Image
    stage('Build Docker Image') {
        sh "docker build -t ${dockerhubUserName}/${imageName}:${imageTag} ."
    }

    // Push Docker Image
    stage('Push Docker Image') {
        withCredentials([usernamePassword(credentialsId: dockerhubCredentialsId, passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
            sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
            sh "docker push ${dockerhubUserName}/${imageName}:${imageTag}"
        }
    }
}
