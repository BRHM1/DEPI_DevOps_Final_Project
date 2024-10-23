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

2. **Configure SSH Access**:

   Add Jenkins' SSH public key to the EC2 instance's authorized_keys on main file from the terraform directory, This will ensure that ansible playbook will run without any  problems from jenkins pipeline.
   
4. **Initialize Terraform**:
   
   ```bash
   cd terraform
   terraform init
   ```

5. **Apply the Configuration**:
   
   ```bash
   terraform apply --auto-approve

#### Check Results
#### Once terraform are applied, we will find: 
- The inventory file is automatically updated with the EC2 instance IP
- A private key (mykey.pem) is generated for secure EC2 access

## Configure Jenkins Server
1. Add EC2 Instance IP on jenkins pipeline File
2. Push this changes to Github Repo
   
   ```bash
   git add .
   git commit -m "Update"
   git push -u origin main
   
3. Set Up Jenkins Server:
   - Configure Gmail for tracking build status and notifications.
   - Add Docker Hub credentials to Jenkins.
   - Upload the private key (mykey.pem) to Jenkins as credentials.
  
4. Create a New Pipeline:
   - Create a new Jenkins pipeline linked to the project repository.
   - Build it!

## Check our Application

<div align="center">
    <img src="https://drive.google.com/uc?id=1uo5_90w0DwGePamsWeUQekTFnjETc3qV" alt="Pipeline-Status" />
    <br><br>
</div>

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

## Team Member

- **Muhammad Elmansi**
- **Mustafa Elshwaihy**
- **Mahmoud Sedki**
- **Mohamed Eid**
- **Ahmed Ibrahim**
- **Tarek Mohamed**

##

This README serves as a complete guide to understanding the project structure, setting up infrastructure, and configuring the Jenkins pipeline. It ensures a seamless deployment process with automation, notifications, and effective infrastructure management.
