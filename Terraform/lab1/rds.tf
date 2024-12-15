resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version = "8.0.32"
  instance_class       = "db.t3.micro"
  username             = "admin"
  db_name = "my_db"
  password             = "password123"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot = true
}

resource "aws_security_group" "rds_sg" {
  vpc_id = data.aws_vpc.ivolve.id

  ingress {
    from_port   = 3306
    to_port     = 3306
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

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}