---
sidebar_position: 1
---

# 6.1.1 Introduction to SCPs

Service Control Policies (SCPs) are a fundamental component of AWS Organizations, a service that enables you to centrally manage and govern multiple AWS accounts. SCPs are a set of policy documents that help you control what services and actions can be performed within member AWS accounts. These policies work alongside Identity and Access Management (IAM) policies to provide fine-grained control over actions and resources.

## 🔐 Why do we need SCPs

1. **Centralized Governance:** AWS Organizations allows you to organize your accounts into a hierarchy, making it easier to manage multiple AWS accounts. SCPs provide centralized control over these accounts, helping you enforce security and compliance policies across your organization.

2. **Security and Compliance:** SCPs are essential for ensuring that security and compliance standards are met. By limiting the actions and services that accounts can access, you reduce the risk of unauthorized or unintended actions that could compromise security or compliance.

3. **Resource and Cost Management:** SCPs help you manage resources and costs by controlling which services can be used. This prevents overspending and helps you allocate resources more efficiently.

4. **Customization:** SCPs are highly customizable, allowing you to tailor access permissions to your organization's specific needs. You can create policies that align with your organization's unique security and compliance requirements.

In summary, SCPs are a critical element in AWS Organizations that provide centralized governance, enhance security and compliance, enable resource and cost management, and offer customization of access controls across multiple AWS accounts.

As an example, let's say we would like to restrict certain EC2 types in the development environment. We can enforce that check using SCPs as we'll see later.

## ⚡ Installing the SCPs

Let's execute the command below to install the above SCPs in our AWS environment 

```bash
cd ~/playground/
cp -r ~/s4cpcode/chapter6/6A/. ~/playground/
git status
git add .
git commit -m "installing scps"
git push
```
