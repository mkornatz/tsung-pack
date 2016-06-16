provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}

#########################
# Instances
#   Reference, https://www.terraform.io/docs/providers/aws/r/instance.html
#########################
resource "aws_instance" "app" {
  depends_on = ["aws_security_group.instance"]

  count = "${var.instance_count}"
  ami = "${lookup(var.images, var.region)}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  key_name = "${var.ssh_keypair_name}"

  root_block_device = {
    volume_size = 8
    delete_on_termination = true
  }

  tags = {
    Name = "${var.app_name}"
  }
}

#########################
# Security Group
#   Reference, https://www.terraform.io/docs/providers/aws/r/instance.html
#########################
resource "aws_security_group" "instance" {
  name = "instances-${var.app_name}"
  description = "Allows all inbound traffic on 22 and 8091"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8091
    to_port = 8091
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all communication within the security group
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  tags {
    Name = "Instances for ${var.app_name}"
  }
}
