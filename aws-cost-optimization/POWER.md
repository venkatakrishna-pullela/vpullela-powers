---
name: "aws-cost-optimization"
displayName: "AWS Cost Optimization"
description: "AWS cost optimization tools for business teams and developers. Analyze spending, get optimization recommendations, and build cost-aware applications with AWS Well-Architected best practices."
keywords: ["finops", "cost-optimization", "aws-billing", "cost-analysis", "budget-management", "rightsizing", "cost-intelligence", "savings-plans", "reserved-instances", "cost-anomaly", "spend-analysis", "cost-forecasting", "resource-optimization", "well-architected", "cloud-financial-management", "consumption-model", "efficiency-measurement", "expenditure-analysis", "developer-cost-optimization", "pre-deployment-analysis", "architecture-cost-modeling", "development-environment-optimization", "cost-aware-development", "cfm-tips"]
author: "Venkat Pullela"
---

# AWS Cost Optimization Power

AWS cost optimization tools for business teams and developers. Analyze spending, get optimization recommendations, and build cost-aware applications with AWS Well-Architected best practices.

## Introduction

Kiro Powers extend your AI development environment with specialized capabilities for specific domains and workflows. This AWS Cost Optimization Power brings together multiple AWS cost management services into a unified, intelligent interface that helps you understand, optimize, and control your cloud spending.

Whether you're a FinOps professional managing organizational budgets, a developer building cost-aware applications, or an architect designing efficient infrastructure, this power provides the tools and guidance you need. Instead of switching between multiple AWS consoles and learning different APIs, you can use natural language to query costs, analyze spending patterns, get optimization recommendations, and model infrastructure costs - all within your development workflow.

The power integrates three AWS Labs MCP servers to provide:
- **Real-time cost analysis** from AWS Cost Explorer and Billing APIs
- **Pricing intelligence** for architecture decisions and cost modeling  
- **Operational insights** from CloudWatch for performance-cost correlation

Built around the AWS Well-Architected Cost Optimization Pillar's five design principles, this power helps you implement cloud financial management, adopt consumption models, measure efficiency, leverage managed services, and analyze expenditure attribution - turning cost optimization from a reactive process into a proactive development practice.

## Table of Contents

- [What Can You Do?](#what-can-you-do) - Core capabilities for business and development teams
- [Quick Start](#quick-start) - Ready-to-use examples to get started immediately
- [Available MCP Servers](#available-mcp-servers) - Technical overview of integrated services
- [Available Tools](#available-tools) - Complete tool reference by category
- [Onboarding](#onboarding) - Setup instructions and prerequisites
- [Tool Usage Examples](#tool-usage-examples) - Detailed code examples for each tool
- [Tool Selection & Navigation Guide](#tool-selection--navigation-guide) - Query-to-tool mapping
- [Workflows & Guidance](#workflows--guidance) - Best practices and service-specific guides
- [Best Practices](#best-practices) - Do's and don'ts for effective cost optimization
- [Legal and Compliance Information](#legal-and-compliance-information) - License and privacy details
- [Troubleshooting](#troubleshooting) - Common issues and solutions
- [Learn More](#learn-more) - Additional resources and documentation

## What Can You Do?

### For Business & FinOps Teams

#### 1. Cloud Financial Management
- Implement cost governance and accountability frameworks
- Monitor existing AWS budgets and their performance (read-only)
- Establish cost allocation and chargeback mechanisms
- Track organizational cost efficiency and ROI

**Example:** "Show me our organizational cost breakdown by business unit"

#### 2. Cost Analysis & Forecasting
- Historical cost analysis with flexible filtering and forecasting
- Multi-dimensional cost breakdowns by service, account, region, and tags
- Usage pattern analysis and trend identification
- Cost comparison between time periods with detailed drivers

**Example:** "Compare our costs between last quarter and this quarter"

#### 3. Optimization & Governance
- Automated rightsizing recommendations for compute resources
- Reserved Instance and Savings Plans performance analysis
- Cost anomaly detection and unusual spending pattern analysis
- Cross-service cost optimization recommendations

**Example:** "Find cost optimization opportunities across our organization"

### For Developers & Engineering Teams

#### 4. Pre-Deployment Cost Analysis
- Cost modeling for CDK and Terraform projects before deployment (estimates for planning purposes)
- Architecture cost comparison and optimization recommendations
- Service pricing analysis across regions and configurations
- Generate detailed cost estimates with assumptions and recommendations using current AWS pricing and your existing usage patterns (for informational use only)

**Example:** "Provide cost estimates for this CDK stack before I deploy it"

#### 5. Development Environment Optimization
- Development and testing environment cost analysis
- Free Tier usage monitoring to avoid unexpected charges
- Cost-efficient architecture pattern recommendations
- Development workflow cost optimization

**Example:** "Analyze costs for our development environments"

#### 6. Cost-Aware Development
- Real-time AWS pricing intelligence across services and regions
- Service cost comparisons for architecture decisions
- Infrastructure cost analysis and optimization recommendations
- Cost impact analysis for code and infrastructure changes

**Example:** "Compare Lambda vs ECS costs for my microservice architecture"

---

## Quick Start

**For Business & FinOps Teams** - Try these organizational cost management commands:

```
"Show me our AWS costs for the last 3 months by business unit"
"What are our top 5 cost drivers this month?"
"Find cost optimization opportunities across our organization"
"Show me our current budgets and their performance"
"Analyze our Reserved Instance utilization and savings"
"Compare our costs between last quarter and this quarter"
"Detect any cost anomalies in the last 30 days"
```

**For Developers & Engineering Teams** - Try these development-focused commands:

```
"Provide cost estimates for this CDK stack before deployment"
"Compare Lambda vs ECS costs for my microservice"
"What's the cheapest way to build this serverless API?"
"Show me pricing differences between us-east-1 and eu-west-1"
"Analyze costs for our development environments"
"Monitor our Free Tier usage to avoid unexpected charges"
"Show me CPU utilization for rightsizing my EC2 instances"
"Analyze Lambda execution patterns affecting costs"
"Find cost-related CloudWatch alarms that are firing"
"Create cost efficiency metrics for my resources"
```

**New to AWS Cost Management?** Follow the onboarding section below for setup guidance.

**Need help choosing the right tool?** Use our tool selection guide:
*Call action "readSteering" with powerName="aws-cost-optimization", steeringFile="tool-selection-guide.md"*

---

## Available MCP Servers

### awslabs.billing-cost-management-mcp-server  
**Package:** `awslabs.billing-cost-management-mcp-server`  
**License:** Apache-2.0  
**Purpose:** Cost analysis, budget monitoring (read-only), and optimization recommendations  
**Documentation:** https://awslabs.github.io/mcp/servers/billing-cost-management-mcp-server

### awslabs.aws-pricing-mcp-server
**Package:** `awslabs.aws-pricing-mcp-server`  
**License:** Apache-2.0  
**Purpose:** Real-time pricing intelligence, cost modeling, and infrastructure cost analysis  
**Documentation:** https://awslabs.github.io/mcp/servers/aws-pricing-mcp-server

### awslabs.cloudwatch-mcp-server
**Package:** `awslabs.cloudwatch-mcp-server`  
**License:** Apache-2.0  
**Purpose:** Metrics, alarms, and CloudWatch Logs Insights analysis for performance and cost correlation  
**Documentation:** https://awslabs.github.io/mcp/servers/cloudwatch-mcp-server

---

## Available Tools

The AWS Cost Optimization Power provides these tools across its three MCP servers. Tool names are exact: the billing server uses hyphenated names, and the pricing and CloudWatch servers use underscores.

### Cost Analysis & Forecasting (billing server)
- **cost-explorer** - Historical cost and usage, forecasts, and dimension and tag exploration (getCostAndUsage, getCostAndUsageWithResources, getCostForecast, getUsageForecast, getDimensionValues, getTagsOrValues, getCostCategories, getSavingsPlansUtilization)
- **cost-comparison** - Month-to-month cost variance analysis with detailed drivers (getCostAndUsageComparisons, getCostComparisonDrivers)

### Optimization & Recommendations (billing server)
- **cost-optimization** - Cost Optimization Hub recommendations: idle resources, rightsizing, Graviton migration, and Reserved Instance and Savings Plans purchases
- **compute-optimizer** - Performance-based rightsizing and idle resource recommendations (get_ec2_instance_recommendations, get_auto_scaling_group_recommendations, get_ebs_volume_recommendations, get_lambda_function_recommendations, get_rds_recommendations, get_ecs_service_recommendations, get_idle_recommendations)
- **rec-details** - Detailed analysis of one Cost Optimization Hub recommendation
- **sp-recommendation** - Savings Plans purchase recommendations for Compute, EC2 Instance, SageMaker, and Database Savings Plans

### Budget & Anomaly Monitoring (billing server)
- **budgets** - Existing AWS budgets and their status (read-only: cannot create or modify budgets)
- **budget-performance-history** - A budget's actual and forecasted spend over time
- **cost-anomaly** - Cost anomalies detected by AWS Cost Anomaly Detection
- **free-tier-usage** - Free Tier usage across services, to avoid unexpected charges

### Reserved Capacity Analysis (billing server)
- **ri-performance** - Reserved Instance coverage and utilization (get_reservation_coverage, get_reservation_utilization)
- **sp-performance** - Savings Plans coverage and utilization (get_savings_plans_coverage, get_savings_plans_utilization, get_savings_plans_utilization_details)

The billing server also has tools for AWS Billing Conductor, billing views, cost allocation tags, cost categories, invoices, and credits.

### Pricing Intelligence (pricing server)
- **get_pricing** - Real-time AWS pricing with complex filtering across services and regions
- **get_pricing_service_codes** - Discover available AWS services in pricing API
- **get_pricing_service_attributes** - Explore pricing dimensions for services  
- **get_pricing_attribute_values** - Get valid values for pricing filters
- **get_price_list_urls** - Access historical pricing data via bulk download URLs

### Infrastructure Cost Analysis (pricing server)
- **analyze_cdk_project** - Analyze CDK projects for AWS services and cost implications
- **analyze_terraform_project** - Analyze Terraform projects for AWS services and cost implications
- **generate_cost_report** - Generate detailed cost analysis reports with recommendations
- **get_bedrock_patterns** - Architecture patterns and cost considerations for Amazon Bedrock

### Advanced Analytics (billing server)
- **storage-lens** - Query S3 Storage Lens data with Athena SQL. It creates Athena and AWS Glue resources and writes query results to Amazon S3.
- **session-sql** - Run SQL on data that other tools stored in the session database, for custom analysis and cross-tool joins
- **bcm-pricing-calc** - AWS Pricing Calculator workload estimates and rate preferences

### Operational Monitoring & Insights (CloudWatch server)
- **get_metric_data** - Metric data for utilization and cost correlation, including math expressions and Metrics Insights queries
- **get_metric_metadata** - A metric's description, unit, and recommended statistics
- **analyze_metric** - Trend, seasonality, and statistical analysis of a metric
- **get_recommended_metric_alarms** - Recommended alarm configurations for a metric
- **get_active_alarms** - Alarms currently in the ALARM state
- **get_alarm_history** - State change history for an alarm
- **describe_log_groups** - Log groups, their log classes, and saved queries, for retention and storage cost reviews
- **analyze_log_group** - Anomalies and common message patterns in a log group
- **execute_log_insights_query** - Run a CloudWatch Logs Insights query (billed per GB of log data scanned)
- **get_logs_insight_query_results** - Results of a Logs Insights query
- **cancel_logs_insight_query** - Stop a running Logs Insights query

The CloudWatch server can't read or create dashboards. Build dashboards in the CloudWatch console or with infrastructure as code.

---

## Onboarding

### Prerequisites

Before using the AWS Cost Optimization Power, ensure you have:

1. **AWS CLI** (version 2.32.0 or later recommended)
   - Check: `aws --version`
   - Install: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

2. **UV** (Python package manager)
   - Check: `uv --version`
   - Install: https://docs.astral.sh/uv/getting-started/installation/

### Step 1: Configure AWS Credentials

You must ensure that there are valid AWS credentials. This is required for all cost management tools to function properly.

**Configure a named profile using one of these methods:**

#### Option A: AWS IAM Identity Center (recommended)
```bash
aws configure sso --profile cost-readonly
aws sso login --profile cost-readonly
```
IAM Identity Center issues temporary credentials. Run `aws sso login` again when the session expires.

#### Option B: Access keys
```bash
aws configure --profile cost-readonly
```
Enter your Access Key ID, Secret Access Key, default region, and output format. Prefer temporary credentials (Option A) where your organization supports them.

**Verify credentials:**
```bash
AWS_PAGER="" aws sts get-caller-identity --profile cost-readonly
```

**Important for MCP Servers**: Kiro starts the power's MCP servers itself, so they don't see variables you export in a terminal. They read the `AWS_PROFILE` and `AWS_REGION` values from the power's MCP configuration, which default to the `default` profile and `us-east-1`. To use another profile, such as `cost-readonly` above, change `AWS_PROFILE` for the three servers in `~/.kiro/settings/mcp.json`, then restart the servers.

### Step 2: Enable Cost Explorer (if not already enabled)

Cost Explorer is enabled by default for most AWS accounts, but verify:
1. Go to AWS Billing Console → Cost Explorer
2. If prompted, click "Enable Cost Explorer"
3. Wait 24 hours for initial data population

### Step 3: Configure Billing and Monitoring Permissions

The power only needs read access, and its MCP configuration auto-approves the read-only analysis tools. Attach a dedicated read-only policy to the role or user in the profile above, so approved tool calls can't change your resources:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CostAndUsageReadOnly",
      "Effect": "Allow",
      "Action": [
        "ce:Describe*",
        "ce:Get*",
        "ce:List*",
        "budgets:ViewBudget",
        "budgets:DescribeBudgetActionsForAccount",
        "budgets:DescribeBudgetActionsForBudget",
        "cost-optimization-hub:Get*",
        "cost-optimization-hub:List*",
        "compute-optimizer:Describe*",
        "compute-optimizer:Get*",
        "savingsplans:Describe*",
        "freetier:Get*",
        "freetier:List*",
        "pricing:*"
      ],
      "Resource": "*"
    },
    {
      "Sid": "MonitoringReadOnly",
      "Effect": "Allow",
      "Action": [
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*",
        "logs:Describe*",
        "logs:Get*",
        "logs:List*",
        "logs:StartQuery",
        "logs:StopQuery"
      ],
      "Resource": "*"
    }
  ]
}
```

- All AWS Price List API actions (`pricing:*`) are read-only.
- The policy leaves out optional tools that write data or start jobs: `storage-lens` (creates Athena and AWS Glue resources and writes to S3), Savings Plans recommendation generation, and `sp-purchase-analyzer`. To use them, add the actions listed in the [Billing and Cost Management MCP server README](https://github.com/awslabs/mcp/tree/main/src/billing-cost-management-mcp-server).
- In AWS Organizations, a member account sees only its own costs, and the management account sees costs for the whole organization.

### Step 4: Install the Cost Check Hooks (Optional)

This power ships three agent hooks that review infrastructure-as-code for cost issues whenever a matching file is saved: one each for CDK, CloudFormation, and Terraform. Hooks are resolved **per workspace** from `.kiro/hooks/*.json`, so they are not deployed by power installation and must be written into the workspace. To install them:

> "Install the aws-cost-optimization cost check hooks in this workspace"

**Agent instructions:** Load the hook definitions and installation steps by calling action `"readSteering"` with `powerName="aws-cost-optimization"`, `steeringFile="install-hooks.md"`, then follow them. Install only the hooks matching the infrastructure-as-code actually present in the workspace, and adapt each hook's `matcher` to the workspace's real layout.

Skip this step if the workspace contains no infrastructure-as-code.

### Step 5: Start Using the Power

Once credentials are configured, you can immediately start using the power:
- "Show me my monthly AWS costs"
- "Find my most expensive services"
- "Monitor my existing budgets"

---

## Tool Usage Examples

### Cost Analysis & Forecasting

**Get monthly costs by service:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"SERVICE\"}]",
  "metrics": "[\"UnblendedCost\"]"
})
// Returns: Cost breakdown by AWS service
```

**Get cost forecast for next 3 months:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostForecast",
  "metric": "UNBLENDED_COST",
  "granularity": "MONTHLY",
  "start_date": "2024-12-22",
  "end_date": "2025-03-22"
})
// Returns: Cost forecast with confidence intervals
```

**Compare costs month-over-month:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-comparison", {
  "operation": "getCostAndUsageComparisons",
  "baseline_start_date": "2024-10-01",
  "baseline_end_date": "2024-11-01",
  "comparison_start_date": "2024-11-01",
  "comparison_end_date": "2024-12-01",
  "metric_for_comparison": "UnblendedCost"
})
// Returns: Cost changes and percentage differences
```

### Optimization Recommendations

**Get cost optimization opportunities:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-optimization", {
  "operation": "list_recommendations",
  "filters": "{\"actionTypes\": [\"Rightsize\", \"Stop\", \"Delete\"]}"
})
// Returns: Actionable cost optimization recommendations with estimated savings
```

**Get detailed recommendation analysis:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "rec-details", {
  "recommendation_id": "<recommendationId returned by cost-optimization list_recommendations>"
})
// Returns: Detailed analysis combining Cost Optimization Hub, Compute Optimizer, and Cost Explorer data
```

**Get EC2 rightsizing recommendations:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "compute-optimizer", {
  "operation": "get_ec2_instance_recommendations"
})
// Returns: Performance-based EC2 rightsizing opportunities
```

### Budget & Anomaly Monitoring

**Monitor existing budgets (read-only):**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "budgets", {
  "max_items": 100
})
// Returns: List of existing budgets with current spend vs limits (read-only - cannot create or modify budgets)
```

**Detect cost anomalies:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-anomaly", {
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "total_impact_start": 100
})
// Returns: Cost anomalies above $100 with impact analysis
```

**Monitor Free Tier usage:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "free-tier-usage", {
  "operation": "get_free_tier_usage"
})
// Returns: Free Tier usage across services with limits
```

### Reserved Capacity Analysis

**Analyze Reserved Instance utilization:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "ri-performance", {
  "operation": "get_reservation_utilization",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY"
})
// Returns: RI utilization metrics and efficiency analysis
```

**Analyze Savings Plans performance:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "sp-performance", {
  "operation": "get_savings_plans_utilization",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01"
})
// Returns: Savings Plans utilization and coverage metrics
```

### Pricing Intelligence

**Compare EC2 pricing across regions:**
```javascript
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonEC2",
  "region": ["us-east-1", "us-west-2", "eu-west-1"],
  "filters": [
    {"Field": "instanceType", "Value": "m5.large", "Type": "EQUALS"}
  ]
})
// Returns: Regional pricing comparison for specific instance type
```

**Discover available services:**
```javascript
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing_service_codes", {
  "filter": "bedrock"
})
// Returns: AWS services matching "bedrock" pattern
```

### Infrastructure Cost Analysis

**Analyze CDK project costs:**
```javascript
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "analyze_cdk_project", {
  "project_path": "./my-cdk-app"
})
// Returns: AWS services used in CDK project with cost implications
```

**Generate detailed cost report:**
```javascript
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "generate_cost_report", {
  "pricing_data": { /* pricing data from get_pricing */ },
  "service_name": "Amazon Bedrock",
  "format": "markdown"
})
// Returns: Detailed cost analysis report with recommendations
```

### Advanced Analytics

**Query S3 Storage Lens data:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "storage-lens", {
  "query": "SELECT bucket_name, SUM(CAST(metric_value AS BIGINT)) as total_size FROM {table} WHERE metric_name = 'StorageBytes' GROUP BY bucket_name ORDER BY total_size DESC LIMIT 10"
})
// Returns: Top 10 S3 buckets by storage size
```

**Execute custom SQL analysis:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "session-sql", {
  "query": "SELECT service, SUM(cost) as total_cost FROM cost_data GROUP BY service ORDER BY total_cost DESC"
})
// Returns: Custom cost analysis results from session database
```

### Operational Monitoring & Cost Correlation

**Look up a metric before you query it:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_metadata", {
  "namespace": "AWS/EC2",
  "metric_name": "CPUUtilization"
})
// Returns: The metric's description, unit, and recommended statistics
```

**Analyze resource utilization for cost optimization:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "namespace": "AWS/EC2",
  "metric_name": "CPUUtilization",
  "dimensions": [{"name": "InstanceId", "value": "i-1234567890abcdef0"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "statistic": "Average"
})
// Returns: CPU utilization data for rightsizing decisions
```

**Create cost efficiency calculations:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "queries": [
    {
      "id": "cpu_util",
      "metric_stat": {
        "namespace": "AWS/EC2",
        "metric_name": "CPUUtilization",
        "dimensions": [{"name": "InstanceId", "value": "i-1234567890abcdef0"}],
        "statistic": "Average",
        "period": 3600
      }
    },
    {
      "id": "cost_efficiency",
      "expression": "cpu_util / 100 * FILL(cpu_util, 0)"
    }
  ],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z"
})
// Returns: Cost efficiency metrics combining utilization and cost data
```

**Monitor cost-related alarms:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_active_alarms", {
  "max_items": 50  // returns alarms in ALARM state; look for names starting with "HighCost"
})
// Returns: Active cost-related alarms requiring attention
```

**Analyze log-based cost events:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "execute_log_insights_query", {
  "log_group_names": ["/aws/lambda/my-function"],
  "start_time": "2024-11-01T00:00:00+00:00",
  "end_time": "2024-12-01T00:00:00+00:00",
  "query_string": "filter @type = \"REPORT\" | stats avg(@billedDuration), max(@maxMemoryUsed / 1000 / 1000), count() by bin(1d)",
  "limit": 100
})
// Returns: Daily billed duration, peak memory (MB), and invocation counts for Lambda cost analysis.
// Logs Insights charges per GB of log data scanned, so keep the time range and log groups narrow.
```

---

## Tool Selection & Navigation Guide

**🎯 Not sure which tool to use?** Use our tool selection guide:

*Call action "readSteering" with powerName="aws-cost-optimization", steeringFile="tool-selection-guide.md" for query-to-tool mapping and workflow guidance.*

The tool selection guide provides:
- **Query Pattern Mapping** - Match your questions to the right tools
- **Business vs Developer Workflows** - Tailored guidance for different user types  
- **Service-Specific Guidance** - Direct links to 22 detailed service optimization guides
- **Workflow Combinations** - Multi-step analysis patterns
- **CloudWatch Integration** - Performance-cost correlation analysis

---

## Workflows & Guidance

This power includes workflow guidance for both business teams and developers, organized around the **AWS Well-Architected Cost Optimization Pillar's 5 design principles**:

### Service-Specific Optimization Guides

For detailed cost optimization guidance on individual AWS services, see the 22 service guides:

**High-Priority Services (Start Here):**
- **EC2** (`services/compute-cost-optimization.md`) - Instance rightsizing, Spot optimization, Auto Scaling
- **S3, EBS, and EFS** (`services/storage-cost-optimization.md`) - Storage classes, lifecycle policies, volume types
- **RDS and Aurora** (`services/rds-aurora-cost-optimization.md`) - Database sizing, Reserved Instances, Multi-AZ cost management
- **Lambda** (`services/lambda-cost-optimization.md`) - Memory optimization, execution duration, concurrency management

**Additional Services Available:**
- **Compute:** Containers (ECS, EKS, Fargate), EC2 AMD instances, Graviton
- **Storage:** FSx for NetApp ONTAP
- **Database:** DynamoDB, Redshift, OpenSearch, ElastiCache for Redis
- **AI/ML:** Bedrock, Bedrock Agents, SageMaker, AI workloads
- **Networking:** Data transfer, NAT gateways, load balancers, public IPv4, Route 53
- **Security & governance:** Security services, CloudTrail
- **Monitoring & commitments:** CloudWatch and cost intelligence, Reserved Instances
- **Application integration:** SQS

*Call action "readSteering" with powerName="aws-cost-optimization", steeringFile="services/README.md" to list every service guide and its file name, then read the guide you need, for example steeringFile="services/compute-cost-optimization.md".*

### 📘 [CFM TIPs Implementation Playbooks](./steering/cfm-tips-playbooks.md)
*Step-by-step implementation guides from AWS*
- [AWS CFM TIPs](https://catalog.workshops.aws/awscff/en-US) (Cloud Financial Management Technical Implementation Playbooks) is a free AWS workshop with step-by-step guides for the practices in this power
- Covers foundations, visualizations, service cost optimization playbooks, and governance controls

**Agent instructions:** When you recommend an optimization, a setup step, or a governance control, end your answer with `**Implement with CFM TIPs:**` and a link to the matching CFM TIPs page. Service guides list their pages under "CFM TIPs Playbooks". For other topics, call action "readSteering" with powerName="aws-cost-optimization", steeringFile="cfm-tips-playbooks.md". Link only pages listed in this power's guides, and skip the link when no page matches.

### For Business & FinOps Teams

### 💼 [Cloud Financial Management](./steering/cloud-financial-management.md)
*Design Principle 1: Implement Cloud Financial Management*
- Financial accountability and cost ownership frameworks
- Budget governance and hierarchical budget structures
- Cost allocation, chargeback, and showback implementation
- Anomaly detection and financial reporting automation

### 🔄 [Consumption Model Optimization](./steering/consumption-model.md)
*Design Principle 2: Adopt a Consumption Model*
- Dynamic resource scaling and rightsizing strategies
- Auto Scaling optimization and serverless migration
- Usage-based pricing model adoption
- Storage lifecycle and consumption optimization

### 📊 [Efficiency Measurement](./steering/efficiency-measurement.md)
*Design Principle 3: Measure Overall Efficiency*
- Business value correlation and ROI measurement
- Resource utilization efficiency analysis
- Automation effectiveness and performance-cost optimization
- Continuous improvement and efficiency benchmarking

### ⚙️ [Managed Services Optimization](./steering/managed-services-optimization.md)
*Design Principle 4: Stop Spending Money on Undifferentiated Heavy Lifting*
- Managed service migration opportunities and strategies
- Database, container, and storage migration to managed services
- Total cost of ownership analysis and optimization
- Operational overhead reduction through managed services

### 🏷️ [Expenditure Attribution](./steering/expenditure-attribution.md)
*Design Principle 5: Analyze and Attribute Expenditure*
- Multi-dimensional cost allocation and tagging strategies
- Chargeback and showback implementation
- Cost driver analysis and root cause identification
- Advanced cost attribution analytics and predictive modeling

### For Developers & Engineering Teams

### 👨‍💻 [Developer Cost Optimization](./steering/developer-cost-optimization.md)
*Cost-aware development workflows and patterns*
- Pre-deployment cost analysis and modeling
- Development environment cost optimization
- Cost-efficient architecture patterns and anti-patterns
- Integration with development workflows and CI/CD pipelines

### 🪝 [Installing the Cost Check Hooks](./steering/install-hooks.md)
*Automated cost review on file save*
- Hook definitions for CDK, CloudFormation, and Terraform
- Per-workspace installation steps and pattern adaptation
- Verification and removal guidance

---

## Best Practices

### ✅ Do:

- **Start with high-level analysis** (service-level costs) before drilling down to resources
- **Use appropriate time ranges** - daily for recent analysis, monthly for trends
- **Leverage auto-approval patterns** - most read operations are automatically approved
- **Combine multiple tools** for thorough analysis (cost + optimization + pricing)
- **Set up budget monitoring** with multiple alert thresholds (50%, 80%, 100%)
- **Monitor anomalies regularly** - set up automated anomaly detection
- **Use tags consistently** for accurate cost allocation and chargeback
- **Analyze Reserved Instance utilization** monthly to optimize commitments
- **Compare costs month-over-month** to identify trends and drivers
- **Use SQL analytics** for complex custom analysis and reporting

### ❌ Don't:

- **Query very long time ranges** without reason (expensive and slow)
- **Ignore cost forecasts** - use them for budget planning and capacity decisions
- **Skip dimension exploration** - use the cost-explorer `getDimensionValues` operation to understand your data
- **Forget regional differences** - pricing varies significantly by region
- **Overlook Free Tier usage** - monitor to avoid unexpected charges
- **Ignore budget performance** - regularly check budget status and utilization
- **Ignore optimization recommendations** - they represent real savings opportunities
- **Use only On-Demand pricing** - consider Reserved Instances and Savings Plans
- **Assume you can create/modify budgets** - this power provides read-only budget monitoring

---

## Legal and Compliance Information

### License
This power is released under the **Apache-2.0 License**. See the LICENSE file for full terms.

### Authentication and Data Processing
This power requires AWS credentials to function and processes AWS cost and usage data on your behalf. By using this power:
- Any personal data is processed as described in the [AWS Privacy Notice](https://aws.amazon.com/privacy/).
- No cost or usage data is stored by this power - all data is retrieved in real-time from AWS APIs
- All interactions with AWS services are logged by AWS CloudTrail (if enabled in your account)

### Disclaimers
- **Cost Estimates**: Cost estimates and forecasts are provided for informational purposes only and should not be considered guarantees
- **Optimization Recommendations**: Recommendations are suggestions based on AWS best practices and should be evaluated by your technical team before implementation
- **Service Availability**: This power depends on AWS service availability and may be affected by AWS service disruptions
- **Results Accuracy**: While we strive for accuracy, users should verify all cost and optimization data independently

### Third-Party Dependencies
This power incorporates the following AWS Labs MCP servers under Apache-2.0 license:
- `awslabs.billing-cost-management-mcp-server` (Apache-2.0)
- `awslabs.aws-pricing-mcp-server` (Apache-2.0)  
- `awslabs.cloudwatch-mcp-server` (Apache-2.0)

For detailed information about the individual MCP servers, please refer to their respective documentation linked in the [Available MCP Servers](#available-mcp-servers) section.

---

## Troubleshooting

### "Access Denied" Errors
- Verify credentials are valid: `AWS_PAGER="" aws sts get-caller-identity`
- Check IAM permissions for Cost Explorer, Budgets, and Pricing APIs
- Ensure Cost Explorer is enabled in your AWS account
- For Organizations: verify access to consolidated billing data

### "No Data Available" Errors
- AWS cost data has 24-48 hour delay - check date ranges
- Verify date ranges are within available data periods (last 13 months)
- For new accounts: wait 24 hours after first resource usage

### MCP Server Connection Issues
- Verify UV is installed: `uv --version`
- Check AWS credentials configuration
- Restart Kiro to reconnect MCP servers
- Review MCP server logs for specific errors

### CloudWatch Access Issues
**Problem**: CloudWatch metrics or logs not accessible
**Symptoms**:
- "Access Denied" errors when querying metrics
- Empty results from metric queries
- Log group access failures

**Solutions**:
1. **Verify CloudWatch permissions**:
   ```bash
   aws cloudwatch list-metrics --namespace AWS/EC2 --max-items 1
   ```
2. **Check log group permissions**:
   ```bash
   aws logs describe-log-groups --max-items 1
   ```
3. **Ensure proper IAM policies** include CloudWatch and Logs permissions
4. **Verify region consistency** between queries and resources

### "ExpiredTokenException" or MCP Credential Issues
**Problem**: MCP servers show expired token errors even when AWS CLI works fine.

**Root Cause**: Kiro starts the MCP servers itself, so they use the profile named by `AWS_PROFILE` in the power's MCP configuration, not variables exported in your terminal. That profile's credentials have expired, or the configuration points at a different profile than the one you refreshed. Running servers can also keep using old credentials until they restart.

**Solution**:
1. **Refresh the profile's credentials**:
   ```bash
   aws sso login --profile cost-readonly   # IAM Identity Center profiles
   ```
   For a profile that uses temporary access keys, replace the keys for that profile in `~/.aws/credentials`.

2. **Check which profile the servers use**: confirm that `AWS_PROFILE` for the power's three servers in `~/.kiro/settings/mcp.json` names the profile you refreshed.

3. **Restart MCP servers** in Kiro to pick up new credentials

4. **Verify credentials work**:
   ```bash
   AWS_PAGER="" aws sts get-caller-identity --profile cost-readonly
   ```

**Note**: Environment variables such as `export AWS_ACCESS_KEY_ID=...` in a terminal don't reach the MCP servers. Use a named profile instead.

---

## Learn More

- AWS Cost Management: https://aws.amazon.com/aws-cost-management/
- AWS Well-Architected Cost Optimization Pillar: https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/
- AWS Cost Explorer: https://aws.amazon.com/aws-cost-management/aws-cost-explorer/
- AWS CFM TIPs workshop (step-by-step implementation playbooks): https://catalog.workshops.aws/awscff/en-US

---

## Support

For issues with the AWS Cost Optimization Power:
1. Check your AWS credentials are valid
2. Verify AWS CLI and UV are installed
3. Review the troubleshooting section above