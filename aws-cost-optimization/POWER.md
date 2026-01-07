---
name: "aws-cost-optimization"
displayName: "AWS Cost Optimization"
description: "Comprehensive AWS cost optimization for both business teams and developers. Implement cloud financial management, analyze costs, get optimization recommendations, and enable cost-aware development workflows. Aligned with AWS Well-Architected Cost Optimization Pillar."
keywords: ["finops", "cost-optimization", "aws-billing", "cost-analysis", "budget-management", "rightsizing", "cost-intelligence", "savings-plans", "reserved-instances", "cost-anomaly", "spend-analysis", "cost-forecasting", "resource-optimization", "well-architected", "cloud-financial-management", "consumption-model", "efficiency-measurement", "expenditure-analysis", "developer-cost-optimization", "pre-deployment-analysis", "architecture-cost-modeling", "development-environment-optimization", "cost-aware-development"]
author: "Venkat Pullela"
---

# AWS Cost Optimization Power

Comprehensive AWS cost optimization for both business teams and developers. Analyze costs, get optimization recommendations, manage budgets, implement financial governance, and enable cost-aware development workflows. Aligned with the AWS Well-Architected Cost Optimization Pillar.

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
- Cost modeling for CDK and Terraform projects before deployment
- Architecture cost comparison and optimization recommendations
- Service pricing analysis across regions and configurations
- Generate detailed cost estimates with assumptions and recommendations

**Example:** "Estimate costs for this CDK stack before I deploy it"

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
"Estimate costs for this CDK stack before deployment"
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

**New to AWS Cost Management?** Follow the onboarding section below for complete setup.

**Need help choosing the right tool?** Use our tool selection guide:
*Call action "readSteering" with powerName="aws-cost-optimization", steeringFile="tool-selection-guide.md"*

---

## Available MCP Servers

### awslabs.billing-cost-management-mcp-server  
**Package:** `awslabs.billing-cost-management-mcp-server`  
**License:** Apache-2.0  
**Purpose:** Comprehensive cost analysis, budget monitoring (read-only), and optimization recommendations

### awslabs.aws-pricing-mcp-server
**Package:** `awslabs.aws-pricing-mcp-server`  
**License:** Apache-2.0  
**Purpose:** Real-time pricing intelligence, cost modeling, and infrastructure cost analysis

### awslabs.cloudwatch-mcp-server
**Package:** `awslabs.cloudwatch-mcp-server`  
**License:** Apache-2.0  
**Purpose:** Metrics monitoring, log analysis, dashboard management, and operational insights for cost optimization

---

## Available Tools

The AWS Cost Optimization Power provides these tools across two MCP servers:

### Cost Analysis & Forecasting
- **cost_explorer** - Historical cost/usage data, forecasting, dimension exploration (getCostAndUsage, getCostForecast, getDimensionValues, getTagsOrValues, getSavingsPlansUtilization, getCostCategories, etc.)
- **cost_comparison** - Month-to-month cost variance analysis with detailed drivers (getCostAndUsageComparisons, getCostComparisonDrivers)

### Optimization & Recommendations  
- **cost_optimization** - Cost savings recommendations from Cost Optimization Hub (idle resources, rightsizing, RI/SP purchases)
- **compute_optimizer** - Performance-based rightsizing recommendations (EC2, EBS, Lambda, RDS, ECS, ASG)
- **rec_details** - Detailed analysis combining Cost Optimization Hub, Compute Optimizer, and Cost Explorer data

### Budget & Anomaly Monitoring
- **budgets** - Monitor existing AWS budgets and their performance (read-only - cannot create or modify budgets)
- **cost_anomaly** - Detect and analyze cost anomalies (last 90 days)
- **free_tier_usage** - Monitor Free Tier usage across services to avoid unexpected charges

### Reserved Capacity Analysis
- **ri_performance** - Reserved Instance coverage and utilization analysis
- **sp_performance** - Savings Plans coverage and utilization analysis

### Pricing Intelligence
- **get_pricing** - Real-time AWS pricing with complex filtering across services and regions
- **get_pricing_service_codes** - Discover available AWS services in pricing API
- **get_pricing_service_attributes** - Explore pricing dimensions for services  
- **get_pricing_attribute_values** - Get valid values for pricing filters
- **get_price_list_urls** - Access historical pricing data via bulk download URLs

### Infrastructure Cost Analysis
- **analyze_cdk_project** - Analyze CDK projects for AWS services and cost implications
- **analyze_terraform_project** - Analyze Terraform projects for AWS services and cost implications
- **generate_cost_report** - Generate comprehensive cost analysis reports with recommendations
- **get_bedrock_patterns** - Architecture patterns and cost considerations for Amazon Bedrock

### Advanced Analytics
- **storage_lens** - Query S3 Storage Lens data using Athena SQL for storage optimization
- **session_sql** - Execute SQL queries on cost data for custom analysis and cross-tool joins
- **bcm_pricing_calc** - Access AWS Pricing Calculator workload estimates and rate preferences

### Operational Monitoring & Insights
- **list_metrics** - Discover available CloudWatch metrics for cost-related monitoring
- **get_metric_statistics** - Retrieve metric data for resource utilization and cost correlation analysis
- **get_metric_data** - Advanced metric queries with math expressions for cost efficiency calculations
- **describe_alarms** - Monitor existing CloudWatch alarms for cost and performance thresholds
- **list_dashboards** - Access existing CloudWatch dashboards for cost monitoring
- **get_dashboard** - Retrieve dashboard configurations for cost optimization insights
- **describe_log_groups** - Analyze CloudWatch Logs usage and retention for cost optimization
- **get_log_events** - Query log data for cost-related events and patterns
- **start_query** - Execute CloudWatch Logs Insights queries for advanced cost analysis
- **get_query_results** - Retrieve results from CloudWatch Logs Insights cost analysis queries
- **describe_metric_filters** - Analyze metric filters for cost-related log monitoring

---

## Onboarding

### Prerequisites

Before using the AWS Cost Optimizer Power, ensure you have:

1. **AWS CLI** (version 2.32.0 or later recommended)
   - Check: `aws --version`
   - Install: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

2. **UV** (Python package manager)
   - Check: `uv --version`
   - Install: https://docs.astral.sh/uv/getting-started/installation/

### Step 1: Configure AWS Credentials

You must ensure that there are valid AWS credentials. This is required for all cost management tools to function properly.

**Configure credentials using one of these methods:**

#### Option A: AWS CLI Configure
```bash
aws configure
```
Enter your Access Key ID, Secret Access Key, default region, and output format.

#### Option B: Environment Variables
```bash
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
export AWS_DEFAULT_REGION=us-east-1
```

#### Option C: AWS SSO
```bash
aws configure sso
```

**Verify credentials:**
```bash
AWS_PAGER="" aws sts get-caller-identity
```

**Important for MCP Servers**: The MCP servers in this power use AWS credential files (`~/.aws/credentials`) rather than environment variables. If you're using temporary credentials (like AWS SSO or session tokens), ensure they are saved to the credential file, not just set as environment variables.

### Step 2: Enable Cost Explorer (if not already enabled)

Cost Explorer is enabled by default for most AWS accounts, but verify:
1. Go to AWS Billing Console → Cost Explorer
2. If prompted, click "Enable Cost Explorer"
3. Wait 24 hours for initial data population

### Step 3: Configure Billing and Monitoring Permissions

Ensure your AWS user/role has the required permissions:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ce:*",
                "budgets:*",
                "pricing:*",
                "organizations:ListAccounts",
                "organizations:DescribeOrganization",
                "support:*",
                "cur:*",
                "cloudwatch:*",
                "logs:*"
            ],
            "Resource": "*"
        }
    ]
}
```

### Step 4: Start Using the Power

Once credentials are configured, you can immediately start using the power:
- "Show me my monthly AWS costs"
- "Find my most expensive services"
- "Monitor my existing budgets"

---

## Tool Usage Examples

### Cost Analysis & Forecasting

**Get monthly costs by service:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "cost_explorer", {
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
usePower("aws-cost-optimization", "aws-billing-cost-management", "cost_explorer", {
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
usePower("aws-cost-optimization", "aws-billing-cost-management", "cost_comparison", {
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
usePower("aws-cost-optimization", "aws-billing-cost-management", "cost_optimization", {
  "operation": "list_recommendations",
  "filters": "{\"actionTypes\": [\"Rightsize\", \"Stop\", \"Delete\"]}"
})
// Returns: Actionable cost optimization recommendations with estimated savings
```

**Get detailed recommendation analysis:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "rec_details", {
  "recommendation_id": "arn:aws:cost-optimization-hub:us-east-1:123456789012:recommendation/12345"
})
// Returns: Comprehensive analysis combining multiple AWS services data
```

**Get EC2 rightsizing recommendations:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "compute_optimizer", {
  "operation": "get_ec2_instance_recommendations"
})
// Returns: Performance-based EC2 rightsizing opportunities
```

### Budget & Anomaly Monitoring

**Monitor existing budgets (read-only):**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "budgets", {
  "max_results": 100
})
// Returns: List of existing budgets with current spend vs limits (read-only - cannot create or modify budgets)
```

**Detect cost anomalies:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "cost_anomaly", {
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "total_impact_start": 100
})
// Returns: Cost anomalies above $100 with impact analysis
```

**Monitor Free Tier usage:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "free_tier_usage", {
  "operation": "get_free_tier_usage"
})
// Returns: Free Tier usage across services with limits
```

### Reserved Capacity Analysis

**Analyze Reserved Instance utilization:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "ri_performance", {
  "operation": "get_reservation_utilization",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY"
})
// Returns: RI utilization metrics and efficiency analysis
```

**Analyze Savings Plans performance:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "sp_performance", {
  "operation": "get_savings_plans_utilization",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01"
})
// Returns: Savings Plans utilization and coverage metrics
```

### Pricing Intelligence

**Compare EC2 pricing across regions:**
```javascript
usePower("aws-cost-optimization", "aws-pricing", "get_pricing", {
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
usePower("aws-cost-optimization", "aws-pricing", "get_pricing_service_codes", {
  "filter": "bedrock"
})
// Returns: AWS services matching "bedrock" pattern
```

### Infrastructure Cost Analysis

**Analyze CDK project costs:**
```javascript
usePower("aws-cost-optimization", "aws-pricing", "analyze_cdk_project", {
  "project_path": "./my-cdk-app"
})
// Returns: AWS services used in CDK project with cost implications
```

**Generate comprehensive cost report:**
```javascript
usePower("aws-cost-optimization", "aws-pricing", "generate_cost_report", {
  "pricing_data": { /* pricing data from get_pricing */ },
  "service_name": "Amazon Bedrock",
  "format": "markdown"
})
// Returns: Detailed cost analysis report with recommendations
```

### Advanced Analytics

**Query S3 Storage Lens data:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "storage_lens", {
  "query": "SELECT bucket_name, SUM(CAST(metric_value AS BIGINT)) as total_size FROM {table} WHERE metric_name = 'StorageBytes' GROUP BY bucket_name ORDER BY total_size DESC LIMIT 10"
})
// Returns: Top 10 S3 buckets by storage size
```

**Execute custom SQL analysis:**
```javascript
usePower("aws-cost-optimization", "aws-billing-cost-management", "session_sql", {
  "query": "SELECT service, SUM(cost) as total_cost FROM cost_data GROUP BY service ORDER BY total_cost DESC"
})
// Returns: Custom cost analysis results from session database
```

### Operational Monitoring & Cost Correlation

**Discover cost-related metrics:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "list_metrics", {
  "namespace": "AWS/EC2",
  "metric_name": "CPUUtilization"
})
// Returns: Available EC2 CPU metrics for rightsizing analysis
```

**Analyze resource utilization for cost optimization:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "AWS/EC2",
  "metric_name": "CPUUtilization",
  "dimensions": [{"Name": "InstanceId", "Value": "i-1234567890abcdef0"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "period": 3600,
  "statistics": ["Average", "Maximum"]
})
// Returns: CPU utilization data for rightsizing decisions
```

**Create cost efficiency calculations:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "metric_data_queries": [
    {
      "id": "cpu_util",
      "metric_stat": {
        "metric": {
          "namespace": "AWS/EC2",
          "metric_name": "CPUUtilization",
          "dimensions": [{"Name": "InstanceId", "Value": "i-1234567890abcdef0"}]
        },
        "period": 3600,
        "stat": "Average"
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
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "describe_alarms", {
  "alarm_name_prefix": "HighCost",
  "state_value": "ALARM"
})
// Returns: Active cost-related alarms requiring attention
```

**Analyze log-based cost events:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "start_query", {
  "log_group_name": "/aws/lambda/my-function",
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "query_string": "fields @timestamp, @duration, @billedDuration | filter @duration > 5000 | stats count() by bin(5m)"
})
// Returns: Query ID for analyzing Lambda execution patterns affecting costs
```

---

## Tool Selection & Navigation Guide

**🎯 Not sure which tool to use?** Use our comprehensive tool selection guide:

*Call action "readSteering" with powerName="aws-cost-optimization", steeringFile="tool-selection-guide.md" for complete query-to-tool mapping and workflow guidance.*

The tool selection guide provides:
- **Query Pattern Mapping** - Match your questions to the right tools
- **Business vs Developer Workflows** - Tailored guidance for different user types  
- **Service-Specific Guidance** - Direct links to 20 detailed service optimization guides
- **Workflow Combinations** - Multi-step analysis patterns
- **CloudWatch Integration** - Performance-cost correlation analysis

---

## Workflows & Guidance

This power includes comprehensive workflow guidance for both business teams and developers, organized around the **AWS Well-Architected Cost Optimization Pillar's 5 design principles**:

### Service-Specific Optimization Guides

For detailed cost optimization guidance on individual AWS services, see our comprehensive service guides:

**High-Priority Services (Start Here):**
- **EC2** - Instance rightsizing, Reserved Instances, Spot optimization, Auto Scaling
- **S3** - Storage classes, lifecycle policies, data transfer optimization
- **RDS** - Database sizing, Reserved Instances, Multi-AZ cost management
- **Lambda** - Memory optimization, execution duration, concurrency management

**Additional Services Available:**
- **Compute:** ECS, Batch, Fargate optimization strategies
- **Storage:** EBS, EFS, FSx cost management
- **Database:** DynamoDB, Redshift, Aurora optimization
- **AI/ML:** Bedrock, SageMaker, Comprehend cost strategies
- **Networking:** CloudFront, VPC, Route53, Load Balancer optimization
- **Analytics:** Athena, Glue, EMR, Kinesis cost management

*Call action "readSteering" with powerName="aws-cost-optimization", steeringFile="services/README.md" to see all available service guides, then read specific service files like "services/ec2-cost-optimization.md" for detailed guidance.*

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

---

## Best Practices

### ✅ Do:

- **Start with high-level analysis** (service-level costs) before drilling down to resources
- **Use appropriate time ranges** - daily for recent analysis, monthly for trends
- **Leverage auto-approval patterns** - most read operations are automatically approved
- **Combine multiple tools** for comprehensive analysis (cost + optimization + pricing)
- **Set up budget monitoring** with multiple alert thresholds (50%, 80%, 100%)
- **Monitor anomalies regularly** - set up automated anomaly detection
- **Use tags consistently** for accurate cost allocation and chargeback
- **Analyze Reserved Instance utilization** monthly to optimize commitments
- **Compare costs month-over-month** to identify trends and drivers
- **Use SQL analytics** for complex custom analysis and reporting

### ❌ Don't:

- **Query very long time ranges** without reason (expensive and slow)
- **Ignore cost forecasts** - use them for budget planning and capacity decisions
- **Skip dimension exploration** - use get_dimension_values to understand your data
- **Forget regional differences** - pricing varies significantly by region
- **Overlook Free Tier usage** - monitor to avoid unexpected charges
- **Ignore budget performance** - regularly check budget status and utilization
- **Ignore optimization recommendations** - they represent real savings opportunities
- **Use only On-Demand pricing** - consider Reserved Instances and Savings Plans
- **Assume you can create/modify budgets** - this power provides read-only budget monitoring

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
   aws cloudwatch list-metrics --namespace AWS/EC2 --max-records 1
   ```
2. **Check log group permissions**:
   ```bash
   aws logs describe-log-groups --max-items 1
   ```
3. **Ensure proper IAM policies** include CloudWatch and Logs permissions
4. **Verify region consistency** between queries and resources

### "ExpiredTokenException" or MCP Credential Issues
**Problem**: MCP servers show expired token errors even when AWS CLI works fine.

**Root Cause**: MCP servers use AWS credential files (`~/.aws/credentials`) rather than environment variables, and may cache old credentials even after restart.

**Solution**:
1. **Update AWS credential file** with fresh credentials:
   ```bash
   # Edit ~/.aws/credentials file directly
   [default]
   aws_access_key_id = YOUR_ACCESS_KEY
   aws_secret_access_key = YOUR_SECRET_KEY
   aws_session_token = YOUR_SESSION_TOKEN  # If using temporary credentials
   ```

2. **Restart MCP servers** in Kiro to pick up new credentials

3. **Verify credentials work**:
   ```bash
   aws sts get-caller-identity
   ```

**Note**: Environment variables (`export AWS_ACCESS_KEY_ID=...`) alone are not sufficient for MCP servers. The credential file must be updated for MCP servers to authenticate properly.

---

## Learn More

- AWS Cost Management: https://aws.amazon.com/aws-cost-management/
- AWS Well-Architected Cost Optimization Pillar: https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/
- AWS Cost Explorer: https://aws.amazon.com/aws-cost-management/aws-cost-explorer/

---

## Support

For issues with the AWS Cost Optimization Power:
1. Check your AWS credentials are valid
2. Verify AWS CLI and UV are installed
3. Review the troubleshooting section above