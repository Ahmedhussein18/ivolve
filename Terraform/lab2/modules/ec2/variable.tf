variable "ami" {
  description = "AMI ID for the EC2 instance"
  default = "ami-005fc0f236362e99f"
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


variable "vpc_id" {
  description = "VPC ID where the instance will be launched"
  type        = string
}

variable "project_name" {
  type =string
}
