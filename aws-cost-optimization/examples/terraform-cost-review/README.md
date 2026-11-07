# Terraform Cost Review Sample

A small Terraform project with deliberate cost issues, for trying the AWS Cost Optimization power's cost estimates and cost check hooks. The [AWS CFM TIPs workshop](https://catalog.workshops.aws/awscff/en-US) uses it in its shift-left walkthrough.

> [!IMPORTANT]
> This sample is for cost analysis only. Don't deploy it. The AMI ID is a placeholder.

## What it contains

| Resource | Issues the Terraform cost check hook looks for |
|---|---|
| `aws_instance.app` | Previous-generation `m5.xlarge` instance type, 100 GiB gp2 root volume, no `Schedule` tag |
| `aws_db_instance.app` | Previous-generation `db.m5.large` instance class, 100 GiB of gp2 storage, no deletion protection, Performance Insights not enabled, no `Schedule` tag |

## Try it

1. Download `main.tf` into an empty folder, and open the folder in Kiro:

   ```bash
   curl -O https://raw.githubusercontent.com/venkatakrishna-pullela/vpullela-powers/main/aws-cost-optimization/examples/terraform-cost-review/main.tf
   ```

2. Ask Kiro: "Estimate the monthly cost of the infrastructure in this workspace and list your assumptions"
3. Ask Kiro: "Install the aws-cost-optimization cost check hooks in this workspace", then start a new chat session so the hook loads.
4. Ask Kiro to make a small change, such as "Add an Environment = dev tag to both resources in main.tf". After Kiro saves the file, the Terraform hook asks it to review the file for cost issues.

The hooks review changes that Kiro makes. Edits you make yourself in the editor don't trigger them.
