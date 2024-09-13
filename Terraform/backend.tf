terraform {
  backend "s3" {
    bucket         = "deploy-mayank-mumbai"   
    key            = "terraform/state/terraform.tfstate"  
    region         = "ap-south-1"            
  }
}

