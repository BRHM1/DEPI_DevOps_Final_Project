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
        stage('Build & push & run cont') {
            steps { 
                sh "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./inventory ansible-playbook.yml"
            }
        }
    }

    post{ 
        always{ 
            script { 
                def emailNotification = load 'mail-notification.groovy'
                emailNotification.sendEmailNotification()
            } 
        } 
    } 
}
