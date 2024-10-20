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
      description="A startup secured funding after a successful MVP demonstration and created 'Securing 4Cs of Software Product' to enhance security across Code, Containers, Clusters, and Cloud. This training equips participants with essential skills in AWS and Kubernetes security, Container Security, and Static Application Security for secure deployments..">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
