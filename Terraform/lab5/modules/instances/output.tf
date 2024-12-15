output "nginx_instance_ids" {
  description = "List of Nginx instance IDs"
  value       = aws_instance.nginx[*].id
}

output "nginx_public_ips" {
  description = "List of public IPs for Nginx instances"
  value       = aws_instance.nginx[*].public_ip
}

output "httpd_instance_ids" {
  description = "List of Httpd instance IDs"
  value       = aws_instance.httpd[*].id
}

