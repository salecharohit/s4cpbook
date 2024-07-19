// Add only Variables that'll be used Globally across all modules
// Adding default values to environment and region to assist developers will testing in development environment

variable "environment" {
  description = "The Deployment environment"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "domain" {
  description = "The FQDN domain"
  type        = string
}

variable "org_name" {
  description = "Name of Organisation"
  type        = string
  default     = "s4cp"
}

variable "db_name" {
  description = "Name of the PostgreSQL Database"
  type        = string
  default     = "s4cp"
}

variable "db_user_name" {
  description = "Name of User for Accessing PGQSL Database"
  type        = string
  default     = "s4cp"
}