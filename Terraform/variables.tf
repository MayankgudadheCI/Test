# variables.tf

variable "access_key" {
  description = "The AWS access key"
  type        = string
  sensitive   = true
}

variable "secret_access_key" {
  description = "The AWS secret access key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "ap-south-1"
}

variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0d1e92463a5acf79d"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair to use"
  type        = string
  default     = "deploy"
}



