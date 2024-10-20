import React from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import HomepageFeatures from '@site/src/components/HomepageFeatures';

import styles from './index.module.css';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <div className="container">
      <img src="/img/s4cp.png" alt="" width="25%" height="auto" />
        <h1 className="hero__title">{siteConfig.title}</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
          <Link
            to="/docs/intro">
            <div className={styles.button}>
              Start Securing your Software Product 🔒
            </div>
          </Link>
        </div>
    </header>
  );
}

export default function Home() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={`Securing 4 C's of a Software Product - AWS Edition by @salecharohit`}
      description="Following a successful MVP demonstration, a startup recently secured significant funding and is preparing for a soft launch, highlighting the need for enhanced security measures. Their initial proof of concept lacks essential security standards, including proper Secrets Management and compliance protocols, which are crucial for building customer trust. In response to these challenges, we created 'Securing 4C's of Software Product,' a specialized training program designed to fortify the core pillars of product security: Code, Containers, Clusters, and Cloud. This comprehensive training covers key security domains such as Authentication and Authorization in AWS and Kubernetes, Container Security, and Static Application Security, equipping participants with the knowledge to implement robust security protocols and ensure secure deployments in today’s cloud-native environment.">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
