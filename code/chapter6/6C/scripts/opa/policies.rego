package aws
 
import input as tfplan

deny[reason] {
    
	r = tfplan.resource_changes[_]
	r.type == "aws_iam_user_policy_attachment"
	r.change.after.policy_arn == "arn:aws:iam::aws:policy/AdministratorAccess"
	reason := sprintf("%-40s :: IAM User Having Administrator Access", [r.change.after.user])

}

deny[reason] {
    
	r = tfplan.resource_changes[_]
	r.type == "aws_iam_role"
    contains(r.change.after.assume_role_policy, "{\"AWS\":\"*\"}")

	reason := sprintf("%-40s :: AWS:* Principal is Not Allowed", [r.change.after.name])

}

deny[reason] {
    
	r = tfplan.resource_changes[_]
	r.type == "aws_iam_role_policy_attachment"
	r.change.after.policy_arn == "arn:aws:iam::aws:policy/AdministratorAccess"
	reason := sprintf("%-40s :: IAM Role Having Administrator Access", [r.change.after.role])

}

deny[reason] {
    
	r = tfplan.resource_changes[_]
	r.type == "aws_security_group_rule"
    r.change.after.type == "ingress"
    r.change.after.cidr_blocks == ["0.0.0.0/0"]

	reason := sprintf("%-40s :: Ingress Security Group Rule Having 0.0.0.0/0 as CIDR", [r.address])
}