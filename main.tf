#Provider resource details:
provider "aws" {
  region     = var.reg
  access_key = var.ak
  secret_key = var.sk
}

#Creating the Vpc:
resource "aws_vpc" "project1vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "project1vpc"
  }
}
#Creating the internet gateway:
resource "aws_internet_gateway" "project1_igw" {
  vpc_id = aws_vpc.project1vpc.id

  tags = {
    Name = "project1_igw"
  }
}
#creating the subnet1:
resource "aws_subnet" "project1_subnet" {
  vpc_id     = aws_vpc.project1vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "project1_subnet"
  }
}
#creating the route table:
resource "aws_route_table" "project1_route_table" {
  vpc_id = aws_vpc.project1vpc.id
  tags = {
    Name = "project1_route_table"
  }
}
#associating route internet gateway in route table:
resource "aws_route" "project1_routing" {
  route_table_id         = aws_route_table.project1_route_table.id
  destination_cidr_block = "0.0.0.0/0" # Route all traffic to the Internet Gateway
  gateway_id             = aws_internet_gateway.project1_igw.id
}
#creating the subnet association with the route table:
resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.project1_subnet.id
  route_table_id = aws_route_table.project1_route_table.id
}
#creating the security group:
resource "aws_security_group" "project1_sc" {
  name        = "project1_sc"
  description = "security group for AWS EC2 instances"
  vpc_id      = aws_vpc.project1vpc.id
  # Ingress rules (inbound traffic)
  # Allow SSH (port 22) from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP (port 80) from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow HTTPS (port 443) from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow CUSTOM TCP (port 8080) from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Egress rules (outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project1_sc"
  }
}
#creating the instance:
resource "aws_instance" "server" {
  count                  = "4"
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.project1_subnet.id
  key_name               = var.keypair
  vpc_security_group_ids = [aws_security_group.project1_sc.id]
  associate_public_ip_address = true
  tags = {
    Name = "Server - ${count.index}"
  }
}
