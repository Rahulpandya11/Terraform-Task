resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "main_vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}
