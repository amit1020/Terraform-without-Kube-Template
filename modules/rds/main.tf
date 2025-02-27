resource "aws_db_instance" "my_rds" {
  identifier            = var.db_identifier
  engine                = var.db_engine
  engine_version        = var.db_engine_version
  instance_class        = var.db_instance_class
  allocated_storage     = var.db_allocated_storage
  storage_type          = var.db_storage_type
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name  = aws_db_subnet_group.my_subnet_group.name
  vpc_security_group_ids = [var.security_group_id]  # ✅ Using security group from network module
  publicly_accessible  = false  # ✅ Keep private for security
  skip_final_snapshot  = var.skip_final_snapshot  # ✅ Configurable for production
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids  # ✅ Using private subnets from network module

  tags = {
    Name = "phishing-scan-db-subnet-group"
  }
}
