variable "vpc_cidr_block"{
    description= "vpc cidr block"
}


variable "subnet_cidr_block"{
    description = "subnet cidr block"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
}

variable "key_name" {
  description = "Key pair name for the EC2 instance"
}

variable "name" {
  description = "name"
}

variable "metric_name" {
  description = "metric name"
}

variable "threshold" {
  description = "cpu threshold"
}

variable "gmail_address" {
  description = "email address for receiving alerts"

}



