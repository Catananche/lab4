pipeline {
    agent {
        label 'agent-node-label'
    }

    environment {
        APP_NAME = 'bilous_karina'
        DOCKER_IMAGE_NAME = 'bilous_karina'
        GOCACHE="/home/jenkins/.cache/go-build/"
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Compile') {
            agent {
                docker {
                    image 'golang:1.21.3'
                    reuseNode true
                }
            }
            steps {
                sh "CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags '-w -s -extldflags \"-static\"' -o ${APP_NAME} ."
            }
        }

        stage('Unit Testing') {
            agent {
                docker {
                    image 'golang:1.21.3'
                    reuseNode true
                }
            }
            steps {
                sh 'go test ./...'
            }
        }

        stage('Archive Artifact and Build Docker Image') {
            parallel {
                stage('Archive Artifact') {
                    steps {
                        sh "tar -czvf ${APP_NAME}_${env.BUILD_NUMBER}.tar.gz ${APP_NAME}"
                        archiveArtifacts artifacts: "${APP_NAME}_${env.BUILD_NUMBER}.tar.gz", fingerprint: true
                    }
                }

                stage('Build Docker Image') {
                    steps {
                        sh "docker build --build-arg APP_NAME=${APP_NAME} -t ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} ."
                    }
                }
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: "${APP_NAME}_${env.BUILD_NUMBER}.tar.gz", fingerprint: true
        }
        always {
            echo 'Pipeline finished'
        }
    }
}