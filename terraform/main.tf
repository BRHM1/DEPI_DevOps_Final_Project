resource "aws_instance" "ubuntu-instance" {
  ami           = var.ami
  instance_type = "t3.micro"
  key_name      = aws_key_pair.UbuntuKP.key_name
  security_groups = ["${aws_security_group.UbuntuSG.name}"]

  # Add shell script to install Docker
  user_data = <<-EOF
                    #!/bin/bash
                    sudo apt-get update
                    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
                    # Add Docker GPG key
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                    # Add Docker repository
                    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                    # Update the package index and install Docker
                    sudo apt-get update
                    sudo apt-get install -y docker-ce
                    # Start and enable Docker
                    sudo systemctl start docker
                    sudo systemctl enable docker
                    # Add current user to Docker group
                    sudo groupadd docker
                    sudo usermod -aG docker $USER && newgrp docker
                    # Give permissions to Docker socket
                    sudo chmod 777 /var/run/docker.sock
                    # Install Docker Compose
                    sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                    # Apply executable permissions to the Docker Compose binary
                    sudo chmod +x /usr/local/bin/docker-compose
                  EOF

  tags  = {
    Name  = "Ubuntu-EC2"
  }

}
