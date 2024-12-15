@Library('FirstShareLibrary') _

pipeline {
    agent any
    environment {
        KUBE_DEPLOY_FILE = 'deployment.yaml'
        DOCKER_IMAGE = 'ahmedhussein18/ivolve-image:latest'
        githubCredentialsId = 'github-token'
        githubRepo = 'https://github.com/IbrahimAdell/Lab.git'
        dockerhubCredentialsId = 'dockerhub-access-token'
        dockerhubUserName = 'ahmedhussein18'
        imageName= 'ivolve-image'
        imageTag= 'latest'
        credentialsId = 'kubeconfig-file-id'
    }
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    BuildAndPush(
                        githubCredentialsId: "${env.githubCredentialsId}",
                        githubRepo: "${env.githubRepo}",
                        dockerhubCredentialsId: "${env.dockerhubCredentialsId}",
                        dockerhubUserName: "${env.dockerhubUserName}",
                        imageName: "${env.imageName}",
                        imageTag: "${env.imageTag}"
                    )
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    DeployToKubernetes(
                        kubeDeployFile: "${env.KUBE_DEPLOY_FILE}",
                        imageName: "${env.imageName}",
                        credentialsId: "${env.credentialsId}"
                    )
                }
            }
        }
    }
}
