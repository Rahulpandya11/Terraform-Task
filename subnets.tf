resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-west-2a"

  tags = {
    Name = "private_subnet"
  }
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}
