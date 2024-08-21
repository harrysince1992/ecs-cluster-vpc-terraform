terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }

  cloud {
    organization = "harry-workspace"
    workspaces {
      name = "ecs-cluster"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key # my access key
  secret_key = var.secret_key # my secret key
}