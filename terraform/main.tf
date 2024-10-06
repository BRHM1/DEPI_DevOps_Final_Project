resource "aws_instance" "ubuntu-instance" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = "mykey"
  security_groups = ["${aws_security_group.UbuntuSG.name}"]

  # Add shell script to install Docker
  user_data = <<-EOF
                    #!/bin/bash
                    sudo apt-get update
                    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                    sudo apt-get update
                    sudo apt-get install -y docker-ce
                    sudo systemctl start docker
                    sudo systemctl enable docker
                    sudo groupadd docker
                    sudo usermod -aG docker $USER && newgrp docker
                    sudo chmod 777 /var/run/docker.sock
                  EOF

  tags  = {
    Name  = "Ubuntu-EC2"
  }

  # Create inventory file for ansible
    provisioner "local-exec" {
    command = "echo '[my_ec2]' > ../inventory.txt && echo '${self.public_ip}' >> ../inventory.txt"
  }


}
