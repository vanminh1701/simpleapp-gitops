pipeline {
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
                        sshUserPrusernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USER')
                    ]) {
                        sh 'docker login -u $DOCKER_USER --password $DOCKER_PASSWORD'
                        sh "cd apps/frontend && docker build -t tvminh/simpleapp:${env.BRANCH_NAME} ."
                        sh "docker push tvminh/simpleapp:${env.BRANCH_NAME}"
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
                            echo "Pull the manifest repo and update resources"
                        }
                    }
                }
                stage('deploy-prod'){
                    when { branch "master"}
                    steps{
                        script {
                            echo "Pull the manifest repo and update resources"
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



