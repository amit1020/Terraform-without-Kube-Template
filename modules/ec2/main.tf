


# Generate a new SSH key pair
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create an AWS key pair using the generated public key
resource "aws_key_pair" "key_pair" {
  key_name   = "instance-test-key"
  public_key = tls_private_key.example.public_key_openssh
}


resource "aws_eip" "ec2_eip" {
  instance = aws_instance.web.id
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id  # ✅ Input from network module
  vpc_security_group_ids = [var.security_group_id]  # ✅ Input from network module
  key_name      = aws_key_pair.key_pair.key_name
  associate_public_ip_address = true  # ✅ Ensure instance gets a public IP
  user_data = file("${path.root}/scripts/user_data.sh")


            

  tags = {
    Name = "web-instance"
  }
}
