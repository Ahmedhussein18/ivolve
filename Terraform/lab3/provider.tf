provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "ivolve-marzouk-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ivolve-marzouk-tf-lock-table"
    encrypt        = true 
  }
}
