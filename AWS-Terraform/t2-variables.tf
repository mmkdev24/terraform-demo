# Input Variables

# AWS Region
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type = string
  default = "us-east-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC Instance Type"
  type = string
  default = "t2.micro"
}

# EC2 Instance Key Pair
variable "instance_keypair" {
  description = "Key Pair Associated with EC2 Instance"
  type = string
  default = "dev_vpc_key"
}

# EC2 Instance Type List
variable "instance_type_map" {
  description = "EC2 Instance Map"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "sit" = "t2.small"
    "it" = "t2.large"
  }
}