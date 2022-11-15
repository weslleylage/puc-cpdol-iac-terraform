locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  commom_tags = {
    ManageBy    = "Terraform"
    Departament = "Technology"
    Provider    = "Infrastructure Team"
    Owner       = "Infrastructure Team"
    Billing     = "Infrastructure"
    Environment = terraform.workspace
    Contact     = "infra@gmail.com"
  }
}