pipeline {
        agent any
        environment {
            registry = "leernd/my-web-app"
            registryCredentials = 'dockerhub'
            ARTVERSION = "${env.BUILD_ID}"
        }

        stages{
            stage('Fetch Code') {
                steps {
                    git branch: 'main', url: 'https://github.com/leernd007/cicd-kube-app.git'
                }
            }
            stage('Build App Image') {
                steps {
                    script {
                        dockerImage = docker.build registry + ":V$BUILD_NUMBER"
                    }
                }
            }
            stage('Upload Image') {
                steps {
                    script {
                        docker.withRegistry('', registryCredentials) {
                            dockerImage.push("V$BUILD_NUMBER")
                            dockerImage.push("latest")
                        }
                    }
                }
            }
            stage('Remove Unused docker image') {
                steps {
                    sh "docker rmi $registry:V$BUILD_NUMBER"
                }
            }

            stage('Kubernetes deploy') {
                agent {label 'KOPS'}
                steps {
                    sh "helm upgrade --install --force web-app-stack helm/web-app-charts --set appimage=${registry}:V${BUILD_NUMBER} content="Hello world" --namespace dev"
                }
            }
        }
}