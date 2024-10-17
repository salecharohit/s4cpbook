---
sidebar_position: 1
---

# 5.3.1 Encrypting K8s Secrets

AWS EKS being a managed service it becomes extremely critical to logically segregate customer data or any information that is being stored. The best way to logically segregate this information is to the encrypt it using encryption keys that we have more control over.
Hence, in this section we'll look at how we can encrypt kubernetes secrets using AWS KMS and also store sensitive information like database passwords in a separate service like AWS Secrets Manager. 
We'll also employ CSI Secrets Driver that will pull secrets from AWS Secrets Manager and populate the environment variables of the Kubernetes deployment at runtime.

## 🔐 Encrypting K8s Secrets with KMS

By default in any Kubernetes environment the Secrets objects are encoded as base64 strings and can be easily decoded.Hence, it is extremely important to encrypt these objects and in this section we shall see how it can be done using AWS KMS by deriving an key that is used for encryption.

The below command prepares and deploys the code that will encrypt the K8s secrets using a key derived from AWS KMS.

```bash
cd ~/playground/
cp -r ~/s4cpcode/chapter5/5D/. ~/playground/
git status
git add .
git commit -m "eks encryption"
git push
```

Any other resource that is using K8s Secrets to store any sensitive information also needs to access this key. For Ex:
The AWS ALB stores the ACM certificate as a kubernetes secret. In the above command we updated the Permissions Policy that is needed by AWS ALB for its operation with the following code. Here we are allowing AWS ALB to fetch the specific Key that is used for encryption.

```json
{
    "Effect": "Allow",
    "Action": [
        "kms:*"
    ],
    "Resource": "${kms_key_arn}"
}
```
