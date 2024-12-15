data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones  = var.availability_zones
}

module "instances" {
  source             = "./modules/instances"
  ami=data.aws_ami.amazon_linux.id
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type      = var.instance_type
  nginx_sg = [module.vpc.nginx_sg]
  httpd_sg = [module.vpc.httpd_sg]  
  internal_lb_dns_name = module.loadbalancers.internal_lb_dns_name
  depends_on = [ module.vpc ]
}

module "loadbalancers" {
  source             = "./modules/loadbalancers"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  nginx_instance_ids = module.instances.nginx_instance_ids
  httpd_instance_ids = module.instances.httpd_instance_ids
  public_lb_sg = [module.vpc.public_lb_sg]
  internal_lb_sg = [module.vpc.internal_lb_sg]
depends_on = [ module.vpc ]
  }


  output "public_lb_dns_name" {
    value = module.loadbalancers.public_lb_dns_name
  }