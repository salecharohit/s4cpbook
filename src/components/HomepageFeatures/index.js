import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Code',
    Svg: require('@site/static/img/code.svg').default,
    description: (
      <>
        Integrate static application security testing (SAST) and secrets scanning into the CI/CD pipeline using open-source tools like Semgrep, Dependency-Checker, and GitLeaks with GitHub Actions
      </>
    ),
  },
  {
    title: 'Container',
    Svg: require('@site/static/img/docker.svg').default,
    description: (
      <>
        Set up AWS ECR and IAM Role for service account access using OIDC, ensure Dockerfile security best practices, validate them with Semgrep, and build and scan secure Docker images with Trivy in GitHub Actions
      </>
    ),
  },
  {
    title: 'Cluster',
    Svg: require('@site/static/img/kubernetes.svg').default,
    description: (
      <>
       Enforce Kubernetes RBAC for secure access, manage and encrypt secrets using AWS Secrets Manager and KMS, implement runtime security with Kyverno, and restrict pod communications using network security policies with Calico.
      </>
    ),
  },
  {
    title: 'Cloud',
    Svg: require('@site/static/img/aws.svg').default,
    description: (
      <>
    Enforce encryption and permissions with SCPs, implement Terraform runtime security with OPA, configure AWS Organization with dev, prod, and identity accounts, set up IAM roles with MFA, enable cross-account access, and create a multi-account CI/CD pipeline in GitHub Actions using OIDC.
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
