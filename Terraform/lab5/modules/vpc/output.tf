output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "igw_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.igw.id
}


output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "nginx_sg" {
  value=aws_security_group.nginx_sg.id
}

output "public_lb_sg"{

  value=aws_security_group.public_lb_sg.id
}

output "internal_lb_sg" {
  value = aws_security_group.internal_lb_sg.id
}

output "httpd_sg" {
  value = aws_security_group.httpd_sg.id
}