# AWS Cost Optimization Power for Kiro

> Intelligent AWS cost management integrated into your development workflow

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Kiro Power](https://img.shields.io/badge/Kiro-Power-purple.svg)](https://kiro.dev/powers/)

## Overview

The AWS Cost Optimization Power transforms how teams manage cloud spending by bringing intelligent cost analysis, real-time pricing insights, and automated recommendations directly into your development environment. Whether you're a FinOps professional managing budgets, a developer building cost-aware applications, or an architect designing efficient infrastructure, this power provides the tools and guidance you need—all through natural language.

## Why This Power?

**Stop context switching.** Instead of juggling multiple AWS consoles and learning different APIs, query costs, analyze spending patterns, get optimization recommendations, and model infrastructure costs—all within Kiro.

**Built on AWS best practices.** Implements the AWS Well-Architected Cost Optimization Pillar's five design principles, helping you turn cost optimization from a reactive process into a proactive development practice.

**Three powerful integrations.** Combines AWS Cost Explorer, AWS Pricing API, and CloudWatch into a unified, intelligent interface.

## Key Capabilities

### For Business & FinOps Teams

- **Cloud Financial Management** - Implement cost governance, monitor budgets, and establish accountability frameworks
- **Cost Analysis & Forecasting** - Historical analysis, multi-dimensional breakdowns, and trend identification
- **Optimization & Governance** - Automated rightsizing, RI/SP analysis, and anomaly detection

### For Developers & Engineering Teams

- **Pre-Deployment Cost Analysis** - Model CDK and Terraform projects before deployment
- **Development Environment Optimization** - Analyze dev/test costs and monitor Free Tier usage
- **Cost-Aware Development** - Real-time pricing intelligence for architecture decisions

## Quick Start

### Prerequisites

1. **AWS CLI** (v2.32.0+) - [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
2. **UV** (Python package manager) - [Installation Guide](https://docs.astral.sh/uv/getting-started/installation/)
3. **AWS Credentials** - Configured via `aws configure` or environment variables

### Installation

1. Install the power in Kiro
2. Ensure AWS credentials are configured
3. Start using natural language commands

### Try These Commands

**For FinOps Teams:**
```
"Show me our AWS costs for the last 3 months by business unit"
"Find cost optimization opportunities across our organization"
"Find resources I'm still paying for but not using"
"Compare our costs between last quarter and this quarter"
```

**For Developers:**
```
"Provide cost estimates for this CDK stack before deployment"
"Compare Lambda vs ECS costs for my microservice"
"Show me pricing differences between us-east-1 and eu-west-1"
```

## What's Included

### MCP Servers

- **awslabs.billing-cost-management-mcp-server** - Cost analysis, budget monitoring, and optimization recommendations
- **awslabs.aws-pricing-mcp-server** - Real-time pricing intelligence and cost modeling
- **awslabs.cloudwatch-mcp-server** - Metrics monitoring and operational insights

### Comprehensive Guidance

- **5 Core Workflow Guides** - Aligned with AWS Well-Architected principles
- **20+ Service-Specific Guides** - Detailed optimization strategies for EC2, S3, Lambda, RDS, and more
- **Tool Selection Guide** - Query-to-tool mapping for efficient navigation
- **Unused Resource Review** - A read-only review of resources that keep billing after their work is done, such as unattached volumes, idle Elastic IP addresses, quiet NAT gateways, old snapshots, and log groups that never expire
- **CFM TIPs Links** - Recommendations link to the matching step-by-step playbook in the [AWS CFM TIPs workshop](https://catalog.workshops.aws/awscff/en-US)
- **Best Practices** - Do's and don'ts for effective cost optimization

## Documentation

Full documentation is available in the [POWER.md](POWER.md) file, including:

- Detailed tool reference and usage examples
- Onboarding and setup instructions
- Workflow guides for business and development teams
- Service-specific optimization strategies
- Troubleshooting and best practices

## Use Cases

### Cost Analysis
- Historical cost trends and forecasting
- Multi-dimensional cost breakdowns
- Month-over-month variance analysis

### Optimization
- Automated rightsizing recommendations
- Reserved Instance and Savings Plans analysis
- Cost anomaly detection
- Idle and forgotten resource reviews, with a CFM TIPs cleanup page for each finding

### Architecture Planning
- Pre-deployment cost modeling
- Service pricing comparisons
- Regional cost analysis

### Development Efficiency
- Free Tier monitoring
- Development environment optimization
- Cost-aware architecture patterns

## Requirements

### AWS Permissions

The power only needs read access. Give its AWS user or role read-only permissions for:
- Cost Explorer, AWS Budgets, Cost Optimization Hub, AWS Compute Optimizer, Savings Plans, and Free Tier
- The AWS Price List API (`pricing:*`, which is read-only)
- CloudWatch metrics and alarms, and CloudWatch Logs (including Logs Insights queries)

The [read-only IAM policy in POWER.md](POWER.md#step-3-configure-billing-and-monitoring-permissions) lists the exact actions. Use a member account to analyze one account, or the management account for consolidated billing data across an organization.

### AWS Services

- Cost Explorer must be enabled (24-hour data delay for new accounts)
- CloudWatch for operational metrics
- Organizations (optional, for multi-account analysis)

## Hooks

This power includes agent hooks that automatically review your infrastructure code for cost issues whenever Kiro edits a matching file, including code that Kiro changes for you. No manual prompting needed.

Kiro's file hooks respond only to changes the agent makes, so edits you make yourself in the editor don't trigger them (see [Kiro hook types](https://kiro.dev/docs/hooks/types/)). To review a file you edited yourself, ask Kiro to review it.

To try the hooks, use the [Terraform cost review sample](examples/terraform-cost-review/).

### Available Hooks

| Hook | Trigger | Default files matched |
|------|---------|---------------|
| **CloudFormation Cost Check on Save** | `PostFileSave` | `.yaml` and `.yml` files under `templates/`, `cloudformation/`, `lib/`, or `stacks/` |
| **Terraform Cost Check on Save** | `PostFileSave` | Any `.tf` file |
| **CDK Cost Check on Save** | `PostFileSave` | `.ts`, `.py`, and `.java` files under `lib/` or `stacks/` |

### What They Check

**CloudFormation** — gp2 storage, `db.t` instance families, missing `DeletionPolicy`/`UpdateReplacePolicy` on stateful resources, missing `Schedule` tags on RDS/EC2, and other issues from the cost optimization steering guide.

**Terraform** — previous-generation instance types, gp2 EBS volumes instead of gp3, missing `deletion_protection`, over-provisioned IOPS, missing `performance_insights_enabled` on RDS.

**CDK** — `EbsDeviceVolumeType.GP2` instead of GP3, `db.t` instance families in production, missing `removalPolicy` on stateful constructs, over-provisioned Lambda memory, missing `enablePerformanceInsights` on RDS.

### Installation

Hooks are resolved per workspace from `.kiro/hooks/`, so installing the power does not activate them. Ask the agent to install them:

> "Install the aws-cost-optimization cost check hooks in this workspace"

The agent reads the definitions from the power's `steering/install-hooks.md` guide, installs only the hooks matching the infrastructure-as-code present in your workspace, and adapts each hook's `matcher` to your layout. Each hook is a v1 hook file in `.kiro/hooks/`, the format Kiro IDE 1.0 and Kiro CLI V3 load. Start a new session after installing so the hooks load. To test a hook, ask Kiro to make a small change to a matching file, such as adding a tag.

If you installed the hooks before this format change, your workspace may still have `.kiro/hooks/*-cost-check-on-save.kiro.hook` files, which Kiro IDE 1.0 shows as legacy hooks. Delete them after installing the new ones so each review runs once.

### Customizing File Patterns

The CDK hook defaults to `lib/` and `stacks/` — the conventional CDK directory names. If your project uses a different structure (e.g. `src/` or `infrastructure/`), the agent adapts the matcher during installation. You can also edit the `matcher` regular expression afterwards in `.kiro/hooks/cdk-cost-check-on-save.json`:

```json
"matcher": "(^|/)(src|infrastructure)/.+\\.ts$"
```

## Contributing

This power is maintained by Venkat Pullela. For issues, suggestions, or contributions, please open an issue in the repository.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

Built with AWS Labs MCP servers:
- [billing-cost-management-mcp-server](https://awslabs.github.io/mcp/servers/billing-cost-management-mcp-server)
- [aws-pricing-mcp-server](https://awslabs.github.io/mcp/servers/aws-pricing-mcp-server)
- [cloudwatch-mcp-server](https://awslabs.github.io/mcp/servers/cloudwatch-mcp-server)

## Learn More

- [AWS Cost Optimization Best Practices](https://aws.amazon.com/pricing/cost-optimization/)
- [AWS Well-Architected Framework - Cost Optimization Pillar](https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/welcome.html)
- [AWS CFM TIPs Workshop](https://catalog.workshops.aws/awscff/en-US) - Step-by-step Cloud Financial Management implementation playbooks
- [Kiro Powers Documentation](https://kiro.dev/powers/)

---

**Ready to optimize your AWS costs?** Install the power and start with: `"Show me my monthly AWS costs"`
