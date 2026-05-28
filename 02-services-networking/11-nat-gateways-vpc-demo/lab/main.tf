# -------------------------------------------------------------------
# VPC
# -------------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "main-vpc" }
}

# -------------------------------------------------------------------
# Internet Gateway
# -------------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "igw-abc" }
}

# -------------------------------------------------------------------
# Subnets
# -------------------------------------------------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Auto-assign public IP: Enable

  tags = { Name = "public-subnet" }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false # Auto-assign public IP: Disable

  tags = { Name = "private-subnet" }
}

# -------------------------------------------------------------------
# Elastic IP + NAT Gateway  (for private subnet outbound traffic)
# -------------------------------------------------------------------
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "nat-eip" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id # NAT GW lives in the public subnet

  tags = { Name = "nat-abc" }

  depends_on = [aws_internet_gateway.igw]
}

# -------------------------------------------------------------------
# Route Tables
# -------------------------------------------------------------------

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id # igw-abc
  }

  tags = { Name = "public-route-table" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id # nat-abc
  }

  tags = { Name = "private-route-table" }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# -------------------------------------------------------------------
# Security Groups
# -------------------------------------------------------------------

# Public EC2 — inbound from internet ALLOWED, outbound to internet ALLOWED
resource "aws_security_group" "public_ec2" {
  name        = "public-ec2-sg"
  description = "Allow all inbound from internet and all outbound"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow all inbound (Internet to EC2)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound (EC2 to Internet)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "public-ec2-sg" }
}

# Private EC2 — inbound from internet BLOCKED, outbound ALLOWED (via NAT)
resource "aws_security_group" "private_ec2" {
  name        = "private-ec2-sg"
  description = "Block inbound from internet; allow outbound via NAT"
  vpc_id      = aws_vpc.main.id

  # No ingress rule -> inbound from internet is blocked by default

  egress {
    description = "Allow all outbound (EC2 to Internet via NAT)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "private-ec2-sg" }
}

# -------------------------------------------------------------------
# EC2 Instances
# -------------------------------------------------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "public_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public_ec2.id]

  tags = { Name = "public-ec2" }
}

resource "aws_instance" "private_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private_ec2.id]

  tags = { Name = "private-ec2" }
}

# -------------------------------------------------------------------
# Outputs
# -------------------------------------------------------------------
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "public_ec2_public_ip" {
  value = aws_instance.public_ec2.public_ip
}

output "private_ec2_private_ip" {
  value = aws_instance.private_ec2.private_ip
}
