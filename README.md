# AWS Cost Optimization Power for Kiro

> Intelligent AWS cost management integrated into your development workflow

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](aws-cost-optimization/LICENSE)
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
- **Best Practices** - Do's and don'ts for effective cost optimization

## Documentation

Full documentation is available in the [POWER.md](aws-cost-optimization/POWER.md) file, including:

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

Your AWS user/role needs permissions for:
- Cost Explorer (`ce:*`)
- Budgets (`budgets:*`)
- Pricing (`pricing:*`)
- CloudWatch (`cloudwatch:*`, `logs:*`)
- Organizations (for consolidated billing)

### AWS Services

- Cost Explorer must be enabled (24-hour data delay for new accounts)
- CloudWatch for operational metrics
- Organizations (optional, for multi-account analysis)

## Contributing

This power is maintained by Venkat Pullela. For issues, suggestions, or contributions, please open an issue in the repository.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](aws-cost-optimization/LICENSE) file for details.

## Acknowledgments

Built with AWS Labs MCP servers:
- [billing-cost-management-mcp-server](https://awslabs.github.io/mcp/servers/billing-cost-management-mcp-server/)
- [aws-pricing-mcp-server](https://awslabs.github.io/mcp/servers/aws-pricing-mcp-server/)
- [cloudwatch-mcp-server](https://awslabs.github.io/mcp/servers/cloudwatch-mcp-server/)

## Learn More

- [AWS Cost Optimization Best Practices](https://aws.amazon.com/pricing/cost-optimization/)
- [AWS Well-Architected Framework - Cost Optimization Pillar](https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/welcome.html)
- [Kiro Powers Documentation](https://kiro.dev/powers/)

---

**Ready to optimize your AWS costs?** Install the power and start with: `"Show me my monthly AWS costs"`
