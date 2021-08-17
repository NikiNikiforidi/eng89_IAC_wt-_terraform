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




# Create a VPC  
resource "aws_vpc" "terraform_vpc_code_test" {
  cidr_block       = var.cidr_block_0 
  instance_tenancy = "default"
  
  tags = {
    Name = var.vpc_name
  }
} 



# Create Internet Gateway
resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc_code_test.id
  
  tags = {
    Name = var.igw_name
  }
}





# DIORTHOSI PUBLIC SUBNET
resource "aws_subnet" "terraform_subnet_public" {
    vpc_id = aws_vpc.terraform_vpc_code_test.id
    cidr_block = var.cidr_block_1
    map_public_ip_on_launch = "true" 
    availability_zone = "eu-west-1a"
    tags = {
        Name = var.pub_subnet_name
    }
}








# Create Custom Route Table


# Launch an instance
resource "aws_instance" "app_instance" {
ami                         = var.app_ami_id
instance_type               = "t2.micro"
associate_public_ip_address = true

tags = {
      Name = var.name      

 }
 key_name = var.aws_key_name # goes to varaible.tf file

}



# ---------------------------------------------------------
# most commonly used commands for terraform
# terraform plan checks the syntax and validates the installations we have provided in this script


# once we are happy and the outcome is green we can run terraform apply