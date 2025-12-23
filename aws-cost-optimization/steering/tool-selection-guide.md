---
inclusion: manual
---

# AWS Cost Optimization Tool Selection Guide

Use this guide to select the most appropriate tools based on user queries for both business and developer workflows:

## Query Pattern → Tool Mapping

### Business & FinOps Workflows

#### Cost Analysis Queries
- "show costs", "cost breakdown", "spending analysis" → `cost_explorer`
- "forecast", "predict costs", "future spending" → `cost_explorer` (getCostForecast)
- "compare costs", "month over month" → `cost_comparison`

#### Optimization Queries  
- "save money", "reduce costs", "optimization" → `cost_optimization`
- "rightsizing", "instance recommendations" → `compute_optimizer`
- "unused resources", "idle instances" → `cost_optimization`

#### Budget & Monitoring
- "budget", "spending limits", "alerts" → `budgets`
- "anomaly", "unusual spending", "spikes" → `cost_anomaly`
- "free tier", "free usage" → `free_tier_usage`

#### Reserved Capacity
- "reserved instances", "RI utilization" → `ri_performance`  
- "savings plans", "SP coverage" → `sp_performance`

### Developer & Engineering Workflows

#### Pre-Deployment Cost Analysis
- "CDK costs", "estimate CDK stack" → `analyze_cdk_project` + `get_pricing`
- "Terraform costs", "estimate Terraform" → `analyze_terraform_project` + `get_pricing`
- "architecture costs", "design costs" → `get_pricing` + `generate_cost_report`
- "before deployment", "pre-deploy analysis" → `analyze_cdk_project` or `analyze_terraform_project`

#### Service & Architecture Comparison
- "Lambda vs ECS", "service comparison" → `get_pricing` (multi-service)
- "cheapest option", "lowest cost" → `get_pricing` (with cost optimization filters)
- "regional pricing", "region comparison" → `get_pricing` (multi-region)
- "serverless costs", "container costs" → `get_pricing` (service-specific)

#### Development Environment Optimization
- "dev environment costs", "development spending" → `cost_explorer` (filtered by Environment=dev tags)
- "test environment", "staging costs" → `cost_explorer` (filtered by environment tags)
- "free tier usage", "avoid charges" → `free_tier_usage`
- "development budget", "team spending" → `budgets` + `cost_explorer`

#### Cost-Aware Development
- "pricing intelligence", "service pricing" → `get_pricing`
- "cost modeling", "estimate costs" → `get_pricing` + `generate_cost_report`
- "architecture decision", "cost comparison" → `get_pricing` (comparative analysis)
- "development ROI", "cost per feature" → `cost_explorer` (custom analysis)

#### Infrastructure Cost Analysis
- "Bedrock patterns", "AI costs" → `get_bedrock_patterns` + `get_pricing`
- "storage optimization", "S3 costs" → `storage_lens` + `get_pricing`
- "database costs", "RDS vs DynamoDB" → `get_pricing` (service comparison)
- "compute costs", "EC2 vs Lambda" → `get_pricing` + `compute_optimizer`

### Cross-Functional Workflows

#### Pricing Intelligence
- "pricing", "cost comparison", "cheapest" → `get_pricing`
- "service codes", "available services" → `get_pricing_service_codes`
- "pricing attributes", "filter options" → `get_pricing_service_attributes`
- "valid values", "pricing options" → `get_pricing_attribute_values`

#### Comprehensive Analysis
- "detailed cost report", "full analysis" → `generate_cost_report`
- "cost recommendations", "optimization report" → `rec_details`
- "historical pricing", "bulk data" → `get_price_list_urls`

## Advanced Tools (Manual Approval)
- S3 storage analysis → `storage_lens`
- Custom SQL analysis → `session_sql`
- Pricing calculator → `bcm_pricing_calc`

## Workflow Combinations

### Complete Pre-Deployment Analysis
1. `analyze_cdk_project` or `analyze_terraform_project` → Identify services
2. `get_pricing` → Get pricing for identified services
3. `generate_cost_report` → Generate comprehensive cost analysis

### Architecture Decision Support
1. `get_pricing` → Compare service options
2. `get_pricing_service_attributes` → Understand pricing dimensions
3. `get_pricing_attribute_values` → Explore configuration options

### Development Cost Optimization
1. `cost_explorer` → Analyze current development spending
2. `free_tier_usage` → Check Free Tier utilization
3. `cost_optimization` → Find optimization opportunities
4. `budgets` → Monitor spending limits