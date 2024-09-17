
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

variable "access_key" {
  description = "AWS access key ID"
  type        = string
}

variable "secret_access_key" {
  description = "AWS secret access key"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "deploy-mayank-mumbai"
}
variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "ap-south-1"
}
