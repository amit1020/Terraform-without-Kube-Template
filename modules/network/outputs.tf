output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "Primary Private subnet ID for RDS"
  value       = aws_subnet.private_subnet.id
}

output "private_subnet_id_2" {
  description = "Secondary Private subnet ID for RDS (Multi-AZ)"
  value       = aws_subnet.private_subnet_2.id
}

output "ec2_security_group_id" {
  description = "Security Group ID for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}

output "rds_security_group_id" {
  description = "Security Group ID for RDS"
  value       = aws_security_group.rds_sg.id
}
