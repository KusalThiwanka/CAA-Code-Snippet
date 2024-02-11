# Output the list of subnet ids
output "subnets" {
  value = aws_subnet.public_subnet_lab2_4[*]
}