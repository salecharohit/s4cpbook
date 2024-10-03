---
sidebar_position: 1
---

# Golden Docker Images

Golden images are considered the ideal starting point for creating containers, ensuring consistency and reliability across various environments. By using golden Docker images, organizations can streamline the deployment process, reduce the risk of configuration errors, and maintain a standardized and efficient container infrastructure.

They are also meticulously crafted and maintained to adhere to best practices, ensuring minimal vulnerabilities and a reduced attack surface. These trusted and immutable images simplify security auditing and compliance efforts, providing a secure foundation for containerized applications.

## 🛡️ Dockerfile Security

The best way to create Golden docker images is to review,validate and promote Dockerfiles that are following security best practices such as

Dockerfile Security Best Practices:

1. Use validated base images.
2. Remove unnecessary tools and dependencies.
3. Keep packages up to date.
4. Avoid running as root.
5. Use `COPY` over `ADD` for file copying.
6. Consider multi-stage builds.
7. Regularly scan images for vulnerabilities.

## 🛠️ Dockerfile Semgrep Rules

In order to enforce golden Docker images, we'll make use of the below two Semgrep rules for validating the base images and to avoid running docker container with root privileges.

### ✅ Validating Base Images

The Semgrep rule `valid-base-image` enforces the use of specific base images in Dockerfiles. It uses a regex pattern to match lines starting with `FROM`, disallowing any base images except `maven:3.8.1-openjdk-17-slim` and `openjdk:17-alpine`. If an unauthorized base image is detected, it triggers an error message, promoting compliance and security in Docker image configurations.

```yaml
rules:
  - id: valid-base-image
    patterns:
      - pattern-regex: |
          FROM (?!maven:3\.8\.1-openjdk-17-slim|openjdk:17-alpine).*
    message: Only 'maven:3.8.1-openjdk-17-slim' and 'openjdk:17-alpine' are allowed in the FROM tag of a Dockerfile.
    severity: ERROR
    languages:
      - dockerfile
```

### ✅ Validating Non-Root User

The Semgrep rule missing-user checks for Dockerfiles that use the CMD instruction without specifying a non-root USER. It matches patterns where CMD is present but not within a USER instruction. If a Dockerfile allows commands to run as the default root user, it triggers an error message, emphasizing the security risk of running processes as root and advising the use of a non-root user for enhanced security.

```yaml
# Ref: https://semgrep.dev/playground/r/dockerfile.security.missing-user.missing-user
rules:
  - id: missing-user
    patterns:
      - pattern: |
          CMD $...VARS
      - pattern-not-inside: |
          USER $USER
          ...
    message: By not specifying a USER, a program in the container may run as 'root'.
      This is a security hazard. If an attacker can control a process running as
      root, they may have control over the container. Ensure that the last USER
      in a Dockerfile is a USER other than 'root'.
    severity: ERROR
    languages:
      - dockerfile
```