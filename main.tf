# Let's build a script to connect to AWS and download/setup all dependencies required 



# Setting up the SSH keys
#resource "aws_key_pair" "deployer" {
#  key_name = "eng89_devops"

#  public_key = file("~/.ssh/eng89_devops.pem")
#}





# Keyword: provider aws
 provider "aws" {

        region = "eu-west-1"

}


# then we will run: terraform init

# then will move into launch aws services
# Let's launch an ec2 instance in eu-west-1 with ami-038d7b856fe7557b3

# keyword called "resource" provide resource name and give name with specific details to the service


# recourse aws_ec2_instance, name it as eng89_niki_terraform, ami, type of instanc, with or without ip, tags is the keyword to name the instance eng89_niki_terraform


resource "aws_instance" "app_instance" {



# provide valid ami id, this is default ubuntu
ami = "ami-038d7b856fe7557b3"



# type of instance
instance_type = "t2.micro"


# we would like public ip for this instance
associate_public_ip_address = true


# provide name to this instance using tags
tags = {
      Name = "eng89_niki_terraform_app"       

 }

key_name = "eng89_devops"
}



# most commonly used commands for terraform
# terraform plan checks the syntax and validates the installations we have provided in this script


# once we are happy and the outcome is green we can run terraform apply