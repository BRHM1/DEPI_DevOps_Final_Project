pipeline {
    agent any
    
    stages {
        stage('Copy Files to EC2') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2_key', keyFileVariable: 'keyfile')]) {
                    sh 'scp -i $keyfile -o StrictHostKeyChecking=no -r * /var/lib/jenkins/workspace/depiii ubuntu@54.80.91.90:/home/ubuntu'
                }
            }
        }

        stage('Build, Push & Run Container') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2_key', keyFileVariable: 'keyfile')]) {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerpass', usernameVariable: 'dockeruser')]) {
                        sh 'ansible-playbook -i inventory.ini ansible-playbook.yml --private-key=$keyfile -e "docker_username=${docker_user} docker_password=${docker_pass}"'
                    }
                }
            }
        }
    }

    post { 
        always { 
            script { 
                def emailNotification = load 'mail-notification.groovy'
                emailNotification.sendEmailNotification()
            } 
        } 
    } 
}
