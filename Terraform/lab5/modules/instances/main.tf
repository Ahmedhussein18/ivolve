resource "aws_instance" "nginx" {
  count         = 2
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     =var.public_subnet_ids[count.index]
  security_groups = var.nginx_sg
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install -y nginx1
              cat > /etc/nginx/conf.d/default.conf << 'NGINX_CONFIG'
              server {
                  listen 80;
                  server_name _;
                  
                  location / {
                      proxy_pass http://${var.internal_lb_dns_name};
                      proxy_set_header Host $host;
                      proxy_set_header X-Real-IP $remote_addr;
                      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                      proxy_set_header X-Forwarded-Proto $scheme;
                  }
              }
              NGINX_CONFIG
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "${var.project_name}-nginx-${count.index + 1}"
  }
}

resource "aws_instance" "httpd" {
  count         = 2
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[count.index]
  security_groups = var.httpd_sg
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Server ${count.index + 1}</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-httpd-${count.index + 1}"
  }
}


