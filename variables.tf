variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "private_subnet_az" {
  description = "Availability zone for the private subnet"
  type        = string
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "private_subnet_az_2" {
  description = "Availability zone for the second private subnet"
  type        = string
}



variable "ec2_ami" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for EC2"
  type        = string
}


variable "db_engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
}

variable "db_version" {
  description = "Database version (e.g., 5.7, 9.6)"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class for RDS (e.g., db.t3.micro)"
  type        = string
}

variable "db_hostname" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Username for RDS"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for RDS"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS (in GB)"
  type        = number
}


variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "public_subnet_az" {
  description = "Availability zone for the public subnet"
  type        = string
}


variable "region" {
  type        = string
  description = "AWS region"
  sensitive   = false
}

variable "access_key" {
  type        = string
  description = "AWS access key"
  sensitive   = true
}

variable "secret_key" {
  type        = string
  description = "AWS secret key"
  sensitive   = true
}

variable "Hashicorp_workspace" {
  type        = string
  description = "Terraform workspace for backend"
  sensitive   = false

}

variable "Hashicorp_organization" {
  type        = string
  description = "Terraform organization"
  sensitive   = false

}