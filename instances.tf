resource "aws_instance" "web" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.web_sg_id]

  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
  sudo yum install -y httpd mariadb-server
  sudo systemctl start httpd
  sudo systemctl enable httpd
  sudo usermod -a -G apache ec2-user
  sudo chown -R ec2-user:apache /var/www
  sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
  find /var/www -type f -exec sudo chmod 0664 {} \;
  sudo yum install php-mbstring php-xml -y
  sudo systemctl restart httpd
  sudo systemctl restart php-fpm
  cd /var/www/html
  wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
  mkdir phpMyAdmin && tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1
  rm phpMyAdmin-latest-all-languages.tar.gz
  EOF

  tags = {
    Name = "WebInstance"
  }
}

resource "aws_instance" "db" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.db_sg_id]

  tags = {
    Name = "DBInstance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y postgresql postgresql-contrib",
      "sudo -u postgres psql -c \"CREATE USER myuser WITH PASSWORD 'mypassword';\"",
      "sudo -u postgres psql -c \"CREATE DATABASE mydb;\"",
      "sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;\""
    ]
  }
}

output "web_instance_id" {
  value = aws_instance.web.id
}

output "db_instance_id" {
  value = aws_instance.db.id
}
