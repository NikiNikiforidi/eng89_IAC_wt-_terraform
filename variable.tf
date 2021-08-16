# let's create variable fo rour resources in mian.tf to make use of DRY
variable "aws_key_name" {
	default = "eng89_niki"

}
variable "aws_key_path" {

	default = "~/.ssh" 
	# "~/.ssh/eng89_devops.pem"

}