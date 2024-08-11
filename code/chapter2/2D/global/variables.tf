// Add only Variables that'll be used Globally across all modules
// Keeping region as default to us-east-2 since its IAM

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

variable "domain" {
  description = "Primary Domain name that has been pre-configured"
  type        = string

}

variable "users" {
  description = "List of Users, usernames , isAdmin PGP Keys"
  type        = map(map(string))
}

