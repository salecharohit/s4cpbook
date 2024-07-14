import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Code',
    Svg: require('@site/static/img/code.svg').default,
    description: (
      <>
        🔍 Implement SAST and secrets scanning with Semgrep, Dependency-Checker, and GitLeaks. ⚙️ Integrate them into the CI/CD pipeline with GitHub Actions for continuous security checks. 🚀🔒
      </>
    ),
  },
  {
    title: 'Container',
    Svg: require('@site/static/img/docker.svg').default,
    description: (
      <>
        🚀 Set up AWS ECR and IAM Role for service account access. 🔐 Understand and validate Dockerfile security best practices with Semgrep. 🛠️ Build and scan secure Docker images with Trivy via GitHub Actions. 🔍🐋
      </>
    ),
  },
  {
    title: 'Cluster',
    Svg: require('@site/static/img/kubernetes.svg').default,
    description: (
      <>
        🔒 Enforce Kubernetes RBAC for secure access. 🔑 Manage and encrypt secrets with AWS Secrets Manager and KMS. 🛡️ Implement runtime security with Kyverno. 📡 Restrict pod communications with Calico network policies. 🌐
      </>
    ),
  },
  {
    title: 'Cloud',
    Svg: require('@site/static/img/aws.svg').default,
    description: (
      <>
        🔒 Enforce encryption and permissions for AWS resources with SCPs. 🛡️ Secure Terraform runtime with OPA. 👥 Implement AWS IAM with Organizations for centralized access control. 🌐🔐
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col-4 col')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
      <h2 className={clsx('margin-bottom--lg', 'text--center')}>
        The 4 C's of a Software Product 🤩
        </h2>
        <br />        
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
