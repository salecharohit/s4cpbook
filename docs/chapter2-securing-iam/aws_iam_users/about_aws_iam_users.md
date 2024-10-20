---
sidebar_position: 1
---

# 2.4.1 About AWS IAM Users

[Youtube 📺](https://www.youtube.com/watch?v=Am9417a87zU&t=1928s)

Now that we've created the IAM Roles and Groups, let's create users that will be using these roles and groups to complete the Role-Based Access Control that we would like to implement.

## 👥 AWS IAM Users RBAC

- We'll be creating Head Users (or human users) that will be accessing the AWS infrastructure through the console and programmatic access(CLI). These users will have MFA enforced.
- No users will have the privileges to create AWS Access Keys as they can only be generated via Terraform.

Following table shows the [IAM Roles](/docs/chapter2-securing-iam/aws_iam_roles/creating_iam_roles_groups.md) that were created and their mapping with each user.

| User      | Role                                                                                 |
|-----------|--------------------------------------------------------------------------------------|
| Goku      | AssumeRoleAdminWithMFAprod,AssumeRoleAdminWithMFAdev,AssumeRoleIAMAdminWithMFA       |
| Vegeta    | AssumeRoleDeveloperWithMFAprod,AssumeRoleDeveloperWithMFAdev                         |

## Configuring Users

- All the users need to be configured in the `global/users.auto.tfvars` as shown below where the following information is required.
  - username
  - Role
  - Public GPG Key file location

```hcl title="global/users.auto.tfvars"
users = {
  goku = {
    username = "goku"
    role     = "admin"
    pgp_key  = "goku.pub"
  },
  vegeta = {
    username = "vegeta"
    role     = "developer"
    pgp_key  = "vegeta.pub"
  }
}
```
