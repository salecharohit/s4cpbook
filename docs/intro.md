---
sidebar_position: 1
---

# 👋 Introduction

Following a successful MVP demonstration, a startup recently obtained significant funding. The next step involves a soft launch where security poses a crucial challenge. The initial PoC lacks basic security standards needed for customer trust and compliance for ex: secrets are strewn all across the code, everyone is having admin privileges to AWS and Kubernetes, Compute infrastructure is non-compliant and only a basic web application pentest was conducted with very few findings.

This scenario inspired creation of 'Securing 4C's of Software Product,' a specialized training program tailored to secure the core pillars of product security: Code, Container, Cluster & Cloud.

This training delves deep into key security domains such as Authentication and Authorization in AWS and Kubernetes, Secrets Management & Detection, Supply Chain Security, Container Security, and Static Application Security. It equips attendees with the necessary knowledge to establish robust security protocols, ensuring deployments carry a high level of security assurance.

## 🤺 Who Should Take This Course ?

- Security professionals looking to Switch Over to Product Security
- DevOps/SRE Professionals
- Security Engineers
- Software/Platform Engineers
- Security Architects

## 🎩 Why Should You Take This Course ?

The course is tailored for individuals deeply involved in developing, deploying, or safeguarding applications within cloud and cloud-native environments. It offers a unique focus on embedding security measures into the platform, a frequently underestimated yet crucial aspect for a holistic security stance. Participants will gain practical exposure to implementing various security features, such as authentication, authorization, secrets management, supply chain, and container security. This course caters to software developers, security engineers, and DevOps professionals seeking to elevate their expertise in securing cloud-based applications and platforms. Upon completion, attendees will possess a robust understanding of crafting a secure platform fortified with foundational security measures, instilling confidence in the deployment process.

## 3️⃣ Three Takeaways

- Comprehensive Security Framework Understanding: Gain a profound understanding of how code, containers, clusters, and the cloud interconnect from a security standpoint. Learn to recognize the inherent security implications and develop strategies to fortify these components within the ecosystem.
- Practical Implementation of Security via Github Actions: Access a collection of practical, readily implementable GitHub Actions designed to construct security guardrails within their existing environments. These actions provide a streamlined approach to integrate security measures into the development and deployment pipeline.
- Security Tool Starter Kit : Acquire a starting point for essential security tools such as Semgrep, OPA (Open Policy Agent), Kyverno, and Gitleaks. Understand how these tools function and leverage them as a foundation to build customized security solutions tailored to your team's requirements.

## 📖 Student Requirements

- Should know or have a basic overview of AWS Cloud,Terraform and Github.
- Should be more inclined towards learning on how to better defend their software products by bootstrapping security in the development process.

## 🖱️ What Students Should Bring

All requirements are mandatory.

- Domain Name : This course heavily relies in building a practical application hence, a domain name where you can control the DNS Name servers is a must. If you have a domain name, you could also use a sub-domain name provided your DNS provider supports setting of NS records for sub-domains.
- AWS Account : A fresh new AWS account is a must. Course heavily relies on the fact that your AWS Organisation is **unset**. A budget of approximately 10-15 USD will be needed for running services which are not part of AWS free-tier like Kubernetes and Route53. **Offcourse this approximation considers the fact that you've executed this entire course only once.**. - Google Authenticator/Duo/Authy or any other MFA app that is supported by AWS IAM.
- Personal (Free) Github Account (Please do not use enterprise accounts)
- A laptop with [AWS CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and [Terraform > 1.0](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed. This will be used for the initial setup for the Web-based IDE

## ⚠️ Disclaimer

- **Course Ownership**: This course and all associated materials are created exclusively by Rohit Salecha. They are not affiliated with, nor do they represent the views or policies of any current or former employers.
- **Tool and Technology Endorsement**: Rohit Salecha does not recommend or endorse any specific tools or technologies mentioned in this course. The selection of these tools and technologies is arbitrary and bears no relation to the author's current or past employers.
- **Usage Rights**: Individuals are permitted to use this course to instruct others, provided that no fees are charged to the students.
- **Limitation of Liability**: Rohit Salecha assumes no responsibility for the execution or deployment of the code provided within this course. The code is not production-grade and may require additional scrutiny and due diligence before deployment in a live environment. The primary purpose of this training is to offer a general understanding of security best practices within the scope of the covered technologies.

## ⬆️ How to follow this Course ?

- The course is divided into various chapters and each chapter contains multiple pages. Each page contains multiple sections.
For Ex :

        `Chapter 0 - Setup` -> Chapter

        `AWS Setup` -> Page

        `AWS Account Keys` -> Section

- Each chapter/page/section has been arranged sequentially and needs to be followed completely one after the other. If you miss or jump ahead,code will not work. Hence, please follow each chapter/page/section to its fullest in order to complete the course.