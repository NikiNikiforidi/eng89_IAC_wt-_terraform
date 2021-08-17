# let's create variable fo rour resources in mian.tf to make use of DRY


variable "cidr_block_0" {
  default="10.201.0.0/16"
}


variable "cidr_block_1" {
  default="10.201.1.0/24"
}


variable "cidr_block_2" {
  default="10.201.2.0/24"
}


variable "vpc_name" {
  default = "eng89_niki_terra_vpc"
}



variable "pub_subnet_name" {
  default = "eng89_niki_terra_subnet_public"
}


variable "vpc_id" {

  default = "vpc-07e47e9d90d2076da"
}



variable "igw_name" {
  default = "eng89_niki_terra_IG"
}



variable "app_ami_id" {
  default="ami-0fb3f32d6df7dac18" # ansible app ami
}


# Let's creatge a variable to apply DRY

variable "name" {
  default="eng89_niki_terra_app"
}



variable "aws_key_name" {
  default = "eng89_niki"
}

variable "aws_key_path" {

  default = "~/.ssh/eng89_niki.pem"
}
