# Terraform AWS EKS Cluster

Provision a production-ready Amazon EKS cluster and networking infrastructure on AWS using reusable Terraform modules.

This project follows a modular Infrastructure as Code (IaC) approach by separating the networking and Kubernetes infrastructure into independent Terraform modules. It creates a highly available VPC across two Availability Zones and deploys an Amazon EKS cluster with managed worker nodes in private subnets.

---

## Architecture

<img width="1536" height="1024" alt="eks" src="https://github.com/user-attachments/assets/7943c2da-41c0-4178-841f-890fc99c9c30" />

---

# Features

- Modular Terraform design
- Production-style folder structure
- Multi-AZ VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway for outbound internet access
- Amazon EKS Cluster
- EKS Managed Node Group
- Configurable node groups
- Configurable Kubernetes version
- Outputs for cluster endpoint and VPC resources
- Easily reusable modules

---

# Repository Structure

```
terraform-aws-eks-cluster
│
├── main.tf
├── variables.tf
├── outputs.tf
│
└── modules
    ├── eks
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── vpc
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

# Modules

## VPC Module

Creates:

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateways
- Route Tables
- Route Table Associations

Outputs

- VPC ID
- Public Subnet IDs
- Private Subnet IDs

---

## EKS Module

Creates:

- Amazon EKS Cluster
- IAM Roles
- Security Groups
- Managed Node Group

Outputs

- Cluster Name
- Cluster Endpoint

---

# Prerequisites

Before deploying ensure you have:

- AWS Account
- AWS CLI configured
- Terraform >= 1.x
- Appropriate IAM permissions
- kubectl (optional for cluster access)

---

# Input Variables

| Variable | Description | Default |
|----------|-------------|---------|
| region | AWS Region | us-east-1 |
| vpc_cidr | VPC CIDR Block | 10.0.0.0/16 |
| availability_zones | Availability Zones | us-east-1a, us-east-1b |
| private_subnet_cidrs | Private Subnets | 10.0.1.0/24, 10.0.2.0/24 |
| public_subnet_cidrs | Public Subnets | 10.0.4.0/24, 10.0.5.0/24 |
| cluster_name | EKS Cluster Name | my-eks-cluster |
| cluster_version | Kubernetes Version | 1.36 |
| node_groups | Managed Node Group Configuration | See variables.tf |

---

# Default Node Group

```hcl
general = {
  instance_types = ["t3.large"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 28

  scaling_config = {
    desired_size = 4
    min_size     = 1
    max_size     = 4
  }
}
```

---

# Outputs

After deployment Terraform returns:

| Output | Description |
|---------|-------------|
| cluster_name | Name of EKS Cluster |
| cluster_endpoint | Kubernetes API Endpoint |
| vpc_id | ID of the created VPC |

---

# Deployment

Initialize Terraform

```bash
terraform init
```

Review execution plan

```bash
terraform plan
```

Deploy infrastructure

```bash
terraform apply
```

Destroy infrastructure

```bash
terraform destroy
```

---

# Customization

Modify the following variables according to your environment.

- AWS Region
- VPC CIDR
- Availability Zones
- Kubernetes Version
- Node Group Size
- Instance Types
- Disk Size

---

# Example

```hcl
module "eks" {
  source = "./modules/eks"

  cluster_name    = "production"
  cluster_version = "1.36"

  subnet_ids = module.vpc.private_subnet_ids
  vpc_id     = module.vpc.vpc_id

  node_groups = {
    general = {
      instance_types = ["t3.large"]
      capacity_type  = "ON_DEMAND"
      disk_size      = 30

      scaling_config = {
        desired_size = 3
        min_size     = 2
        max_size     = 5
      }
    }
  }
}
```

---

# Author

**Humayun Ch**

AWS | Terraform | Kubernetes | DevOps

---
