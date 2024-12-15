variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "ivolve"
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default = "ami-005fc0f236362e99f"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "instance_type" {
  description = "Instance type for both Nginx and Httpd instances"
  type        = string
  default     = "t2.micro"
}
