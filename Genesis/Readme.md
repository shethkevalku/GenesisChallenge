**Project Overview**
This project aims to create EC2 instances, ELB, RDS, and Route53 resources using Terraform. The Terraform configuration is organized into modules for code reuse and readability.

**Modules**
The project consists of the following modules:

ec2: Creates EC2 instances.
elb: Creates ELB and target groups.
route53: Creates a private hosted zone and associates it with a VPC.
vpc: Creates a VPC, subnets, security group, and route table.
rds: Creates an RDS instance.
tf-state: Configures S3 and DynamoDB to store Terraform state files.
Environment Configuration
To support different environments, tfvars files have been created. The provided example only includes a few parameters in the tfvars file, with the rest supplied directly when calling the modules. You can modify this structure based on your requirements.

Make sure to add the appropriate entries to the .gitignore file to ignore tf-state files and avoid accidentally pushing sensitive information in tfvars files to public repositories.

**Build Attributes**
The following attributes are exported by the build process:

EC2 Instance ID
EC2 Private IP
Load Balancer DNS name
RDS Endpoint
RDS Database Name
RDS Port
RDS Master username


**Running the Project**
To run the project in your AWS account, follow these steps:

Clone the repository.
Comment out all the lines in the modules, leaving only the module calls if there is a need to store the tfstate remotely.
Uncomment the backend configuration in the main.tf file.
Modify the production.tfvars file as required.
Run the following commands:
terraform init
terraform validate
terraform plan --var-file production.tfvars
terraform apply --var-file production.tfvars


**Prerequisites**
Make sure you have proper AWS credentials and access to the required resources.




