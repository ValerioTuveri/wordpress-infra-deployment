# Provider Configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }
  backend "s3" {
    bucket         = "tf-state-wordpress"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    
  }
}

provider "aws" {
  region = "eu-central-1"
}

