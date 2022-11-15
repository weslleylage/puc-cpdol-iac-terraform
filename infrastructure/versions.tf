terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.39.0"
    }
  }
  backend "s3" {
    profile = "terraform-puc"
    bucket  = "app-puc-terraform"
    region  = "us-east-1"
    encrypt = true
    key     = "state/terraform.tfstate"
  }
}