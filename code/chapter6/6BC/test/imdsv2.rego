package ec2_imdsv2_policy
 
import input as tfplan
 
deny[reason] {
	r = tfplan.resource_changes[_]
	r.type == "aws_instance"
    not r.change.after.metadata_options[0]
	reason := sprintf("%-40s :: AWS Instance must have IMDSv2 Configured and Enabled", [r.address])
}

deny[reason] {
	r = tfplan.resource_changes[_]
	r.type == "aws_instance"
    r.change.after.metadata_options[_].http_tokens != "required"
	reason := sprintf("%-40s :: AWS Instance must have IMDSv2 Enabled", [r.address])
}