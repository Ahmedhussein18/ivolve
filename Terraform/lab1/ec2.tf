resource "aws_instance" "ec2" {
  ami           = "ami-0d561ce3ab0e0648c"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ec2-ip.txt"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh-anywhere"
  description = "Allow SSH access from anywhere"
  vpc_id      = data.aws_vpc.ivolve.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow-SSH-Anywhere"
  }
}