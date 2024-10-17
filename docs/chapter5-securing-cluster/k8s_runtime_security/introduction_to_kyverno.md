---
sidebar_position: 2
---

# 5.4.2 Introduction to Kyverno

[Kyverno](https://github.com/kyverno/kyverno/) is an admission controller for Kubernetes that specializes in policy management. It allows you to enforce custom policies and rules during the admission process, ensuring that resources conform to your organization's security, compliance, and operational requirements. Kyverno's flexibility and extensibility make it a powerful tool for fine-grained policy enforcement within Kubernetes clusters, contributing to enhanced security and governance.

Consider an example policy for an organization such as 

- Allow containers only downloaded from a specific container registry
- Allow containers only if resource limits are configured
- Allow containers only if Pod Security Policies are configured

Using Kyverno we can enforce all the above (and many more) policies using simple YAML based rules.

## 📝 Kyverno Rules

Below is a Kyverno rule that allows only containers downloaded from a specific ECR registry. This helps in disallowing any malicious or unintended containers/resources from running.

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: restrict-images-to-ecr
  annotations:
    policies.kyverno.io/title: Restrict Images to AWS ECR
    policies.kyverno.io/category: Pod Security, EKS Best Practices
    policies.kyverno.io/severity: high
    policies.kyverno.io/minversion: 1.6.0
    policies.kyverno.io/subject: Pod
    policies.kyverno.io/description: >-
      All pods executed by (except the system ones) must be deployed through the ECR registry created in AWS       
spec:
  validationFailureAction: Enforce
  background: true
  rules:
  - name: check-image-registry
    match:
      all:
      - resources:
          kinds:
          - Pod
          namespaces:
          - "${var.namespace}"
    validate:
      message: "Pods can only use images from the AWS ECR registry XXXXXXXXXXX.dkr.ecr.us-east-2.amazonaws.com/s4cpecr"
      pattern:
        spec:
          containers:
          - image: "XXXXXXXXXXX.dkr.ecr.us-east-2.amazonaws.com/s4cpecr"
```
