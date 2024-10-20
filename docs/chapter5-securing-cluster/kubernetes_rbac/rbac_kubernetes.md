---
sidebar_position: 1
---

# 5.2.1 RBAC in AWS EKS

[Youtube 📺](https://www.youtube.com/watch?v=Am9417a87zU&t=6009s)

In AWS EKS Authentication is managed via AWS IAM only through various identities i.e. either as a user or as an IAM Role.
Authorization however is done by mapping the AWS IAM identity (user or IAM Role) with the existing Kubernetes RBAC using the Role and RoleBinding Kubernetes objects.

Mapping between the AWS IAM identity and the Kubernetes Role is done in a configmap called `aws-auth` which can be accessed using the following command
`kubectl get cm aws-auth -n kube-system -o yaml`

A sample such `aws-auth`

```yaml
apiVersion: v1
data:
  mapRoles: |
XXXXXXXXXXXXXXX------SNIPPED-------XXXXXXXXXXXXXXXXXXXXX
    - rolearn: arn:aws:iam::XXXXXXXXXXX:role/AssumeRoleAdmin
      username: admin
      groups:
        - admin
    - rolearn: arn:aws:iam::XXXXXXXXXXX:role/AssumeRoleDeveloper
      username: developer
      groups:
        - developer
    - rolearn: arn:aws:iam::XXXXXXXXXXX:role/AssumeRoleReadOnly
      username: readonly
      groups:
        - readonly
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
```

An AWS IAM Role defined through `rolearn` is mapped to a specific Kubernetes Role i..e developer,admin or readonly which is having different permissions created through a RoleBinding Object as shown below.

```toml
 resource "kubernetes_role_v1" "developer" {
   metadata {
     name      = "developer"
     namespace = kubernetes_namespace_v1.app.metadata.0.name
   }

   rule {
     api_groups = ["*"]
     resources  = ["pods", "deployments", "services", "ingresses", "namespaces", "jobs", "daemonset"]
     verbs      = ["*"]
   }
 }
 
 resource "kubernetes_role_binding_v1" "developer" {
   metadata {
     name      = "developer"
     namespace = kubernetes_namespace_v1.app.metadata.0.name
   }
   role_ref {
     api_group = "rbac.authorization.k8s.io"
     kind      = "Role"
     name      = "developer"
   }
   subject {
     kind      = "Group"
     name      = "developer"
     api_group = "rbac.authorization.k8s.io"
   }
 }
```

So now, whenever the IAM Role `arn:aws:iam::XXXXXXXXXXX:role/AssumeRoleDeveloper` is accessing the Kubernetes through kubectl that identity would get `developer` permissions in the cluster.

Hence, we now need to create AWS IAM Roles and Kubernetes RBAC objects in order to have proper RBAC implementation which we'll do next !