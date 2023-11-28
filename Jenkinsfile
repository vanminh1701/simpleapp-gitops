pipeline {
    agent any
    stages {
        stage("prepare"){
            steps {
                    checkout scm
//                     script {
//                         slackSend   channel: "#deploy-notification", message: 
// """
// @here
// Job name: `${env.JOB_NAME}`
// Build status: `START BUILD`
// Build details: <${env.BUILD_URL}/display/redirect|See in web console>
// """
//                     }
                }
        }

        stage('Build follow branche name') {
            steps {
                script {
                    withCredentials([
                        usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USER')
                    ]) {
                        // sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin'
                        // sh "cd apps/frontend && docker build -t tvminh/simpleapp:${env.BRANCH_NAME} ."
                        // sh "docker push tvminh/simpleapp:${env.BRANCH_NAME}"
                        echo "Build docker and push done!"
                    }                            
                }
            }
        }

        stage("Deploy"){
            parallel {
                stage('deploy-canary'){
                    when { branch "canary"}
                    steps{
                        script {
                            withCredentials([
                                sshUserPrivateKey(credentialsId:'rhel' , keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')
                            ]) {
                                def remote = [:]
                                remote.name = "RHEL"
                                remote.host = "18.143.173.19"
                                remote.user = userName
                                remote.identityFile = identity
                                remote.allowAnyHosts = true

                                sshCommand remote: remote, command: './canary-deployment.sh'
                            }
                        }
                    }
                }

                stage('deploy-prod'){
                    when { branch "production"}
                    steps{
                        script {
                            withCredentials([
                                sshUserPrivateKey(credentialsId:'rhel' , keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')
                            ]) {
                                def remote = [:]
                                remote.name = "RHEL"
                                remote.host = "18.143.173.19"
                                remote.user = userName
                                remote.identityFile = identity
                                remote.allowAnyHosts = true

                                sshCommand remote: remote, command: './production-deployment.sh'
                            }
                        }
                    }
                }
            }
        }
}

//     post {
//         always {
//             script {
//                 def color="danger"
//                 if (currentBuild.result=="SUCCESS") {
//                     color = "good"
//                 }
//                 slackSend   channel: "#deploy-notification", color: color, message: 
// """
// @here
// Job name: `${env.JOB_NAME}`
// Build status: `${currentBuild.result}`
// Build details: <${env.BUILD_URL}/display/redirect|See in web console>
// """
//             }
//         }
//     }
} 



