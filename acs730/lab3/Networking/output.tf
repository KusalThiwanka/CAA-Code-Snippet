# Output the Availability Zone Name
output "availability_zone" {
  value = data.aws_availability_zones.available.names[0]
}

# Output the Subnet ID
output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "vpc_id" {
  value = aws_default_vpc.default_vpc.id
}