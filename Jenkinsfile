pipeline {
    agent any
    
    stages {
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerpass', usernameVariable: 'dockeruser')]) {
                    sh 'echo $dockerpass | docker login -u $dockeruser --password-stdin'
                }
            }
        }

        stage('Copy Files to EC2') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2_key', keyFileVariable: 'keyfile')]) {
                    sh 'scp -i $keyfile -o StrictHostKeyChecking=no -r * /var/lib/jenkins/workspace/depiii ubuntu@54.167.50.33:/home/ubuntu'
                }
            }
        }

        stage('Build, Push & Run Container') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2_key', keyFileVariable: 'keyfile')]) {
                sh 'ansible-playbook -i inventory.ini ansible-playbook.yml --private-key=$keyfile'
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
