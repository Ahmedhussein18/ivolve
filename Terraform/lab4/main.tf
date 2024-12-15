resource "aws_vpc" "main" {

}
module "vpc" {
  source              = "./modules/vpc"
  vpc_id = aws_vpc.main.id
  project_name        = var.project_name
  vpc_cidr            = aws_vpc.main.cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones  = var.availability_zones
}

module "instances" {
  source             = "./modules/instances"
  ami= var.ami_id
  project_name       = var.project_name
  vpc_id             = aws_vpc.main.id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type      = var.instance_type
  nginx_sg = [module.vpc.nginx_sg]
  httpd_sg = [module.vpc.httpd_sg]  
  depends_on = [module.vpc]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "nginx_ip" {
  value = module.instances.nginx_public_ips
}

output "httpd_private_ip" {
  value = module.instances.httpd_private_ip
}