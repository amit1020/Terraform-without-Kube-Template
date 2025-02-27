
#Output the public IP of the created EC2 instance
output "public_ip" {
  value = aws_instance.web.public_ip
}