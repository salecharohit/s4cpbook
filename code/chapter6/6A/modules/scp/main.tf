resource "aws_organizations_policy" "default" {
  name        = var.policy_name
  description = var.description
  type        = "SERVICE_CONTROL_POLICY"
  content     = var.policy_file_json
  tags = {
    terraform-managed = "true"
  }
}

# Attach the Policies provided to the IAM role created above
resource "aws_organizations_policy_attachment" "default" {
  count = length(var.account_ids)

  target_id = var.account_ids[count.index]
  policy_id = aws_organizations_policy.default.id
}
