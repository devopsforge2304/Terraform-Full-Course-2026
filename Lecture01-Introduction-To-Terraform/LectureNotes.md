---

# Lecture 1 — Terraform Fundamentals

## Pre-requisites

* Knowledge of at least one cloud platform
* AWS
* Azure
* GCP
* AWS Account
* Terraform installed

---

# What is Terraform?

Terraform is an **open-source Infrastructure as Code (IaC) tool** created by **HashiCorp**.

Terraform allows you to **define, provision, and manage infrastructure using code**.

Instead of manually creating resources from cloud consoles, Terraform lets you define infrastructure in configuration files and automatically creates those resources.

---

# Infrastructure Terraform Can Create

Examples include:

* Virtual Machines
* Networks
* Databases
* Load Balancers
* Storage
* Kubernetes Clusters

---

# Terraform Configuration Language

Terraform uses a declarative language called:

**HCL — HashiCorp Configuration Language**

### Example

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

---

# Terraform Core Principles

Terraform performs three main operations:

1. Builds a **resource dependency graph**
2. Compares **desired state vs current state**
3. Applies changes to reach the **desired state**

---

# How Terraform Works

Terraform uses a **Declarative Model**.

### Declarative means

You describe **WHAT infrastructure should exist**, not **HOW to create it**.

You do NOT write steps like:

```
Step 1: Create VPC
Step 2: Wait
Step 3: Create Subnet
Step 4: Create Instance
```

Instead you declare:

```
I want a VPC
I want a subnet inside the VPC
I want an instance in the subnet
```

Terraform automatically determines the correct order.

---

# Declarative vs Imperative

## Imperative Model

```
Script
Step1 → Step2 → Step3 → Step4
```

Examples of imperative tools:

* Bash scripts
* Ansible tasks
* Cloud CLI scripts

---

## Declarative Model (Terraform)

```
Desired State
      ↓
Terraform Engine
      ↓
Execution Plan
      ↓
Infrastructure
```

---

# Terraform Execution Flow

Terraform works in **three phases**:

```
Write Code → Plan → Apply
```

---

# Terraform Internal Workflow

```
Terraform Configuration (HCL)
        ↓
Parse Configuration
        ↓
Build Resource Dependency Graph
        ↓
Compare Desired State vs Current State
        ↓
Generate Execution Plan
        ↓
Provider Plugins Call Cloud APIs
        ↓
Infrastructure Created
```

---

# Terraform API Communication

Terraform interacts with cloud providers using APIs.

```
Terraform
   ↓
Provider Plugin
   ↓
Cloud API
   ↓
Infrastructure Created
```

---

# Terraform Internal Architecture

```
Terraform Code
     │
     ▼
Terraform Core (Parser + Graph Engine)
     │
     ▼
AWS Provider Plugin
     │
     ▼
AWS REST API
https://ec2.amazonaws.com
     │
     ▼
AWS Infrastructure
```

---

# Terraform Dependency Graph

Terraform internally converts configuration into a **Directed Acyclic Graph (DAG)**.

---

# Why DAG is Important

Terraform must ensure:

* Dependencies are respected
* Resources run in the correct order
* Maximum parallel execution

---

# Example Dependency Graph

```
aws_vpc.main
     │
     ▼
aws_subnet.app
     │
     ▼
aws_instance.web
```

Terraform understands:

* VPC must be created first
* Subnet depends on VPC
* Instance depends on Subnet

---

# Parallel Execution Example

If resources do not depend on each other, Terraform creates them **in parallel**.

```
        Terraform
       /    |    \
      ▼     ▼     ▼
     VPC   IAM   S3
```

This parallel execution makes Terraform **very fast**.

---

# Terraform Internal Processing Flow

```
Step 1
Parse .tf files

Step 2
Build dependency graph

Step 3
Read state file

Step 4
Compare desired vs current state

Step 5
Generate execution plan

Step 6
Send actions to provider

Step 7
Provider calls cloud API

Step 8
Infrastructure created
```

---

# Why We Use Terraform

Terraform solves many infrastructure challenges.

---

## 1. Infrastructure Automation

Without Terraform:

* Login to console
* Create VPC
* Create subnet
* Create instance
* Configure networking

Manual processes are **slow and error-prone**.

With Terraform everything is **automated**.

---

## 2. Infrastructure Consistency

Without IaC environments drift.

Example:

```
Dev → different configuration
Staging → different configuration
Production → different configuration
```

With Terraform:

```
Same Code → Same Infrastructure
```

---

## 3. Version Control

Terraform code can be stored in **Git repositories**.

Benefits:

* Track infrastructure changes
* Audit infrastructure
* Rollback mistakes

---

## 4. Reproducibility

Infrastructure can be recreated anytime.

Example:

```
Delete infrastructure
Run terraform apply
Infrastructure recreated exactly the same
```

---

## 5. Scalability

Terraform can easily scale infrastructure.

Example:

```hcl
resource "aws_instance" "web" {
  count = 10
}
```

Terraform automatically creates **10 servers**.

---

## 6. Multi-Cloud Management

Terraform supports multiple cloud providers.

Example:

```
AWS → compute
Azure → storage
GCP → analytics
```

All managed using **one tool**.

---

## 7. Dependency Management

Terraform automatically handles resource dependencies.

```
VPC
 ↓
Subnet
 ↓
EC2 Instance
```

---

## 8. Cost Optimization

Terraform helps control costs.

Example:

Destroy unused infrastructure.

```bash
terraform destroy
```

---

# When We Use Terraform

## Real World Use Cases

---

## 1. Cloud Infrastructure Provisioning

Terraform is widely used for deploying:

* AWS infrastructure
* Azure infrastructure
* GCP infrastructure

---

## 2. DevOps Automation

Terraform is commonly used in DevOps pipelines.

Example pipeline:

```
Code Commit
     ↓
Build Application
     ↓
Provision Infrastructure
     ↓
Deploy Application
```

---

## 3. Multi-Environment Setup

Companies maintain multiple environments:

* Development
* Staging
* Production

Terraform ensures **consistent infrastructure across environments**.

---

## 4. Disaster Recovery

Infrastructure can be recreated quickly.

Example:

```
Region failure
      ↓
Run Terraform
      ↓
Infrastructure recreated in another region
```

---

## 5. Large Scale Infrastructure

Large companies manage thousands of resources such as:

* Networks
* Databases
* Servers
* Kubernetes clusters
* Security policies

Terraform simplifies managing them.

---

## 6. Platform Engineering

Platform teams use Terraform to build **internal platforms**.

Example:

```
Developers request infrastructure
        ↓
Terraform provisions it automatically
```

---

## 7. Infrastructure Standardization

Terraform allows creation of **reusable modules**.

Example modules:

* VPC module
* EKS module
* Database module
* Security module

Teams reuse modules across projects.

---
