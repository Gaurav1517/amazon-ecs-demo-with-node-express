# Secure Node.js Application on AWS ECS Fargate

This repository demonstrates a production-grade, highly secure, and automated deployment of a Node.js/Express application on AWS ECS Fargate. The entire infrastructure is managed as Code (IaC) using Terraform, following DevSecOps best practices.

## 🏗️ Architecture

The infrastructure is designed with security, scalability, and high availability in mind.

```mermaid
architecture-beta
    group aws(cloud)[AWS Cloud]
    
    service user(internet)[User Traffic]
    
    group edge(cloud)[Edge Network] in aws
    service cf(server)[Amazon CloudFront] in edge
    service waf(server)[AWS WAF] in edge
    
    group vpc(cloud)[Amazon VPC] in aws
    
    group pub(cloud)[Public Subnets] in vpc
    service alb(server)[App Load Balancer] in pub
    
    group priv(cloud)[Private Subnets] in vpc
    service ecs(server)[ECS Fargate Cluster] in priv
    
    group sec(cloud)[Security & Config] in aws
    service ssm(server)[SSM Parameter Store] in sec
    service sm(server)[AWS Secrets Manager] in sec
    
    user:R --> L:cf
    cf:B --> T:alb
    alb:B --> T:ecs
    ecs:R --> L:sm
    ecs:R --> L:ssm
    waf:R --> L:cf
```

### Key Architectural Decisions

1. **Infrastructure as Code (IaC)**: The complete environment is provisioned dynamically using modular Terraform, ensuring repeatable and drift-resistant environments.
2. **Security at the Edge**: **AWS WAF** is attached to **Amazon CloudFront**, filtering out malicious traffic, SQL injection, and DDoS attacks before they ever reach the application.
3. **Private Compute**: The **ECS Fargate** tasks run exclusively in **Private Subnets**. They are completely inaccessible from the public internet. The only way to access the application is through the Application Load Balancer (ALB) in the public subnets.
4. **Serverless Compute**: **AWS Fargate** eliminates the need to manage, patch, or secure underlying EC2 instances.
5. **Zero-Downtime Deployments**: Configured ECS Rolling Updates ensure that new application versions are fully health-checked by the ALB before old versions are terminated.
6. **Dynamic Autoscaling**: Target Tracking Scaling Policies are attached to the ECS Service to dynamically scale the container count in response to CPU and Memory utilization.

## 🔒 DevSecOps Implementations

This project implements several critical DevSecOps patterns to ensure the highest level of security:

### 1. Keyless CI/CD via AWS OIDC
We completely eliminated the use of long-lived, static IAM Access Keys. GitHub Actions communicates with AWS using **OpenID Connect (OIDC)**. The pipeline requests short-lived, temporary session credentials dynamically to perform deployments.

### 2. Distroless Container Images
The application Dockerfile (`Dockerfile-prod`) utilizes Google's `distroless` base images (`gcr.io/distroless/nodejs20-debian12`). This severely reduces the container's attack surface by stripping out package managers, shells (no `/bin/sh`), and other unnecessary OS utilities that attackers typically rely on.

### 3. Secure Secrets Management
No secrets are hardcoded in the codebase, Docker images, or Terraform files.
- **Environment Configuration**: Non-sensitive settings (like `APP_PORT`) are stored in **AWS Systems Manager (SSM) Parameter Store**.
- **Sensitive Secrets**: Passwords and API keys are stored encrypted in **AWS Secrets Manager**.
Both are seamlessly injected into the ECS containers at runtime via the ECS Task Definition `secrets` configuration.

## 🚀 Deployment Guide

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS CLI installed and authenticated
- A registered Domain Name (managed in AWS Route53)

### 1. Provision Infrastructure
1. Navigate to the `terraform` directory: `cd terraform`
2. Initialize Terraform: `terraform init`
3. Copy the variables template: `cp terraform.tfvars.example terraform.tfvars`
4. Fill in your `terraform.tfvars` with your specific AWS, GitHub, and domain information.
5. Apply the infrastructure: `terraform apply`

### 2. CI/CD Pipeline
Once the infrastructure is up, any push to the `main` branch will automatically trigger the GitHub Actions workflow (`.github/workflows/deploy.yml`). 
1. It authenticates with AWS via OIDC.
2. Builds the Distroless Docker image.
3. Pushes the image to Amazon ECR.
4. Registers a new ECS Task Definition and updates the ECS Service.

## 💻 Local Development

For local development, you can use a standard `.env` file. 

1. Install dependencies: `npm install` inside the `sample-nodejs-app` directory.
2. Copy `.env.example` to `.env` (ensure it is git-ignored).
3. Start the application: `node app.js`.

*Note: The `.env` file is STRICTLY for local development. Production deployments rely entirely on AWS Secrets Manager.*