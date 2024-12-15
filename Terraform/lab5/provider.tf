terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "marzouk-nti-terraform-project"
    key            = "terraform.tfstate" 
    region         = "us-east-1"              
    dynamodb_table = "ivolve-marzouk-tf-lock-table"  
  }
} 

provider "aws" {
  region = "us-east-1"
}