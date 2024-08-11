variable "policy_name" {
  description = "Name of the Policy"
  type        = string
}

variable "description" {
  description = "Description of the Policy"
  type        = string
}

variable "policy_file_json" {
  description = "Complete Policy File in JSON format"
  type        = any

}

variable "account_ids" {
  description = "List of Account IDs to which this Policy needs to be applied to"
  type        = list(string)
}
