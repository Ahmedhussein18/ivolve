output "nginx_public_ips" {
  description = "List of public IPs for Nginx instances"
  value       = aws_instance.nginx[*].public_ip
}

output "httpd_private_ip" {
  description = "List of Httpd instance IDs"
  value       = aws_instance.httpd[*].private_ip
}

