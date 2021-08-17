

#  PRIVATE SUBNET
resource "aws_subnet" "db_subnet" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = var.cidr_block_2
    # map_public_ip_on_launch = "true" 
    availability_zone = "eu-west-1a"
    tags = {
        Name = "eng89_niki_terra_subnet_private"
    }
}


# SECURITY GROUPS
resource "aws_security_group" "pri_sec_group" {
      
  name        = "eng89_niki_terra_db"
  description = "db security group"
  vpc_id =    aws_vpc.terraform_vpc.id


  ingress {                         # allow to ssh into instance
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks = ["5.203.234.162/32"] # MY IP
    cidr_blocks = ["0.0.0.0/0"]
    }

 # ingress {                           # allow  for nginx
 #   from_port   = "27017"
 #   to_port     = "27017"
 #   protocol    = "tcp"
 #   cidr_blocks = ["54.194.12.76/32"]  # public instance app ip
 #   }



  egress {                          # allow all outbound traffic 
    from_port  = 0
    to_port    = 0
    protocol   = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
   Name = "eng89_niki_terra_private_SG"
  }
}


# NETWORK ACLs
#resource "aws_network_acl" "private_nacl" {
#  vpc_id = aws_vpc.terraform_vpc.id



#  ingress {
#      protocol   = "tcp"
#      rule_no    = 120
#      action     = "allow"
#      cidr_block = "5.203.234.162/32" # MY IP
#      from_port  = 22
#      to_port    = 22
#    }
  
#  ingress {
#      protocol   = "tcp"
#      rule_no    = 120
#      action     = "allow"
#      cidr_block = "10.201.2.0/24"
#      from_port  = 27017
#      to_port    = 27017
#    }



#  egress {
#      protocol   = "tcp"
#      rule_no    = 100
#      action     = "allow"
#      cidr_block = "0.0.0.0/0"
#      from_port  = 80
#      to_port    = 80
#    }



#  tags = {
#    Name = "eng89_terra_niki_nACL_pri"
#  }
#}


# INSTANCE
resource "aws_instance" "db_instance" {
ami                         = "ami-077ab28a9abbcf213"
instance_type               = "t2.micro"

subnet_id = aws_subnet.app_subnet.id # PUBLIC SUBNET
associate_public_ip_address = false


vpc_security_group_ids = ["${aws_security_group.pri_sec_group.id}"]


tags = {
      Name = "eng89_niki_terra_db"   
 }

 key_name = var.aws_key_name # goes to varaible.tf file
}