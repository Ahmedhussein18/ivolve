variable "vpc_id" {
  description = "VPC ID where the load balancers will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the public load balancer"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the internal load balancer"
  type        = list(string)
}

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "nginx_instance_ids"{
  description = "ids of nginx instances"
  type = list(string)
}


variable "httpd_instance_ids"{
  description = "ids of httpd instances"
  type = list(string)
}

variable "public_lb_sg"{
  type = list(string)
}

variable "internal_lb_sg"{
  type = list(string)
}