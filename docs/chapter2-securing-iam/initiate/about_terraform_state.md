---
sidebar_position: 1
---

# 2.1.1 Terraform State

In this section we'll explore Terraform state and why is it important to store it and also discuss some best practices of storing it.

## {} What is Terraform State ?

Terraform state is a snapshot of your infrastructure's current configuration. It's recorded in a state file, and it tells Terraform what resources exist and how they are configured. For example, if you define an AWS EC2 instance in your configuration, the state file would store information like the instance's ID, IP address, and other attributes. Terraform uses this state to plan and apply changes to match your desired configuration. It's like a blueprint of your infrastructure.

```json
{
  "version": 4,
  "terraform_version": "0.15.4",
  "serial": 1,
  "lineage": "a7b8d567-0d28-49d2-b35f-2f6b8e19740c",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "example_instance",
      "provider": "provider.aws",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "ami": "ami-0c55b159cbfafe1f0",
            "instance_type": "t2.micro",
            "tags": {
              "Name": "example-instance"
            },
            "private_ip": "10.0.0.123",
            // Other attributes...
          },
        }
      ],
    }
  ]
}
```

This simplified example demonstrates the state file's structure. In practice, it's best to manage Terraform state files using Terraform itself and store them remotely to ensure consistency and security.

### 💾 Why store terraform state ?

We are storing the Terraform state in an S3 bucket and using DynamoDB for change locking.
Storing Terraform state in an S3 bucket with DynamoDB provides:

- Concurrency Control: Avoid conflicts with multiple users.
- Versioning: History of state changes.
- Remote State Management: Collaboration.
- Backup and Restore: Easy state recovery.
- Consistency: Prevents data corruption.

### ✅ Best Practices for Terraform State Storage

- Use Remote State: Store state in S3 and use DynamoDB for locking.
- Enable Versioning: Maintain a history of state changes.
- Secure Access Control: Use IAM policies to restrict access.
- Encrypt State: Enable server-side encryption for S3.