# rancher-ds-tf

Terraform/OpenTofu configuration for managing Rancher clusters and related resources.

## Overview

This repository contains Terraform modules for provisioning and managing Rancher v2 resources (e.g. RKE2 clusters) using the [Rancher2 provider](https://registry.terraform.io/providers/rancher/rancher2/latest).

**Configuration is done entirely via environment variables**—no secrets or environment-specific values are stored in `terraform.tfvars`.

## Structure

```
rancher-ds-tf/
├── README.md           # This file
└── rancher/            # Rancher cluster module
    ├── provider.tf
    ├── variables.tf
    ├── cluster.tf
    ├── outputs.tf
    ├── versions.tf
    └── terraform.tfvars   # Empty; all vars via env
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) or [OpenTofu](https://opentofu.org/)
- A Rancher server URL and API credentials (access key + secret key)

## Setting variables via environment

All variables are supplied manually as environment variables. Terraform/OpenTofu reads any variable named `VAR_NAME` from the environment when it is set as `TF_VAR_var_name` (lowercase, underscores).

### Required variables (no defaults)

Set these before every run:

```bash
export TF_VAR_rancher_api_url="https://oks01.ci.octostar.com"
export TF_VAR_rancher_access_key="token-xxxxx"
export TF_VAR_rancher_secret_key="your-secret-key"
export TF_VAR_cluster_name="hetzner-rke2"
```

Create API tokens in Rancher: **User & Authentication → API & Keys → Create API Key**. Use the Bearer Token as `rancher_access_key` and the secret as `rancher_secret_key`.

### Optional variables (have defaults)

Override only if you need to change defaults:

```bash
export TF_VAR_kubernetes_version="v1.32.0+rke2r1"
export TF_VAR_cni="canal"
```

### List variable: `tls_san`

For list variables like `tls_san`, set the environment variable to **JSON**:

```bash
export TF_VAR_tls_san='["rke2-01.ci.octostar.com"]'
```

Multiple entries:

```bash
export TF_VAR_tls_san='["rke2-01.ci.octostar.com", "rke2-02.ci.octostar.com"]'
```

### Example: one-time setup

```bash
# Required
export TF_VAR_rancher_api_url="https://oks01.ci.octostar.com"
export TF_VAR_rancher_access_key="token-xxxxx"
export TF_VAR_rancher_secret_key="your-secret-key"
export TF_VAR_cluster_name="hetzner-rke2"

# Optional
export TF_VAR_tls_san='["rke2-01.ci.octostar.com"]'

cd rancher
tofu init
tofu plan
tofu apply
```

### Example: using a `.env` file

Create a file (e.g. `.env`) with your values and add `.env` to `.gitignore` so it is never committed:

```bash
# .env
export TF_VAR_rancher_api_url="https://oks01.ci.octostar.com"
export TF_VAR_rancher_access_key="token-xxxxx"
export TF_VAR_rancher_secret_key="your-secret-key"
export TF_VAR_cluster_name="hetzner-rke2"
export TF_VAR_tls_san='["rke2-01.ci.octostar.com"]'
```

Then:

```bash
source .env
cd rancher
tofu plan
tofu apply
```

## Usage

1. Set the required (and any optional) environment variables as above.
2. From the `rancher` directory:

   ```bash
   cd rancher
   tofu init   # or: terraform init
   tofu plan   # or: terraform plan
   tofu apply  # or: terraform apply
   ```

## Variables reference

| Variable             | Required | Description                    | Example / format        |
|----------------------|----------|--------------------------------|--------------------------|
| `rancher_api_url`    | Yes      | Rancher server URL             | `https://oks01.ci.octostar.com` |
| `rancher_access_key` | Yes      | API token (access key)         | `token-xxxxx`           |
| `rancher_secret_key` | Yes      | API token secret               | (from Rancher UI)        |
| `cluster_name`       | Yes      | Name of the RKE2 cluster       | `hetzner-rke2`          |
| `kubernetes_version` | No       | RKE2 Kubernetes version       | `v1.32.0+rke2r1`        |
| `cni`                | No       | CNI plugin                     | `canal`                 |
| `tls_san`            | No       | TLS SANs for RKE2 (list)       | `["host.example.com"]` (JSON) |

All of the above are set via `TF_VAR_<name>` environment variables (e.g. `TF_VAR_rancher_api_url`). List variables must be valid JSON.

## License

Use and modify as needed for your environment.
