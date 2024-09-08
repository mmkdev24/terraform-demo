# Input Variables
# AWS Region
variable "aws_region" {
    description = "Region in which AWS resources to be created"
    type = string
    default = "us-east-1"
  }

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

# EC2 Instance Key Pair
variable "instnace_keypair" {
  description = "Key Pair associated with EC2 Instance"
  type = string
  default = "terraform-key"
}

# EC2 Instnce Type = List
variable "instance_type_list" {
  description = "EC2 Instance List"
  type = list(string)
  default = [ "t2.micro", "t2.small", "t2.large" ]
}

 # EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instance Map"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "st"  = "t2.small"
    "it"  = "t2.large"
  }
}