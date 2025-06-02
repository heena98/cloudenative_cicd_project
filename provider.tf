terraform {
  required_version = ">= 1.0"
 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
 
  backend "s3" {
    bucket         = "devops-terraform-state-heena"    # Your S3 bucket name
    key            = "eks/terraform.tfstate"           # Path to state file inside bucket
    region         = "us-east-1"                        # Your AWS region
    dynamodb_table = "terraform-locks"                 # DynamoDB table for locking
    encrypt        = true                               # Encrypt the state file
  }
}
 
provider "aws" {
  region = "us-east-1"
}
 
