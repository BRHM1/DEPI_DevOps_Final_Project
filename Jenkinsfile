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

        stage('Test Ansible') {
            steps {
                sh "ansible --version"
            }
        }

        stage('Build, Push & Run Container') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2_key', keyFileVariable: 'KEY_FILE')]) {
                    sh '''
                        ansible-playbook -i inventory.txt ansible-playbook.yml --private-key=$KEY_FILE -vvvv
                    '''
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
