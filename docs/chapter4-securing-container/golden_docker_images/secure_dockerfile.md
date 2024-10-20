---
sidebar_position: 3
---

# 4.2.3 Secure Dockerfile

[Youtube 📺](https://www.youtube.com/watch?v=Am9417a87zU&t=5248s)

Let's now fix these issues by updating the dockerfile with the following command.

```bash
cd ~/playground/
cp -r ~/s4cpcode/chapter4/4CC/. ~/playground/
git status
git add .
git commit -m "checking in secure Dockerfile"
git push --set-upstream origin dockersec
```

![](img/dockerfile_secure_rerun.png)

The command above will push the below secure dockerfile into github and re-run semgrep.

```dockerfile
FROM maven:3.8.1-openjdk-17-slim AS MAVEN_BUILD
WORKDIR /build/
COPY pom.xml /build/
COPY src /build/src/
RUN mvn package

FROM openjdk:17-alpine
RUN addgroup boot && adduser -D -h /home/boot -s /bin/ash boot -G boot
USER boot
WORKDIR /home/boot
COPY --from=MAVEN_BUILD /build/target/gitops.jar /home/boot/gitops.jar
EXPOSE 8080
CMD java -jar /home/boot/gitops.jar
```

## 👁️ View PR

View the PR Comments and it'll now show the semgrep docker rules have passed as shown below only 6 issues as compared to 10 earlier.

![](img/view_pr_secure_dockerfile.png)

## 🔀 Merge the PR

Let's now merge the PR and allow the Docker Github Action workflow continue to run.

![](img/merge_secure_dockerfile.png)
:::

