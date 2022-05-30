### VARIABLES VPC

variable "infra_env" {
  type        = string
  description = "Environment Infra"
}

variable "vpc_cidr" {
  type        = string
  description = "Range to ip VPC"
}

variable "azs" {
  type        = list(string)
  description = "Azs for create subnets"
}

variable "public_subnets" {
  type        = list(string)
  description = "Create public subnet for AZ public"
}

variable "private_subnets" {
  type        = list(string)
  description = "Create private subnet for AZ public"
}