## deployment.md file. 

You are acting as a senior AWS DevOps engineer and solution architect.

We need to deploy this Node.js/Express application to AWS ECS Fargate.

First, inspect the repository and read `DEPLOYMENT.md` completely.

Do NOT deploy anything yet.

Your first task is to:

1. Analyze the existing application and Dockerfile.
2. Identify anything outdated or unsuitable for production.
3. Design the ECS Fargate architecture described in `DEPLOYMENT.md`.
4. Create a detailed implementation plan.
5. Identify all files you intend to create or modify.
6. Explain security, networking, IAM, cost, availability, and operational considerations.
7. Stop and wait for my approval before running `terraform apply`, deploying to AWS, or making destructive changes.

Use current AWS best practices and verify AWS-specific details against current AWS documentation when necessary.

Do not blindly follow the old ECS instructions in the sample repository.

### Then work with Antigravity in phases

I would use **4 stages**.

**Stage 1 — Analyze**

Give it the short prompt above.

You want it to produce something like:

```text
Application analysis
        ↓
Dockerfile assessment
        ↓
AWS architecture
        ↓
Terraform plan
        ↓
Files to create/change
```

**Do not let it deploy yet.**

---

**Stage 2 — Implement**

Once you review its plan, tell it:

The architecture and implementation plan are approved.

Now implement the solution.

Create/update the required Docker, Terraform, ECS, IAM, CloudWatch, and CI/CD files according to `DEPLOYMENT.md`.

Before making changes:

* show me the files you will create/modify
* do not delete existing application functionality
* do not hard-code credentials or secrets
* do not use `latest` for the production Docker image
* use ECS Fargate, not ECS EC2
* keep ECS tasks in private subnets
* use an ALB in public subnets
* use least-privilege IAM
* use immutable container image tags
* make infrastructure configurable through Terraform variables

After implementation, run local/static validation such as Docker build, Terraform formatting, Terraform validation, and security checks where available.

Do NOT run `terraform apply` or deploy anything to AWS yet.

---

**Stage 3 — Review**

This is an important step. Before allowing an AI agent to touch your AWS account, ask:

Perform a production-readiness review of everything you have implemented.

Do not deploy anything.

Review:

* Terraform security
* IAM permissions
* security groups
* public/private subnet design
* NAT Gateway configuration
* ECS task definition
* ECS execution role
* ECS task role
* container security
* Docker image
* ECR configuration
* ALB configuration
* health checks
* HTTPS/TLS
* CloudWatch logging
* autoscaling
* ECS deployment strategy
* GitHub Actions/OIDC
* secrets management
* cost
* high availability
* rollback strategy

Look specifically for:

* overly permissive IAM
* public ECS tasks
* open security groups
* hard-coded secrets
* hard-coded account IDs
* use of `latest`
* unnecessary AWS resources
* unnecessary permissions
* production availability risks
* expensive configuration that isn't justified

Give me a list of issues found and the recommended fixes.

Do not apply infrastructure.

---

### Stage 4 — Deploy

**Only after you have reviewed the Terraform and configuration**, give Antigravity permission to deploy.

I would make this very explicit:

The implementation has been reviewed and is approved for deployment.

Now deploy the application to AWS ECS Fargate.

Before applying:

1. Verify the active AWS account and region.
2. Run `aws sts get-caller-identity`.
3. Show me the AWS account ID and region you are targeting.
4. Run `terraform plan`.
5. Summarize exactly what AWS resources will be created/changed.
6. Do not destroy existing resources unless I explicitly approve it.

After verification, proceed with the deployment.

After deployment, verify:

* ECR image
* ECS cluster
* ECS service
* running task count
* task health
* ALB target health
* security groups
* CloudWatch logs
* application health endpoint
* ALB endpoint
* HTTPS if configured

If anything fails, stop and diagnose the problem rather than repeatedly applying Terraform blindly.

At the end, provide:

* ECS cluster name
* ECS service name
* ECR repository
* ALB DNS name
* application URL
* deployed image tag
* running task count
* health status
* important AWS resources created
* estimated ongoing monthly cost
* rollback procedure

### One more thing: don't let it blindly create everything

For your first deployment, I strongly recommend this sequence:

```text
                     YOUR REPO
                         │
                         ▼
                ┌─────────────────┐
                │   Antigravity   │
                └────────┬────────┘
                         │
                  1. Analyze
                         │
                         ▼
                 2. Create plan
                         │
                         ▼
                  3. Implement
                         │
                         ▼
                 4. Validate
                         │
                         ▼
                  5. Review
                         │
                         ▼
                  6. Terraform plan
                         │
                         ▼
                ┌─────────────────┐
                │   YOU APPROVE   │
                └────────┬────────┘
                         │
                         ▼
                  7. terraform apply
                         │
                         ▼
                    AWS VPC
                       │
              ┌────────┴────────┐
              ▼                 ▼
          ALB (public)     NAT Gateway
              │                 │
              ▼                 │
       ECS Fargate             │
       private subnet ◄────────┘
              │
              ▼
             ECR
```

### Where should `DEPLOYMENT.md` go?

Put it here:

```text
amazon-ecs-demo-with-node-express/
│
├── DEPLOYMENT.md          ← your detailed instructions
├── README.md
├── sample-nodejs-app/
│   ├── Dockerfile
│   ├── package.json
│   └── ...
│
└── terraform/             ← Antigravity creates this
```

This is better than repeatedly pasting a huge prompt because Antigravity can treat `DEPLOYMENT.md` as the **deployment specification** and the short prompts as **instructions for what phase it should perform**.

### My recommendation for you

Since you're specifically trying to get this application running on **AWS ECS Fargate**, I would **not start by asking Antigravity to deploy**.

Start with:

> **Analyze → Plan → Implement → Validate → Review → Deploy**

That gives you a much better chance of catching an incorrect VPC, overly permissive IAM, public Fargate tasks, bad health checks, obsolete Node image, or an accidental `terraform destroy` before anything important happens.

