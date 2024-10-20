---
sidebar_position: 1
---

# 6.2.1 Introduction to OPA

[Youtube 📺](https://www.youtube.com/watch?v=Am9417a87zU&t=7530s)

Managing cloud infrastructure is a complex task, especially when it comes to ensuring security, compliance, and governance. As organizations adopt Infrastructure as Code (IaC) practices using Terraform, the need for effective policy enforcement becomes paramount. This is where the Open Policy Agent (OPA) comes into play.

Open Policy Agent, often abbreviated as OPA, is an open-source, general-purpose policy engine that enables fine-grained, context-aware policy enforcement across the cloud-native stack. OPA was initially developed as a tool for policy enforcement in Kubernetes, but its versatility and flexibility have made it invaluable in various other domains, including cloud infrastructure management with Terraform.

## ⚡ Why OPA for Terraform ?

Terraform allows you to define, provision, and manage cloud resources using declarative configuration files. While Terraform itself provides some policy enforcement mechanisms, they may not be sufficiently flexible or comprehensive for all scenarios. OPA steps in to fill this gap.
Terraform Outputs its plan in a standard format that can also be extracted in a JSON format. We can build OPA Policies that can evaluate the terraform plan in JSON format and apply the checks we intend to test. Let's understand better with practical examples.

To better understand how OPA works with Terraform its critically essential to first understand the format of a Terraform Plan in JSON

## 📜 Terraform Plan in JSON

A Terraform plan output in JSON format typically contains detailed information about the planned changes to your infrastructure. Here's a sample structure of a Terraform plan output in JSON:

```json
{
  "format_version": "0.1",
  "terraform_version": "0.12.30",
  "planned_values": {
    "root_module": {
      "resources": [
        {
      "address": "module.web.aws_instance.example",
          "mode": "managed",
          "type": "aws_instance",
          "name": "example",
          "index": 0,
          "provider_config_key": "aws",
          "expressions": {
            "ami": "ami-0c55b159cbfafe1f0",
            "instance_type": "t2.micro",
            "subnet_id": "subnet-0123456789abcdef0",
            // Additional expressions...
          },
          "schema_version": 0,
          "values": {
            "ami": "ami-0c55b159cbfafe1f0",
            "instance_type": "t2.micro",
            "subnet_id": "subnet-0123456789abcdef0",
            // Additional values...
          }
        },
        // Additional resources...
      ],
      "depends_on": [
        "module.vpc",
        "module.security_group"
      ],
      "schema_version": 0
    }
  },
  "resource_changes": [
    {
      "address": "module.web.aws_instance.example",
      "mode": "managed",
      "type": "aws_instance",
      "name": "example",
      "provider_name": "aws",
      "change": {
        "actions": [
          "create"
        ],
        "before": null,
        "after": {
          "ami": "ami-0c55b159cbfafe1f0",
          "instance_type": "t2.micro",
          "subnet_id": "subnet-0123456789abcdef0",
          // Additional changed attributes...
        },
        "after_unknown": {
          // Attributes with unknown values...
        }
      }
    },
    // Additional resource changes...
  ],
  "format_version": "0.1",
  "terraform_version": "0.12.30"
}
```

In this sample JSON structure:

- The `planned_values` section provides information about the values that are planned for the Terraform resources. It includes details about the resource, its type, name, provider, expressions (input variables), and the actual values that will be applied.

- The `resource_changes` section lists the changes that are planned for each resource. It includes the resource's address, type, name, provider, and the actions to be taken (e.g., "create," "update," "delete"). It also provides the attribute values before and after the change, including any attributes with unknown values.
**`resource_changes[_].change.after[_]` This is the section that's most useful for us as we shall see ahead.**

- Other sections like `format_version` and `terraform_version` indicate the format and Terraform version used.

This JSON structure allows you to programmatically access and process the Terraform plan output, making it useful for integrating Terraform with other tools like OPA.

## ✏️ Custom Policies in OPA

We can now write custom OPA policies that iterate through `resource_changes[_].change.after[_]` and validate various attributes of the resources that are **going to be created/updated.**
You can write custom policies in Rego, OPA's policy language, to enforce specific requirements, such as naming conventions, access controls, or compliance standards.

For Ex: If we wish to identify from a Terraform Plan what is the instance type of an AWS Instance then we can make use of the following query in OPA

`resource_changes[_].change.after[_].instance_type`
