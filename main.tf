# Let's build a script to connect to AWS and download/setup all dependencies required 

# Keyword: provider aws

# then will move into launch aws services
# Let's launch an ec2 instance in eu-west-1 with ami-038d7b856fe7557b3

# keyword called "resource" provide resource name and give name with specific details to the service

# recourse aws_ec2_instance, name it as eng89_niki_terraform, ami, type of instanc, with or without ip, tags is the keyword to name the instance eng89_niki_terraform

# STEPS:
# provide valid ami id, this is default ubuntu
# type of instance
# we would like public ip for this instance
# provide name to this instance using tags
# ssh into instancwe
# provide name to this instance using tags


# -----------------------------------------------------------

# Provide a region
 provider "aws" {
        region = "eu-west-1"
}




# VPC 
resource "aws_vpc" "terraform_vpc" {
  cidr_block       = var.cidr_block_0 
  instance_tenancy = "default"
  # enable_dns_support = true
  # enable_dns_hostnames = true
  
  tags = {
    Name = var.vpc_name
  }
} 



# INTERNET GATEWAY
resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  
  tags = {
    Name = var.igw_name
  }
}





#  PUBLIC SUBNET
resource "aws_subnet" "app_subnet" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = var.cidr_block_1
    map_public_ip_on_launch = "true" 
    availability_zone = "eu-west-1a"
    tags = {
        Name = var.pub_subnet_name
    }
}





# ROUTE TABLE

resource "aws_route_table" "terra_route_table" {
    vpc_id = aws_vpc.terraform_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform_igw.id
    }
    tags = {
        Name = "eng89_niki_terra_RT"
    }
}

resource "aws_route_table_association" "terra_assoc_RT" {
    subnet_id = aws_subnet.app_subnet.id
    route_table_id = aws_route_table.terra_route_table.id
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



# NETWORK ACLs
resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.terraform_vpc.id

  
  ingress {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    }



  ingress {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "5.203.234.162/32" # MY IP
      from_port  = 22
      to_port    = 22
    }

  egress {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    }

  egress {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "10.201.2.0/24"
      from_port  = 27017
      to_port    = 27017
    }



  tags = {
    Name = "eng89_terra_niki_nACL_pub"
  }
}



# INSTANCE
resource "aws_instance" "app_instance" {
ami                         = var.app_ami_id
instance_type               = "t2.micro"

subnet_id = aws_subnet.app_subnet.id
associate_public_ip_address = true


vpc_security_group_ids = ["${aws_security_group.pub_sec_group.id}"]


tags = {
      Name = var.name   
 }

 key_name = var.aws_key_name # goes to varaible.tf file


# connection {
#  type        = "ssh"
#  user        = "ubuntu"
#  private_key = file("${var.aws_key_path}")
#  host        = self.associate_public_ip_address
# }

}



# ---------------------------------------------------------
# most commonly used commands for terraform
# terraform plan checks the syntax and validates the installations we have provided in this script


# once we are happy and the outcome is green we can run terraform apply