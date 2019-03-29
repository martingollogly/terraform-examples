# Nginx
resource "aws_instance" "instance" {
  ami           = "ami-cdbfa4ab"
  instance_type = "t2.small"
  vpc_security_group_ids      = [ "${aws_security_group.security-group.id}" ]
  subnet_id                   = "${var.subnet-id}"
  associate_public_ip_address = true
  user_data                   = <<EOF
#!/bin/sh
yum install -y nginx
service nginx start
EOF
}

resource "aws_security_group" "security-group" {
  vpc_id      = "${var.vpc-id}"

  ingress = [
    {
      from_port = "80"
      to_port   = "80"
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = "443"
      to_port   = "443"
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = "22"
      to_port   = "22"
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "nginx_domain" {
  value = "${aws_instance.instance.public_dns}"
}
