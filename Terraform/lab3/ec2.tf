resource "aws_instance" "instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  lifecycle {
    create_before_destroy = true
  }
  
  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allow SSH access from anywhere"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from all IPv4 addresses
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "Allow-SSH-Anywhere"
  }
}
