---
sidebar_position: 7
---

# 2.4.7 AWS Key Management Process

1. User generates his/her own GPG Keys and adds the public key into the `data` folder as [described here](/docs/chapter2-securing-iam/aws_iam_users/generating_gpg_keys.md#-copying-the-public-gpg-key-of-terraform)
2. Updates the `user.auto.tfvars` file with the requisite information like username,public key name and the privileges.
3. Checks in the code and creates a PR for approval.
4. Once PR is approved and merged, user will be created.
5. Extracts the temporary password and the encrypted AWS access keys.
6. Changes the console password,configures the MFA and decrypts the AWS Access keys using the private GPG on his/her own machine.
7. Assumes the IAM Role and accesses the Cloud as needed.

:::tip Alternative to GPG Keys

An alternative to generating GPG keys from CLI is to use [https://keybase.io](https://keybase.io) where each user can publish their own GPG keys on internet. Terraform has provision to read the published GPG keys from internet.

:::