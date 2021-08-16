# IAC with Terraform

- HashiCorp Terraform is an open source infrastructure as code (IaC) software tool that allows DevOps engineers to programmatically provision the physical resources an application requires to run.

![terraform-config-files-e1605834689106](https://user-images.githubusercontent.com/86292184/129336954-05c411de-0a36-4b5a-96a4-519608e01ddb.png)

<br> </br>
https://learn.hashicorp.com/tutorials/terraform/install-cli
<br></br>

![terraform](https://user-images.githubusercontent.com/86292184/129584732-5d18433f-8b3e-4f35-a50b-6c1e8503f7cf.png)
![vpc config](https://user-images.githubusercontent.com/86292184/129584862-b1992db8-c758-41f1-b253-f741cc33d4cb.PNG)

- -----------------------------------
### Install Terraform
- Install apppropriate package
	- Copy/ paste out of zip file
- Create Environment variable
	- Right click windowns icon -> system
	- Advanced system setings -> 
	- Verify installation -> environment variables
	- Under System variables -> PATH -> Edit
	- Add path where terraform.exe is located 
	- Save changes, close and re-open terminal so changes are updated
- In command prompt, run  `terraform --version` to check if installation is correct
<br> </br>
- ------------------------------------------------------------
### Create environment variable
- Right click windows icon
- systems -> scroll down ->Advanced system settings -> Environment Variables
- Under ** User variable for YOUR_NAME** -> New
	- Variable name: AWS_ACCESS_KEY_ID
	- Variable value: 
	<br> </br>
	- Variable name: AWS_SECRET_ACCESS_KEY
	- Variable value:
- Re-open terminal 
<br> </br>

- --------------------------------------------------
### Create main.tf file, initialise and run
- create a new key pair in your ssh folder ` ssh-keygen -t rsa -b 2048 -v -f eng89_your_name`
- Go to aws -> ec2 -> key pairs -> Create key pair -> .pem -> create
- Put new .pem file in .ssh folder
<br> </br>

- Check out `main.tf` file to see the code required to create an instance
- `terraform init` # Initialise terraform
- `terraform plan` # To check if everything workds, no syntax errors
- `terraform apply` # Basically runs the main.tf file

<br> </br>
- ----------------------------------------------------------
