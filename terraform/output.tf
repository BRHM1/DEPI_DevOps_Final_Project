output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ubuntu-instance.public_ip
}

# Create the inventory file
resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOF
      # Create the inventory file and add hosts
      echo "[app_servers]" > /home/elshwaihi/Desktop/Ansible/fn_proj/DEPI_DevOps_Final_Project/inventory.ini
      echo "ec2-instance ansible_host=${aws_instance.ubuntu-instance.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/elshwaihi/Desktop/Ansible/fn_proj/DEPI_DevOps_Final_Project/terraform/mykey.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> /home/elshwaihi/Desktop/Ansible/fn_proj/DEPI_DevOps_Final_Project/inventory.ini
    EOF
  }
}