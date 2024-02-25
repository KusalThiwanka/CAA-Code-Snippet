## Goal
Our goal is to use the implement different deployments of our infrastructure into Test and Prov environments. We will use Terraform input parameters and conditions to create code that supports deployments in Prod and Test environments. 
Prod environment is more evolved and has the requirements below:
-	Root volume is encrypted in Prod only
-	Additional data volume is deployed in Prod only
-	EC2 instance type is t2.medium; all the other environments should be using t2.micro

## Steps
Create an S3 bucket to store the remote Terraform state and Update on both Networking and Webserver config.tf files to reference this bucket

Go to Networking File
```
terraform int
terraform validate
terraform plan
terraform apply –-auto-approve
```

Go to Webserver File
```
ssh-keygen -t rsa -f Lab3
terraform int
terraform validate
terraform plan –var env=test or terraform plan –var env=prod
terraform apply –var env=test or terraform apply –var env=prod
```