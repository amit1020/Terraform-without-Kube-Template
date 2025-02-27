variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR Block"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR Block"
  type        = string
}

variable "public_subnet_az" {
  description = "Availability Zone for Public Subnet"
  type        = string
}

variable "private_subnet_az" {
  description = "Availability Zone for Private Subnet"
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
