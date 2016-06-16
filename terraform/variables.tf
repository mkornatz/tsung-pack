variable "images" {
  type = "map"
  description = "Amazon Linux AMI 2016.03.2 (HVM), SSD Volume Type"
  default = {
    us-east-1 = "ami-a4827dc9"
    us-west-1 = "ami-11790371"
    us-west-2 = "ami-f303fb93"
  }
}

variable "availability_zones" {
  type = "map"
  description = "Availability zones to use"
  default = {
    us-east-1 = "us-east-1a,us-east-1c,us-east-1d,us-east-1e"
    us-west-1 = "us-west-1a,us-west-1b"
    us-west-2 = "us-west-2a,us-west-2b,us-west-2c"
  }
}

variable "region" {
  type = "string"
  description = "AWS Region"
  default = "us-east-1"
}

# 
# The following variables are required
# 
variable "app_name" {
  type = "string"
  description = "The name of this application"
}

variable "ssh_keypair_name" {
  type = "string"
  description = "Name of ssh keypair in AWS"
}

variable "aws_access_key" {
  type = "string"
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  type = "string"
  description = "AWS Secret Access Key"
}

variable "instance_type" {
  type = "string"
  description = "Instance type to be used for all instances"
}

variable "instance_count" {
  type = "string"
  description = "Number of instances to spin up"
}
