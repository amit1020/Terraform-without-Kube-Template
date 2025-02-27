# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "phishing-scan-platform-vpc"
  }
}

# Create Public Subnet - EC2 Instances
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.public_subnet_az

  tags = {
    Name = "phishing-scan-platform-public-subnet"
  }
}

# Create Private Subnet (For RDS)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az

  tags = {
    Name = "phishing-scan-platform-private-subnet"
  }
}

#Create Additional Private Subnet (For Multi-AZ RDS) -The RDS service demand two subnets in different availability zones for Multi-AZ deployments.
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = var.private_subnet_az_2

  tags = {
    Name = "phishing-scan-platform-private-subnet-2"
  }
}

#elastic IP to the ec2 
resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id  # NAT must be in public subnet
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}





# Internet Gateway (For public traffic)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "phishing-scan-platform-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id # Attach this route table to the VPC

  route {
    cidr_block = "0.0.0.0/0" # This means "allow traffic to any IP" - !!!need to change 
    gateway_id = aws_internet_gateway.gw.id # Direct traffic to the Internet Gateway
  }

  tags = {
    Name = "phishing-scan-platform-public-route-table"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}



#?----------------------------------------------------- Create Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "ec2-security-group"

  ingress {
    from_port   = 22  # SSH Access
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your IP for security
  }

    ingress {
    from_port   = 1234  
    to_port     = 1234
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your IP for security
  }

  ingress {
    from_port   = 80  # HTTP Access
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
  ingress {
    from_port   = 443  # HTTPS Access
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phishing-scan-platform-ec2-sg"
  }
}



#?-------------------------------------------- Create Security Group for RDS
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "rds-security-group"

  ingress {
    from_port   = 3306  # MySQL (Change to 5432 for PostgreSQL)
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]  # Only allow internal access
  }
   ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]  # Allow access from EC2
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phishing-scan-platform-rds-sg"
  }
}

# Create DB Subnet Group (Needed for RDS)
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "phishing-scan-platform-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.private_subnet_2.id]  # Use both private subnets

  tags = {
    Name = "phishing-scan-platform-db-subnet-group"
  }
}
