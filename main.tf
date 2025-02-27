module "network" {
  source                = "./modules/network"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  public_subnet_az      = var.public_subnet_az
  private_subnet_cidr   = var.private_subnet_cidr
  private_subnet_az     = var.private_subnet_az
  private_subnet_cidr_2 = var.private_subnet_cidr_2
  private_subnet_az_2   = var.private_subnet_az_2

}

module "ec2" {
  source = "./modules/ec2"

  ami               = var.ec2_ami
  instance_type     = var.ec2_instance_type
  subnet_id         = module.network.public_subnet_id      # Using network module output
  security_group_id = module.network.ec2_security_group_id # Using network module output
}

module "rds" {
  source               = "./modules/rds"
  db_identifier        = var.db_hostname
  db_engine            = var.db_engine
  db_engine_version    = var.db_version
  db_instance_class    = "db.t4g.micro"
  db_allocated_storage = 20
  db_storage_type      = "gp2"
  db_username          = var.db_username
  db_password          = var.db_password
  db_subnet_group_name = "phishing-scan-db-subnet-group"

  subnet_ids        = [module.network.private_subnet_id, module.network.private_subnet_id_2] # Use both subnets
  security_group_id = module.network.rds_security_group_id                                   # Use security group from network module

  skip_final_snapshot = true
}
