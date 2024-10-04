---
sidebar_position: 8
---

# 🎬 Outro

And that was all folks ! Happy that everyone has endured this training till this stage 😂. If you'll liked it please [tweet](https://x.com/intent/tweet/?text=Secure%204C's%20of%20your%20Software%20Product%20!%20&url=https://github.com/salecharohit/s4cpbook) about it so many more can learn !

As a recap, let's run through our [Threat Model](/docs/chapter1-insecure-code/threat-model.md) once again and see if we were able to mitigate all of our observations/threats.

## 📄 Code

1. **Web/API Vulnerabilities**:
   - **Threat** *Injection*: This includes vulnerabilities like SQL injection, where an attacker can manipulate database queries through user input, potentially gaining unauthorized access to data or even control over the application.
   - **Threat** *Server-Side Request Forgery (SSRF)*: Attackers can trick the server into making requests to internal resources or external services, potentially revealing sensitive information or causing server-side actions.   
   - **Control** We did attempt to identify quite a bit of these findings in the [Static Application Security Chapter](/docs/chapter3-securing-code/static_application_security_testing/introduction_to_semgrep.md) using Semgrep. We created our custom Semgrep rules and provided a brief background on [how to refine](/docs/chapter3-securing-code/static_application_security_testing/refining_semgrep_rules.md) them.

2. **Vulnerable Dependencies**:
   - **Threat** Outdated or unpatched dependencies are a common target for attackers. To address this, keep dependencies up-to-date and regularly audit them for known vulnerabilities.
   - **Control** This was taken care off in the [Software Composition Analysis](/docs/chapter3-securing-code/software_composition_analysis/introduction_to_dependency_checker.md) using dependency-checker tool.

3. **Sensitive Information Leakage through Code**:
   - **Threat** Insecure handling of sensitive data, such as API keys or user credentials, can lead to data leaks. Proper encryption and access controls are critical to prevent this.
   - **Control** We not only learnt how to [detect secrets in code](/docs/chapter3-securing-code/secrets_detection/secrets_leakage_gitleaks.md) using Gitleaks but also learnt how to [clean up the mess](/docs/chapter3-securing-code/secrets_detection/cleaning_git_commit_history.md). We also learnt how to create our own [custom gitleaks configuration](/docs/chapter3-securing-code/secrets_detection/customizing_gitleaks.md) to catch certain secrets that Gitleaks may not be supporting.

## 🐳 Container

1. **Image Mutability**
   - **Threat** Docker image is being pushed into the registry and pulled for execution using the `latest` tag. This violates the property of immutability as any change , benign or malicious , will automatically start running in the live environment.
   - **Control** We designed a custom [Docker Continous Integration](/docs/chapter4-securing-container/docker_continous_integration/docker_continous_integration.md) process where-in a limited OIDC IAM Role is being used to push images into registry. Moreover, as part of this process we are also extracting a [docker image with an immutable tag](/docs/chapter4-securing-container/docker_continous_integration/running_docker_ci.md#-immutable-docker-image) which needs to be then added very carefully in the [kubernetes infrastructure](/docs/chapter5-securing-cluster/production_setup/setting_up_prod.md#add-docker-image)

2. **Insecure Dockerfiles**
   - **Threat** Dockerfile are configured to run containers with root privileges. Running containers with root privileges is risky as it provides potential attackers with broader system access. Best practices involve running containers with the least privilege necessary. Moreover, base images are being pulled from unknown sources risking the supply chain security as well.
   - **Control** We learnt how to identify [non-conformities in Dockerfiles](/docs/chapter4-securing-container/container_security/container_security.md) like running with root, invalid base images etc... using Semgrep. We also learnt how to prepare [Golden Docker Image](/docs/chapter4-securing-container/golden_docker_images/golden_docker_images.md) by preparing [Secure Dockerfiles](/docs/chapter4-securing-container/golden_docker_images/secure_dockerfile.md) as ready-to-use templates.

3. **Container Security**
   - **Threat** Docker base image being pulled may have vulnerable packages that could be exploited. Base images should be selected carefully and kept up-to-date to avoid deploying containers with known security issues.
   - **Control** We utilised a tool called [Trivy](/docs/chapter4-securing-container/container_security/container_security.md) and also [integrated it with Github Actions](/docs/chapter4-securing-container/container_security/integrating_trivy_gha.md) to identify vulnerabilities in the image prepared through the [Docker continuous integration](/docs/chapter4-securing-container/docker_continous_integration/running_docker_ci.md) process.

## ⚓ Cluster

1. **Lack of Role-based Access Control**:
   - **Threat** Proper role-based access control (RBAC) is essential for restricting access to resources within the cluster. Without it, unauthorized users or applications can access and manipulate resources.
   - **Control** We implemented proper [Role-Based Access Control in Kubernetes](/docs/chapter5-securing-cluster/kubernetes_rbac/rbac_kubernetes.md) and also practiced the same through [practically accessing the Kubernetes infrastructure](/docs/chapter5-securing-cluster/kubernetes_rbac/accessing_kubernetes.md) using the two users configured.

2. **Insecure Kubernetes Secrets Management**:
   - **Threat** Secrets, like API keys and certificates, must be managed securely. Insecure management can lead to unauthorized access or data leaks.
   - **Control** We looked at how to [encrypt the kubernetes secrets](/docs/chapter5-securing-cluster/secrets_and_encryption/encrypting_k8s_secrets.md) and also how to integrate [AWS Secrets Manager and Secrets CSI Driver](/docs/chapter5-securing-cluster/secrets_and_encryption/secrets_management_k8s.md) to implement a secure secrets management process.

3. **Unrestricted Container Image Deployment**:
   - **Threat** Deploying unverified or untrusted container images can introduce security risks. Implement image scanning and verification processes.
   - **Control** This was solved through a very simple and convenient to use tool called [Kyverno](/docs/chapter5-securing-cluster/k8s_runtime_security/introduction_to_kyverno.md) where we saw how a [non-comlpliant image was disallowed to run](/docs/chapter5-securing-cluster/k8s_runtime_security/running_kyverno.md) on the Kubernetes infrastructure helping us in evolving [runtime security in kubernetes](/docs/chapter5-securing-cluster/k8s_runtime_security/k8s_runtime_security.md)

4. **Unrestricted Network Connectivity between Pods**:
   - **Threat** Kubernetes network policies should be used to control and restrict network connectivity between pods. Without such controls, data leakage or unauthorized access is possible.
   - **Control** We used [Calico](/docs/chapter5-securing-cluster/k8s_network_security/introduction_to_calico.md) to restrict traffic between [our pod and the AWS RDS](/docs/chapter5-securing-cluster/k8s_network_security/network_security_policy.md)

## ☁️ Cloud

1. **Lack of Role-based Access Control**:
   - **Threat** Role-based access control (RBAC) in cloud environments is crucial to ensure that users and services have the appropriate level of access to resources. Inadequate RBAC can result in unauthorized actions.
   - **Control** We implemented a robust [Role Based Access control](/docs/chapter2-securing-iam/aws_iam_roles/creating_iam_roles_groups.md) which is completely managed through code. Every authz related decision will now be taken through a Pull-Review Request.

2. **Lack of Multi-Factor Authentication (MFA)**:
   - **Threat** MFA adds an extra layer of security by requiring users to provide two or more forms of identity verification. Without MFA, accounts are more vulnerable to breaches.
   - **Control** If a user requires to access the AWS environment, they need to be assigned an IAM Role which is accessible only through an [MFA device](/docs/chapter2-securing-iam/aws_iam_users/configuring_goku_access.md) that was configured for all users.

3. **Lack of Enforcement of Security Policy and Governance**:
   - **Threat** Security policies and governance frameworks help ensure that cloud resources adhere to security standards. A lack of enforcement can lead to non-compliance and security breaches.
   - **Control** We implemented [Service Control Policies](/docs/chapter6-securing-cloud/service_control_policies/introduction_to_scps.md) that translate an organisations policies and priorities into gated controls enforcing compliance.

4. **Lack of Access Key Management Process**:
   - **Threat** The lack of an Access Key Management Process signifies a missing framework for securely handling and overseeing access keys within an organization's security practices. This absence poses security risks, potentially leading to unauthorized access, compliance issues, and difficulties in monitoring or revoking keys promptly when necessary. Establishing a structured process for creating, distributing, and managing access keys is essential to minimize vulnerabilities and maintain control over sensitive resources.
   - **Control** All authz related operations are now governed through Code which includes the [access key generation](/docs/chapter2-securing-iam/aws_iam_users/aws_key_management_process.md). Every user needs to generate their own access key through a Pull Review request. Also, the access keys are completely useless on their own as assuming an [IAM Role requires MFA](/docs/chapter2-securing-iam/aws_iam_users/generating_gpg_keys.md). Moreover, we looked at implementing [OIDC(Open ID Connect) authentication between Github and AWS](/docs/chapter2-securing-iam/initiate/about_oidc.md), through which we are completely eliminating the requirement of having **long-lived access keys**