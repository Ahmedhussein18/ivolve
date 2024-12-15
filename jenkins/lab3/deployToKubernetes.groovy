def call(String kubeDeployFile, String imageName, String credentialsId) {
    pipeline {
        agent any
        environment {
            KUBE_DEPLOY_FILE = kubeDeployFile
            DOCKER_IMAGE = dockerImage
        }
        stages {
            stage('Ensure Deployment YAML Exists') {
                steps {
                    script {
                        if (!fileExists(env.KUBE_DEPLOY_FILE)) {
                            sh "kubectl create deployment ivolve --image=${env.DOCKER_IMAGE} --replicas=3 --dry-run=client -o yaml > ${env.KUBE_DEPLOY_FILE}"
                        }
                    }
                }
            }
            stage('Update Deployment YAML') {
                steps {
                    script {
                        sh "sed -i 's|<IMAGE_PLACEHOLDER>|${env.DOCKER_IMAGE}|g' ${env.KUBE_DEPLOY_FILE}"
                    }
                }
            }
            stage('Deploy to Kubernetes') {
                steps {
                    withCredentials([file(credentialsId: credentialsId, variable: 'KUBE_CONFIG')]) {
                        script {
                            sh '''
                            export KUBECONFIG=$KUBE_CONFIG
                            kubectl apply -f ${KUBE_DEPLOY_FILE}
                            '''
                        }
                    }
                }
            }
        }
    }
}
