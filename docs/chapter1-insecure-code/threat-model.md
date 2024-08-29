---
sidebar_position: 3
---

# 🧠 Threat Model

Let's dive a bit deeper into each of these potential threats and security issues across the four pillars of a product:

## 📄 Code

1. **Web/API Vulnerabilities**:
   - *Injection*: This includes vulnerabilities like SQL injection, where an attacker can manipulate database queries through user input, potentially gaining unauthorized access to data or even control over the application.
   - *Server-Side Request Forgery (SSRF)*: Attackers can trick the server into making requests to internal resources or external services, potentially revealing sensitive information or causing server-side actions.

2. **Vulnerable Dependencies**:
   - Outdated or unpatched dependencies are a common target for attackers. To address this, keep dependencies up-to-date and regularly audit them for known vulnerabilities.

3. **Sensitive Information Leakage through Code**:
   - Insecure handling of sensitive data, such as API keys or user credentials, can lead to data leaks. Proper encryption and access controls are critical to prevent this.

## 📦 Container

1. **Containers Running with Root Privileges**:
   - Running containers with root privileges is risky as it provides potential attackers with broader system access. Best practices involve running containers with the least privilege necessary.

2. **Invalidated Container Base Images**:
   - Failing to update or validate base images can result in outdated software with known vulnerabilities. Regularly update and validate base images to ensure security.

3. **Vulnerable Base Images**:
   - Base images should be selected carefully and kept up-to-date to avoid deploying containers with known security issues.

## ⚓ Cluster

1. **Lack of Role-based Access Control**:
   - Proper role-based access control (RBAC) is essential for restricting access to resources within the cluster. Without it, unauthorized users or applications can access and manipulate resources.

2. **Insecure Kubernetes Secrets Management**:
   - Secrets, like API keys and certificates, must be managed securely. Insecure management can lead to unauthorized access or data leaks.

3. **Unrestricted Container Image Deployment**:
   - Deploying unverified or untrusted container images can introduce security risks. Implement image scanning and verification processes.

4. **Unrestricted Network Connectivity between Pods**:
   - Kubernetes network policies should be used to control and restrict network connectivity between pods. Without such controls, data leakage or unauthorized access is possible.

## ☁️ Cloud

1. **Lack of Role-based Access Control**:
   - Role-based access control (RBAC) in cloud environments is crucial to ensure that users and services have the appropriate level of access to resources. Inadequate RBAC can result in unauthorized actions.

2. **Lack of Multi-Factor Authentication (MFA)**:
   - MFA adds an extra layer of security by requiring users to provide two or more forms of identity verification. Without MFA, accounts are more vulnerable to breaches.

3. **Lack of Enforcement of Security Policy and Governance**:
   - Security policies and governance frameworks help ensure that cloud resources adhere to security standards. A lack of enforcement can lead to non-compliance and security breaches.

4. **Lack of Access Key Management Process**:
   - The lack of an Access Key Management Process signifies a missing framework for securely handling and overseeing access keys within an organization's security practices. This absence poses security risks, potentially leading to unauthorized access, compliance issues, and difficulties in monitoring or revoking keys promptly when necessary. Establishing a structured process for creating, distributing, and managing access keys is essential to minimize vulnerabilities and maintain control over sensitive resources.  

To mitigate these security issues, organizations should establish a comprehensive security strategy that includes regular security assessments, vulnerability scanning, security awareness training, and a commitment to following security best practices throughout the product development and deployment lifecycle.

We shall look at mitigating all the above issues by bootstrapping secure defaults in the development cycle.
