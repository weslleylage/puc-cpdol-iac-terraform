variable "aws_profile" {
  type        = string
  description = "Perfil da AWS"
}

variable "aws_region" {
  type        = string
  description = "Região da AWS"
}

variable "aws_instance_type" {
  type        = string
  description = "Tipo da instância do EC2"
}

variable "aws_public_key" {
  type        = string
  description = "Chave publica ssh"
}

variable "path_private_key" {
  type        = string
  description = "Path chave privada ssh"
}

variable "prefix" {
  type = string
}