---
sidebar_position: 1
---

# Secrets Leakage and Gitleaks

## 🚰 Secrets Leakage - Cause and Effect

The advent of Continuous Integration and Continuous Deployment (CI/CD) has revolutionized the software development landscape, enabling organizations to deliver updates and features at an unprecedented pace. However, with this increased automation and rapid deployment comes a heightened need for detecting secrets embedded in code.

In the CI/CD environment, where code changes are seamlessly integrated and deployed, the inadvertent exposure of secrets like API keys, credentials, or encryption keys can have immediate and far-reaching consequences, potentially leading to data breaches and security vulnerabilities. As a result, the proactive detection of secrets has become an essential security practice in CI/CD workflows, ensuring that sensitive information remains protected in the era of accelerated software delivery.

In this chapter hence, we shall explore how can we utilize and customize Gitleaks to help us in detecting secrets in our git commits and also look at how we can erase our git commit history using [bfg.jar](https://rtyley.github.io/bfg-repo-cleaner/) utility

## 🔍 Introduction to Gitleaks

**GitLeaks** is a powerful open-source tool designed to scan Git repositories for exposed secrets and sensitive information. It helps organizations proactively identify vulnerabilities and security risks in their code repositories. You can find GitLeaks on GitHub [here](https://github.com/zricethezav/gitleaks), making it easily accessible for developers and security professionals to enhance the security of their Git-based projects.

We are going to look at integrating Gitleaks in our Github Actions in two ways

### ⚡ Triggering on Commits

By adding the below code in each Github Action that we have we'll be running Gitleaks in each github action that runs on every commit. Hence, every commit will now be scanned for secrets leakage.

```yaml
      - name: Run Gitleaks
        uses: gitleaks/gitleaks-action@v2
        continue-on-error: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GITLEAKS_NOTIFY_USER_LIST: ${{ env.GIT_ACTOR }}
```

### ⏰ Triggering on Cron

In addition to triggering on every commit, we'll also configure a Github Action that will run Gitleaks on a period schedule like 8.00 AM as configured in the job below.

```yaml
name: s4cp.gitleaks

on:
  workflow_dispatch:
  schedule:
    - cron: "0 8 * * *" # run once a day at 8 AM

env:
  GIT_ACTOR: "@${{ github.actor }}"

jobs:
  scan:
    name: gitleaks
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GITLEAKS_NOTIFY_USER_LIST: ${{ env.GIT_ACTOR }}
```
