output "public_lb_dns_name" {
  description = "DNS name of the public load balancer"
  value       = aws_lb.public_lb.dns_name
}

output "internal_lb_dns_name" {
  description = "DNS name of the internal load balancer"
  value       = aws_lb.internal_lb.dns_name
}
