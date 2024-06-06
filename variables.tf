variable "region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-0e001c9271cf7f3b9" 
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "allowed_ip" {
  description = "The IP address allowed to SSH into the bastion host"
  default     = "YOUR_IP/32"  # Replace YOUR_IP with your IP address
}
