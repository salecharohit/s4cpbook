---
sidebar_position: 1
---
# 5.5.1 EKS Default VPC CNI

The Default VPC CNI (Container Network Interface) in Amazon EKS is the networking solution used in EKS clusters running in the default Virtual Private Cloud (VPC). It integrates pods with the VPC, assigns IP addresses, manages security groups, and ensures efficient network performance, simplifying Kubernetes networking setup on AWS.
This CNI plugin allows pods to communicate with each other within the VPC but doesn't enforce network policies out of the box. In other words,all traffic within the VPC is typically allowed by default, and NetworkPolicies won't take effect.
So something like below wouldn't work in AWS EKS

```yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: default-deny
spec:
  podSelector:
    matchLabels: {}
```

## 🛡️ Why Apply Network Security Policy ?

Implementing Network Policies in Kubernetes enhances security by enforcing the least privilege principle, segmentation, and defense in depth. This aids compliance, controls application behavior, supports incident response, and improves auditing and monitoring of network traffic within the cluster.

