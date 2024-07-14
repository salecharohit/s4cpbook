// @ts-check
// `@type` JSDoc annotations allow editor autocompletion and type checking
// (when paired with `@ts-check`).
// There are various equivalent ways to declare your Docusaurus config.
// See: https://docusaurus.io/docs/api/docusaurus-config

import {themes as prismThemes} from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "Securing 4 C's of a Software Product",
  tagline: 'Practical Product Security by @salecharohit',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://s4cpbook.rohitsalecha.com',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'salecharohit', // Usually your GitHub org/user name.
  projectName: 's4cpbook', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: './sidebars.js',
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/salecharohit/s4cpbook/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      image: 'img/s4cp_computer.png',
      navbar: {
        title: "Securing 4 C's of a Software Product",
        logo: {
          alt: 'Securing 4 Cs of a Software Product',
          src: 'img/s4cp.svg',
        },
        items: [
          { to: '/docs/intro', position: 'right', label: '📖 Docs' },
          {
            to: "https://x.com/intent/tweet/?text=Secure%204C's%20of%20your%20Software%20Product%20!%20&url=https://github.com/salecharohit/s4cpbook", position: 'right', label: '❤️ Tweet'
          },
          {
            to: 'https://github.com/salecharohit/s4cpbook',
            position: 'right',
            label: '🌟 GitHub',
          },
        ],
      },
      metadata: [{ name: 'keywords', content: 'Product Security, Kubernetes Security, Docker Security, Cloud Native Security, Pentesting, DevSecOps, AWS IAM, AWS EKS Security, Kubernetes RBAC, Container Security, Open Source Security, Cloud Security, DevOps Security, Security Compliance, GitHub Actions Security, SAST, SCA, Compliance as Code, Secrets Management, OPA, Kyverno, Trivy, Gitleaks, AWS SCPs, Golden Containers, IRSA, Dependency Checker', }],     
      colorMode: {
        defaultMode: 'dark',
        disableSwitch: true,
        respectPrefersColorScheme: false,
      },      
      footer: {
        style: 'dark',
        links: [
          {
            label: 'Docs',
            to: '/docs/intro',
          },
          {
            label: 'GitHub',
            to: 'https://github.com/salecharohit',
          },
          {
            label: 'Twitter',
            to: 'https://x.com/salecharohit',
          },
          {
            label: 'Stack Overflow',
            to: 'https://stackoverflow.com/users/1679541/rohit-salecha',
          },
          {
            label: 'Linkedin',
            to: 'https://www.linkedin.com/in/rohitsalecha/',
          },
          {
            label: 'Logo by Flaticon',
            to: 'https://www.flaticon.com/free-icons/shipping-and-delivery',
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()
        } - <a href="https://rohitsalecha.com" target = "_blank" rel = "noopener" > Rohit Salecha</a > `,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
      },
    }),
};

export default config;
