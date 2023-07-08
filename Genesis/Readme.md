Genesis Challenge 

**Details:**
The project comprises of creating EC2, ELB , RDS and Route53 resources via terraform. 

**Approach towads creating tf files:**
Modules have been used in order to reuse the code and for rrading purposes.

**Modules are as follows:**
ec2 -- Creates number of EC2 instances
elb -- CReated ELB, Target group etc 
route53 -- Creates Private Hosted Zone and associates it with VPC 
vpc - Created VPC, Subnets, Security Group, Route Table etc 
rds -- Creates RDS 
tf-state -- Created S3 and Dynamodb table to store state files

In order to make use of same code in different environmnet , tfvars file have been created. 
To show an example only few parameters have been added in tfvars file and rest have been directly supplied when modules are being called. But this can be changed based on 
requirements.

.gitignore files have been asked to ignore tf-state files but of you are supplying some sensitive information in tfvars file, they should be added to 
ignore being pushed to public repo.

**Ask:**

1. Assume that terraform validate & plan will be run on the HCL. Done !
2. Assume that different AWS accounts will be used for different environments (DEV, QA, STAGING, PROD) and that the same Terraform file should be capable of being used across these environments.
3. Proper module use is recommended. **Use tfvars file for different environments**
4. We should be able to build out N number of EC2 instances, if required. **Yes**
5. The build should export the following attributes:
          a. EC2 Instance ID -- Done
          b. EC2 Private IP -- Done 
          c. Load Balancer DNS name -- Done 
          d. RDS Endpoint -- Done
          e. RDS Database Name --Done
          f. RDS Port -- Done
          g. RDS Master username -- Done 


**To run the project in your aws_account :**

a) Clone the repository 
b) Comment all the lines in modules and just try to call module tf-state files provided there is a need to store tfstate remotely.
c) Uncomment the backend configuration in main.tf file .
d) Use/apply modification to production.tfvars file as required 
e) Run the following commands :
terraform init 
terraform validate 
terraform plan --var-file production.tfvars
terraform apply --var-file production.tfvars


**Prerequisites:**
AWS credentials access 
