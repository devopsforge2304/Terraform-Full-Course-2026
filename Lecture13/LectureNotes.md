# Debugging & Troubleshooting Terraform Issues

When working with Terraform, errors are normal and expected. What makes an engineer advanced is the ability to debug them quickly and safely.

This guide covers:

* Enable debug logs
* Investigate provider errors
* Resolve state conflicts
* Recover from failed applies
* Real-world debugging workflow

---

# 1. Enable Debug Logs in Terraform

Terraform provides internal logs that show what is happening behind the scenes.

Use:

```bash
TF_LOG=DEBUG terraform apply
```

This enables verbose logging.

## Log Levels Available

| Level | Purpose                    |
| ----- | -------------------------- |
| TRACE | Most detailed logs         |
| DEBUG | Useful for troubleshooting |
| INFO  | General execution info     |
| WARN  | Warnings                   |
| ERROR | Errors only                |

Example:

```bash
TF_LOG=TRACE terraform plan
```

To store logs in a file:

```bash
TF_LOG=DEBUG TF_LOG_PATH=terraform.log terraform apply
```

Logs will be saved inside:

```
terraform.log
```

**Best Practice**

Use `DEBUG` normally and `TRACE` only for deep investigation.

---

# 2. Investigate Provider Errors

Provider errors occur when Terraform cannot communicate properly with AWS, Azure, or GCP.

Example error:

```
Error: UnauthorizedOperation
```

Possible reasons:

* Wrong credentials
* Expired tokens
* Missing IAM permissions
* Incorrect provider configuration

Example provider configuration:

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

Verify credentials:

```bash
aws configure
```

Or check environment variables:

```bash
echo $AWS_ACCESS_KEY_ID
```

**Pro Tip**

Always confirm provider authentication before debugging Terraform code.

---

# 3. Resolve State Conflicts

Terraform state keeps track of infrastructure.

Conflicts may occur due to:

* Manual resource changes
* Parallel Terraform execution
* Corrupted state
* Deleted resources outside Terraform

Example error:

```
Error locking state
```

Solution:

Force unlock state:

```bash
terraform force-unlock LOCK_ID
```

Refresh state:

```bash
terraform refresh
```

**Best Practice**

Never manually edit the state file unless absolutely necessary.

---

# 4. Recover from Failed Terraform Apply

Sometimes `terraform apply` stops midway. In such cases, infrastructure may be partially created.

## Step 1 — Run Plan Again

Terraform detects missing resources automatically.

```bash
terraform plan
```

---

## Step 2 — Apply Again

```bash
terraform apply
```

Terraform resumes safely from the last successful state.

---

## Step 3 — If Resource Exists Outside Terraform

Import it into state:

```bash
terraform import aws_instance.example i-abc123
```

---

## Step 4 — If State Is Corrupted

Pull state:

```bash
terraform state pull
```

Push corrected state:

```bash
terraform state push terraform.tfstate
```

---

# Real-World Debugging Workflow (Recommended)

Follow this order when errors occur:

1. Read the error message carefully
2. Run validation

```bash
terraform validate
```

3. Run execution plan

```bash
terraform plan
```

4. Enable debug logs
5. Check provider authentication
6. Inspect Terraform state

This workflow solves most Terraform issues quickly and safely.
