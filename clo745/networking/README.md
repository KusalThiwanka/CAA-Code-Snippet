# VPC and Public Subnet and Private Subnet

## Instructions
1. Create a New VPC (VPC1)
2. Create a New Internet Gateway (VPC1-IGW)
3. Attach that IGW to VPC (VPC1-IGW attached to VPC1)
4. Create a Public Subnet and Private Subnet (VPC1-PublicSubnet1 and VPC1-PrivateSubnet1)
5. Create a Route Table for Public Subnet (VPC1-Public-RT)
6. Add Route to the Internet from inside that created Route Table (VPC1-Public-RT)
~ Destination:0.0.0.0/0 and Target:VPC1-IGW
7. Associate the Route Table (VPC1-Public-RT) to our Public Subnet (VPC1-PublicSubnet1)
~ Go to VPC1-Public-RT -> Subnet Association -> Edit Subnet Assiciations -> Add VPC1-PublicSubnet1
8. Create a Route Table for Private Subnet (VPC1-Private-RT)
9. Associate the Route Table (VPC1-Private-RT) to our Private Subnet (VPC1-PrivateSubnet1)
~ Go to VPC1-Private-RT -> Subnet Association -> Edit Subnet Assiciations -> Add VPC1-PrivateSubnet1


# VPC Peering


# Transit Gateway
