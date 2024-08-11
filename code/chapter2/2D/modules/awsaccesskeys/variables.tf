variable "username" {
  description = "Username of the AWS User"
  type        = string
}

variable "pgp_key" {
  description = "PGP Key used for encrypting the secrets"
  type        = string
}

variable "status" {
  description = "Status of the Key,Active or Inactive. If key gets leaked switch status to Inactive"
  type        = string
}