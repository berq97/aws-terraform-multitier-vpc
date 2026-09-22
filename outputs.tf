output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_ip" {
  description = "Public IP of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}

output "flow_log_group_name" {
  description = "CloudWatch Log Group receiving VPC Flow Logs"
  value       = aws_cloudwatch_log_group.vpc_flow_logs.name
}

output "public_test_instance_ip" {
  description = "Public IP of the public test instance"
  value       = aws_instance.public_test.public_ip
}

output "private_test_instance_ip" {
  description = "Private IP of the private test instance"
  value       = aws_instance.private_test.private_ip
}