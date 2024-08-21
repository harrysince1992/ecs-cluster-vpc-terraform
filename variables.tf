variable "ecs-cluster-name" {
  description = "name of the ecs cluster"
  type        = string
  default     = "demo-ecs-cluster"
}

variable "access_key" {}
variable "secret_key" {}
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
  validation {
    condition     = var.region == "ap-south-1" || var.region == "us-east-1"
    error_message = "invalid region name. must be one of us-east-1 or ap-south-1"
  }
}

variable "vpc_cidr_range" {
  description = "CIDR range of the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

