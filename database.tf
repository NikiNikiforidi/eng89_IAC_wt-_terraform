# Provide a region
 provider "aws" {
        region = "eu-west-1"
}


#  PRIVATE SUBNET
resource "aws_subnet" "db_subnet" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = var.cidr_block_2
    # map_public_ip_on_launch = "true" 
    availability_zone = "eu-west-1a"
    tags = {
        Name = var.pub_subnet_name
    }
}


# SECURITY GROUPS
resource "aws_security_group" "pub_sec_group" {
      
  name        = "eng89_niki_terra_app"
  description = "app security group"
  vpc_id =    aws_vpc.terraform_vpc.id


  ingress {                         # allow to ssh into instance
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["5.203.234.162/32"] # MY IP
    }

  ingress {                           # allow  for nginx
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }



  ingress {                         # reverse proxy
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

  egress {                          # allow all outbound traffic 
    from_port  = 0
    to_port    = 0
    protocol   = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
   Name = "eng89_niki_terra_public_SG"
  }
}