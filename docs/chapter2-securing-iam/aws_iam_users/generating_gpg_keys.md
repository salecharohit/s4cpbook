---
sidebar_position: 2
---

# 2.4.2 Generating GPG Keys

As stated earlier, we'll be allowing users to setup their AWS Access keys only through Terraform. However, the Access Key ID and Access Key Secret must not be stored in clear-text in our Terraform state file and also cannot be shared with the user in clear-text format.

For that purpose, terraform allows us to share a public GPG key using which the AWS Secret Access Key is encrypted using the public GPG key. The base64 encoded and GPG encrypted key is then shared with the user, who is the only one who can decrypt the encrypted string and obtain the key.

Hence, the user must first share their public key and through the below steps we are generating the GPG key pair containing both the public and private key. Ideally this step must be performed by each user on their respective machines and keep the private key safe.

## Preparing the Code

Preparing the code for creating AWS IAM Users.

```bash
cd ~/playground
cp -r ~/s4cpcode/chapter2/2D/. .
```

### Generating GPG Keys for Goku

```bash
gpg --generate-key
prompt> Real name: gokuu
prompt> Email address: goku@terraform.s4cp
prompt> Change (N)ame, (E)mail, or (O)kay/(Q)uit?: O
prompt> Enter passphrase
prompt> Re-enter passphrase
```

### Step 1D : Generating GPG Keys for Vegeta

```bash
gpg --generate-key
prompt> Real name: vegeta
prompt> Email address: vegeta@terraform.s4cp
prompt> Change (N)ame, (E)mail, or (O)kay/(Q)uit?: O
prompt> Enter passphrase
prompt> Re-enter passphrase
```
