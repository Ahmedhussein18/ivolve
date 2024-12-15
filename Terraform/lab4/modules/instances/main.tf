resource "aws_instance" "nginx" {
  count         = 1
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     =var.public_subnet_ids[count.index]
  security_groups = var.nginx_sg
  key_name = var.key_name
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("D://Terraform/lab4/modules/instances/marzouk-key.pem")
    host        = self.public_ip
  }
  tags = {
    Name = "${var.project_name}-nginx-${count.index + 1}"
  }
}

resource "aws_instance" "httpd" {
  count         = 1
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[count.index]
  security_groups = var.httpd_sg
  key_name = var.key_name
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
  EOF
  tags = {
    Name = "${var.project_name}-httpd-${count.index + 1}"
  }
}


