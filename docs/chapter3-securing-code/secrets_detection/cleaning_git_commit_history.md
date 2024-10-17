---
sidebar_position: 4
---

# 3.3.4 Cleaning Git Commit History

Leaking secrets in code is very much a common scenario however the problem that arises is the way git work, all your commits and the corresponding data is always available for viewing. Hence, by simply masking your sensitive information in X+1 commit won't hide it in commit X !

The best way to deal with this situation is

- Clean your Git history

- Rotate your credentials and store them in a secure manner (which we'll see in more detail in Chapter 5 : Securing the Cluster)

:::tip BGD Repo Cleaner why all references must be cleaned 

[https://www.aquasec.com/blog/undetected-hard-code-secrets-expose-corporations/](https://www.aquasec.com/blog/undetected-hard-code-secrets-expose-corporations/)

:::

Let's walk through the process of being able to clean the git history

## 👁️ View the Git History

Before we begin let's first view the sensitive information in the git history on github.com

- Click on Commits on the main repository page
- Switch to gitleaks branch as shown below

![](img/view_commit_history_branch.png)

- View the Commit history and the sensitive information

![](img/view_credentials_in_commit_history.png)

## 🧹 Prepare for Git Cleaning

- This command reverts the changes that we did for `providers.tf` and `application.properties` file and pushes it into gitleaks branch. This is what a developer would ideally do when they want to remove the secret from code.

```bash
cd ~/playground/
cp -r ~/s4cpcode/chapter3/3E/. ~/playground/
git status
git add .
git commit -m "removing leaks"
git push --set-upstream origin gitleaks
```

- Next, we need to create a new directory called `leak`

```bash
cd ~
mkdir leak
cd leak
```

## 🧬 Git clone the repo

- Next, we need to now clone and mirror the git repository and the specific branch i.e. `gitleaks` in which our secrets were leaked.
- Copy the mirrored repository and create a backup

:::tip
Please check your username
:::

```bash
cd ~/leak
git clone --mirror -b gitleaks git@github.com:<username>/playground.git
cp -r playground.git playground.git.bak
```

## 📁 Create File Containing Sensitive Text

- Next,we need to create a file `passwords.txt` which contains the exact string that was leaked.
The below command does just that and echoes it to the terminal output.

```bash
cd ~/leak
echo "AKIAERKSDFASDFKASDMD" >> passwords.txt
echo "CuNQE0DQBU1IrTX0K7HBuBTwBLyq0rp0Tm6J2dne" >> passwords.txt
echo "testpassword123" >> passwords.txt
echo "testpassword" >> passwords.txt
cat passwords.txt
```

## 🧹 Clean Git History using BFG

- Next, we'll utilize the [BFG Repo Cleaner](https://rtyley.github.io/bfg-repo-cleaner) tool that will browse through the entire git history and searches for the strings that exist in the `passwords.txt` file that was created in the earlier step.

```bash
java -jar ~/tools/bfg.jar --replace-text passwords.txt playground.git 
```

![](img/3C_7.png)
![](img/3C_8.png)

## 🔄 Git Reflog and Update the changes

Next, we need to perform `git reflog` to update the references in all the previous commits. Once updated we'll force push the changes.

```bash
cd playground.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push -f
```

![](img/git_reflog.png)

### 📖 Explanation of git reflog

1. `git reflog expire --expire=now --all`: This part of the command is responsible for expiring or clearing the reflog entries immediately. The reflog is a history of references, including branches and other commit pointers, which is useful for tracking changes and recovering lost commits. By expiring the reflog entries "now," you're essentially clearing the entire reflog history, making it inaccessible for recovery.

2. `git gc --prune=now --aggressive`: This part initiates the "garbage collection" process in Git. Garbage collection is responsible for cleaning up and optimizing the repository's database. The options used here are as follows:
   - `--prune=now`: This option prunes unreferenced objects immediately, freeing up space and optimizing the repository.
   - `--aggressive`: This option instructs Git to perform a more thorough and resource-intensive garbage collection, further optimizing the repository's database. It's useful when you want to maximize space reclamation.

In summary, the entire command is used to clear the reflog history and perform an aggressive garbage collection, optimizing the Git repository by reclaiming space and ensuring it runs efficiently.

## 🔍 View the Commits

- Again, change branch to gitleaks and open the commit with message `git leaks won't catch` or any other commit id where sensitive information was commited.

![](img/gitleaks_wont_catch_commit.png)

- View the commit 

![](img/secrets_disappeared.png)

## 🔗 Merge the PR

Lastly, we need to close the PR by merging the `gitleaks` branch into `main` branch.

- Merging the branches

![](img/merge_branches.png)

- Close with comment `[skip ci]` as we donot want GHA to run this time.

![](img/skip_ci.png)

:::warning

Its important here to add the string **[skip ci]** in the message as we donot wish to run the Github Actions upon the merge.
Same can be seen in the screenshot below.

1. First enter **[skip ci]** in the comment.
2. Click on `Close with comment` button.

![](img/skip_ci.png)

:::

:::note End of Chapter 3

That completes the Chapter 3, before you move to Chapter 4

- Ensure that you've setup and integrated [Semggrep in Github Actions](/docs/chapter3-securing-code/static_application_security_testing/semgrep_integration_gha.md) for implementing Static Application Security Testing (SAST)
- Ensure that you've setup and integrated [Dependency Checker in Github Actions](/docs/chapter3-securing-code/software_composition_analysis/introduction_to_dependency_checker.md) for implementing Software Composition Analysis (SCA)
- Ensure that you've setup and integrated [Gitleaks in Github Actions](/docs/chapter3-securing-code/secrets_detection/integrating_gitleaks_gha.md) for implementing Secrets Detection
- Ensure that you've learnt how to [Practically remove secrets from Git history](/docs/chapter3-securing-code/secrets_detection/cleaning_git_commit_history.md)

