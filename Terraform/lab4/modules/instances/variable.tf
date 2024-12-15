variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "key_name" {
  default = "marzouk-key"
}

variable "instance_type" {
  description = "Type of instance to launch"
  default = "t2.micro"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public Subnet IDs where the instance will be launched"
  type        =list(string)
}


variable "private_subnet_ids" {
  description = "Private Subnet IDs where the instance will be launched"
  type        =list(string)
}

variable "vpc_id" {
  description = "VPC ID where the instance will be launched"
  type        = string
}

variable "project_name" {
  type =string
}

variable "nginx_sg" {
  type=list(string)
}

variable "httpd_sg" {
  type=list(string)
}
