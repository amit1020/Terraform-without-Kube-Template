variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for EC2"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where EC2 will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for EC2"
  type        = string
}
