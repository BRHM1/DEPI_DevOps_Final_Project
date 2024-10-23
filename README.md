# Automated CI/CD Pipeline for Django Web Application

## Project Overview 
This project aims to automate the deployment of a Dockerized Django application on an AWS EC2 instance using Jenkins, Ansible, and Docker. It follows these steps:

1. Docker Compose Manages multi-container setups with MySQL and Django.
2. Jenkins triggers the pipeline to copy files to an EC2 instance.
3. Ansible builds Docker images, pushes them to Docker Hub, and runs containers using Docker Compose.
4. Notifications are sent via email at the end of the build process.

This ensures consistent deployments and eliminates manual processes.

## Tools
| Tool            | Use Case                                                                                  |
|-----------------|--------------------------------------------------------------------------------------------|
| Docker          | Containerization of applications for consistent environments across different systems.     |
| Docker Compose  | Defining and running multi-container Docker applications using a single configuration file. |
| Ansible         | Automating software provisioning, configuration management, and application deployment.    |
| Jenkins         | Automating building, testing, and deploying code in CI/CD pipelines.                       |
| Terraform       | Automating the provisioning of infrastructure resources across cloud platforms.            |

## Prerequisites
- AWS account
- Jenkins server installed
- Ansible installed on Jenkins server
- GitHub repository with Dockerized application code

## Infrastructure Setup Instructions
1. **Clone the Repository**:
   
   ```bash
   git clone https://github.com/mo7amansi/DEPI_DevOps_Final_Project.git
   cd DEPI_DevOps_Final_Project
   ```

2. **Copy jenkins ssh public-key to authorized_keys on EC2 from main file in terraform Directory**:
   
   This will ensure that ansible playbook will run without any problems from jenkins pipeline.
   
3. **Initialize Terraform**:
   
   ```bash
   cd terraform
   terraform init
   ```

4. **Apply the Configuration**:
   
   ```bash
   terraform apply --auto-approve

#### Check Results
#### Once terraform are applied, we will find: 
- The inventory file are changed automatically with EC2 Instance IP
- EC2 private key are generated automatically "mykey.pem" file

5. Add EC2 Instance IP on jenkins pipeline File
6. Push this edits to Github Repo
   
   ```bash
   git add .
   git commit -m "Update"
   git push -u origin main

## Configure Jenkins Server
1. Configure the gmail for tracking build status
2. Add dockerhub Credentials
3. Add private key "mykey.pem" file to Jenkins Credentials.
4. Create a new pipeline and add project repo
5. Build it!

## Check our Application

### Build Status Notification

<div align="center">
    <img src="https://drive.google.com/uc?id=1PDIgIUNhivQRHI2fyBhYxunHzLTIRKgI" alt="Pipeline-Status" />
    <br><br>
</div>

## Final Part
Destroy it!

  ```bash
  terraform destroy
  ```

## Team Members

- **Muhammad Elmansi**
- **Mustafa Elshwaihy**
- **Mahmoud Sedki**
- **Mohamed Eid**
- **Ahmed Ibrahim**
- **Tarek Mohamed**
