---
sidebar_position: 2
---

# 2.3.2 Creating AWS IAM Roles and Groups

In this section we'll be creating AWS IAM Roles and Groups that'll be used by Users in AWS accounts to access the specific resources.

## 🛠️ Setup AWS IAM Roles and Groups

Let's go ahead and setup the AWS IAM Roles and Groups as described above. This will also setup the Route53 Domain names and Terraform state storage infrastructure for all prod and dev accounts.

```bash
cd ~/playground
cp -r ~/s4cpcode/chapter2/2C/. .
```

## ✏️ Edit dns.auto.tfvars

- We need to add the domain name that we've configured in [Domain Setup](/docs/chapter0-the-setup/domain-setup.md) section.
- Open File dns.auto.tfvars as shown below and add your domain name. Replace the string `domainX` with your `domain.com`

![](img/dns.auto.tfvars.png)

```bash
git status
git add .
git commit -m 'adding aws IAM Roles and Route53 Zones'
git push
```

## 👁️ View GHA

![](img/view_gha.png)

Once the terraform is successfully applied your route53 Zones and AWS IAM Roles and Groups are successfully created. There is no Terraform Output at this stage.
