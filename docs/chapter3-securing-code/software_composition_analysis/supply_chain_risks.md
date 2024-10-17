---
sidebar_position: 1
---

# 3.2.1 Supply Chain Risks

## ❗ What are Supply Chain Risks ?

Supply chain risks refer to the potential threats and vulnerabilities that can impact an organization's product or service delivery through its supply chain. These risks can encompass a wide range of issues, including disruptions in the procurement process, logistical challenges, geopolitical uncertainties, and security breaches. Managing supply chain risks is critical for ensuring the reliability and resilience of the supply chain. It involves strategies to identify, assess, and mitigate these risks, as well as the development of contingency plans to maintain consistent operations even in the face of unexpected challenges. Effective supply chain risk management is essential for business continuity and protecting an organization's reputation and bottom line.

If we take example of our own code based there are multiple touch points for Supply Chain risks that we need to be aware of

- **Github Actions** : We are using multiple github actions throughout our code that are bundled from external repositories for ex: `mathiasvr/command-output@v2.0.0` for spooling PR comments.

- **Terraform Modules** : Multiple terraform modules are being used in our code for ex: `terraform-aws-modules/eks/aws` version 19.12.0 is being used for setting up a Managed EKS Environment.

- **Helm Modules** : Multiple helm modules are being used in our code for ex: `aws-load-balancer-controller` version 1.5.0 is being used for setting up an AWS Load Balancer Controller.

- **Software Composition** : Multiple dependent libraries are being used to build our applications/APIs for ex : all the dependencies for our app are included in the `pom.xml` file. They are all version locked.

Best way of mitigating the supply chain risks posed by `Github Actions` and `Terraform/Helm Modules` is to ensure that we are version locking them and maybe also review the open-source code before we apply them in our code.

However, for Software Composition analysis, the effort is wider and more complex. Discussed below as to why we need a proper/automated SCA.

## 🧪 Why we need SCA ?

1. **Identify Vulnerabilities**: SCA scans code to pinpoint open-source libraries and components with known security vulnerabilities, reducing the risk of exploitation.

2. **Ensure License Compliance**: It checks for license violations, helping organizations adhere to licensing agreements and avoid legal issues.

3. **Enhance Code Quality**: SCA helps maintain code quality by identifying outdated or deprecated components that may affect performance and functionality.

4. **Streamline Development**: By providing insights into dependencies, SCA enables developers to make informed decisions about which libraries to use, streamlining development processes.

5. **Mitigate Supply Chain Risks**: SCA assists in managing third-party dependencies and monitoring their security, minimizing supply chain risks.

6. **Support Regulatory Compliance**: In regulated industries, SCA helps meet compliance requirements by ensuring the use of approved and secure components.

In summary, SCA is crucial for maintaining secure, compliant, and high-quality software, mitigating vulnerabilities, and supporting efficient development processes.