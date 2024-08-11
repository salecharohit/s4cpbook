// Add only Variables that'll be used Globally across all modules

variable "accounts" {
  description = "Account Names that need to be created."
  type        = map(map(string))
}

variable "region" {
  description = "Region of Deployment"
  default     = "us-west-2"
}

variable "org_name" {
  description = "Name of Organisation"
  type        = string
  default     = "s4cp"
}