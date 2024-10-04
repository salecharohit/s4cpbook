---
sidebar_position: 3
---

# Refining Semgrep Rules

**Semgrep** is a powerful tool for static analysis that allows developers to write custom rules for code scanning and detect vulnerabilities, bugs, or code patterns. However, running Semgrep on large codebases can sometimes result in unnecessary findings on third-party code or other irrelevant areas. To optimize your Semgrep usage, it’s essential to refine the rules to focus on relevant code and enforce coding practices more effectively. Below are two strategies you can employ:

## 🎯 Using `.semgrepignore`

One way to refine your Semgrep scanning is by using the `.semgrepignore` file, similar to `.gitignore`. This file helps Semgrep ignore specific directories or files that do not require scanning, such as third-party libraries, automatically generated code, parts of the codebase not written by your developers or unit test cases written by developers. Im my experience, ignoring the `test/` and `tst/` etc... kind of folders does help as most of the code written here is never deployed into production.

By specifying directories and file patterns in `.semgrepignore`, you can significantly reduce the noise in your scan results, allowing Semgrep to focus only on the custom code written by your team. This leads to faster scans and more actionable findings.

### 👁️‍🗨️ Example of `.semgrepignore`:
```
# Ignore third-party libraries
node_modules/
vendor/
test/
tst/

# Ignore auto-generated files
generated/
*.pb.go

# Ignore specific files
legacy_code/
```

With `.semgrepignore`, you ensure that Semgrep runs only on the code you care about, enhancing both performance and relevance of the scan results.

## 🚫 Identifying Anti-Patterns

Beyond ignoring irrelevant code, another crucial aspect of refining Semgrep rules is to enforce specific coding patterns or detect deviations from accepted practices. One effective way to do this is by writing custom Semgrep rules to identify **anti-patterns** in your codebase.

For example, if your team has adopted an **ORM framework** (like SQLAlchemy, Django ORM, or Hibernate), you can write Semgrep rules to detect direct SQL queries or any other pattern that deviates from the prescribed ORM usage. This helps enforce consistent coding practices and prevent security vulnerabilities, such as SQL injection.

### ☕ Example: Anti-Patterns

If your Java project uses Hibernate as the ORM, and you want to detect code that executes raw SQL instead of using Hibernate’s query mechanisms, you could write a Semgrep rule like this:

```yaml
rules:
  - id: avoid-native-sql
    patterns:
      - pattern: |
          entityManager.createNativeQuery("$SQL_QUERY")
    message: "Use Hibernate's ORM query methods instead of native SQL queries."
    languages: [java]
    severity: warning
```

This rule identifies places where `createNativeQuery()` is used, ensuring that developers use the ORM correctly and avoid native SQL queries.

## ✔️ Conclusion

As we’ve discussed the importance of identifying dangerous functions in PHP and preventing SQL injection vulnerabilities in Java, these techniques empower developers to proactively address security issues before they can be exploited. Furthermore, integrating Semgrep with GitHub Actions (GHA) allows for seamless automated scanning within your CI/CD pipeline, enhancing your workflow by providing immediate feedback on code quality and security vulnerabilities.

By using `.semgrepignore` and creating custom rules to detect anti-patterns, you can optimize Semgrep to enhance code quality and security. This approach allows you to ignore irrelevant files while identifying deviations from best practices, ensuring efficient scans and relevant findings that foster a more robust software development process.

