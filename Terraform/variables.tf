variable "access_key" {
  description = "AWS access key ID"
  type        = string
}

variable "secret_access_key" {
  description = "AWS secret access key"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key name for the EC2 instance"
  type        = string
}
