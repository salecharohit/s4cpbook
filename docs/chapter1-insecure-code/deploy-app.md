---
sidebar_position: 1
---

# ✨ Deploy Application

The below script will provision the entire AWS infrastructure including AWS EKS,AWS RDS,AWS Route53 and the application deployed as a Kubernetes Deployment along with the necessary ingress controller which is mapped to the hostname provided.

Application doesn't have much functionality at present and all the vulnerable pieces of code are just dead code added on purpose , its not actually being executed.

## 📋 Cloning Code Repository

- Clone the main code repository in the home folder. 

```bash
cd ~
git clone git@github.com:salecharohit/s4cpcode.git
```

:::warning

Please ensure that you clone it in the home folder as the folder names and their location is very important to follow this course and the commands
:::

The repository that you've downloaded is divided into various chapters aligning to the various topics we will be discussing in this course. 

```bash

s4cpcode git:(main) ls -l
total 8
-rw-r--r--   1 rohit  staff  1777 11 Aug 19:57 README.md
drwxr-xr-x@  6 rohit  staff   192 10 Aug 18:15 chapter1
drwxr-xr-x@  7 rohit  staff   224 10 Aug 18:15 chapter2
drwxr-xr-x@  9 rohit  staff   288 10 Aug 18:15 chapter3
drwxr-xr-x@  8 rohit  staff   256 10 Aug 18:15 chapter4
drwxr-xr-x@ 11 rohit  staff   352 10 Aug 18:15 chapter5
drwxr-xr-x@  8 rohit  staff   256 10 Aug 18:15 chapter6

```



## 🔧 Modify `terraform.auto.tfvars`




## ▶️ 
