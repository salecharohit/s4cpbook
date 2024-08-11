# Notes

Use this file to store your notes,ids and temporary strings that will be needed throughout this training.

## Terraform State Output

Global S3 Bucket : 
Global DynamodDB :
Prod Bucket :
Prod DynamodDB :
Dev Bucket :
Dev DynamodDB :

## Account IDs

Dev : <dev-account-id>
Identity : <identity-account-id>
Prod : <prod-account-id>

## Links 

## Users and Passwords

### Terraform

AWS_ACCESS_KEY_ID : 
AWS_SECRET_ACCESS_KEY : 

Roles Assigned
    Dev Account  : arn:aws:iam::<dev-account-id>:role/AssumeRoleAdminWithoutMFAdev
    Prod Account : arn:aws:iam::<prod-account-id>:role/AssumeRoleAdminWithoutMFAprod

### Goku

AWS_ACCESS_KEY_ID : 
AWS_SECRET_ACCESS_KEY : 

Roles Assigned
    Dev Account  : arn:aws:iam::<dev-account-id>:role/AssumeRoleAdminWithMFAdev
    Prod Account : arn:aws:iam::<prod-account-id>:role/AssumeRoleAdminWithMFAprod

Temp-Password :

### Vegeta

AWS_ACCESS_KEY_ID : 
AWS_SECRET_ACCESS_KEY : 

Roles Assigned
    Dev Account  : arn:aws:iam::<dev-account-id>:role/AssumeRoleAdminWithMFAdev
    Prod Account : arn:aws:iam::<prod-account-id>:role/AssumeRoleDeveloperWithMFAprod

Temp-Password : 

## Docker CI

AWS_ROLE_TO_ASSUME_PROD_ECR =
arn:aws:iam::<prod-account-id>:role/AssumeRoleECRWithoutMFAprod

Docker Image : 