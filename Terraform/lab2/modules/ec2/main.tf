resource "aws_instance" "nginx" {
  count         = length(var.public_subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     =var.public_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data = <<-EOF
      #!/bin/bash
      sudo apt update -y
      sudo apt install nginx -y
      sudo systemctl start nginx
      sudo systemctl enable nginx
      EOF

  tags = {
    Name = "${var.project_name}-nginx-${count.index + 1}"
  }
}

resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  vpc_id = var.vpc_id
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

