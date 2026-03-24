# Terraform Security, Secrets Management & Validation Guide

Terraform manages **real infrastructure**, not just configuration files.

That means it can interact with:

* credentials
* database passwords
* API keys
* certificates
* access tokens

If handled incorrectly, these secrets can leak.

A single exposed `.tfstate` file can compromise your entire cloud environment.

So security must be built into:

* variables
* state storage
* secret management
* validation pipelines

---

# Handling Sensitive Variables in Terraform

Terraform provides a built-in way to mark variables as sensitive.

Example:

```hcl
variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
```

Terraform will:

* hide values in CLI output
* prevent accidental logging
* reduce exposure risk in terminal output

Important limitation:

Secrets are still stored inside the **Terraform state file**

So this feature alone is **not sufficient for production security**.

---

# Secret Management (Best Practice)

Never hardcode secrets inside Terraform code.

Instead, integrate a **secret manager**.

Common options:

---

## HashiCorp Vault

Best when:

* multi-cloud environments
* enterprise infrastructure
* dynamic credentials required

Vault can generate **temporary credentials dynamically**, reducing long-term exposure risk.

Example use cases:

* short-lived AWS credentials
* database dynamic authentication
* rotating secrets automatically

---

## AWS Secrets Manager

Example:

```hcl
data "aws_secretsmanager_secret_version" "db" {
  secret_id = "prod/db-password"
}

locals {
  db_password = jsondecode(
    data.aws_secretsmanager_secret_version.db.secret_string
  )["password"]
}
```

Best for:

* AWS-native deployments
* RDS credential storage
* Lambda secret injection
* automatic credential rotation

---

## Azure Key Vault

Example:

```hcl
data "azurerm_key_vault_secret" "example" {
  name         = "db-password"
  key_vault_id = azurerm_key_vault.main.id
}
```

Best for:

* Azure deployments
* certificate storage
* encryption key lifecycle management
* centralized secret governance

Software reference: Azure Key Vault

---

# Avoid Storing Secrets in Terraform State Files

Terraform state files contain:

* resource IDs
* passwords
* connection strings
* metadata
* infrastructure mappings

If committed to GitHub → security breach risk

---

# Secure Remote Backend Configuration

Recommended production backend setup:

### AWS Example

S3 + DynamoDB backend

Security features:

* encryption enabled
* versioning enabled
* IAM restricted access
* state locking using DynamoDB

Example:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-prod"
    key            = "network/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
```

Benefits:

* prevents concurrent execution conflicts
* protects state from accidental deletion
* ensures secure storage

---

# Terraform Testing & Validation (Shift Left Security)

Before running:

```bash
terraform apply
```

Always validate infrastructure using security tools.

| Tool               | Purpose             |
| ------------------ | ------------------- |
| terraform fmt      | formatting          |
| terraform validate | syntax verification |
| tflint             | linting             |
| checkov            | security scanning   |

---

# terraform fmt (Code Formatting)

Automatically formats Terraform code.

Example:

```bash
terraform fmt
```

Fixes:

* spacing
* indentation
* alignment

Useful inside:

* CI pipelines
* pre-commit hooks
* team repositories

---

# terraform validate (Configuration Validation)

Checks:

* syntax errors
* invalid arguments
* missing providers

Example:

```bash
terraform validate
```

Runs without connecting to the cloud.

Safe and fast validation step.

---

# TFLint (Terraform Linter)

Detects:

* unused variables
* deprecated syntax
* invalid instance types
* provider misconfiguration

Example warning:

```
Warning: aws_instance_invalid_type
```

Recommended for production pipelines.

Software reference: TFLint

---

# Checkov (Infrastructure Security Scanner)

Checkov is a static code analysis tool that scans Infrastructure-as-Code files for security misconfigurations.

Checkov automatically detects:

* open security groups
* public S3 buckets
* unencrypted storage
* IAM wildcard permissions

Example:

```bash
checkov -d .
```

Example finding:

```
CKV_AWS_20: S3 bucket encryption disabled
```

Supports scanning:

* Terraform
* Kubernetes
* CloudFormation
* Docker
* Helm

Powerful tool for implementing **DevSecOps pipelines**

---

# Recommended Secure Terraform Workflow

Production-ready workflow:

```
terraform fmt
terraform validate
tflint
checkov
terraform plan
terraform apply
```

This ensures:

* readable code
* valid syntax
* provider correctness
* security compliance
* safe infrastructure deployment