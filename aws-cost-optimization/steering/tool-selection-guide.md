---
inclusion: manual
---

# AWS Cost Optimization Tool Selection Guide

Use this guide to select the most appropriate tools based on user queries:

## Query Pattern → Tool Mapping

### Cost Analysis Queries
- "show costs", "cost breakdown", "spending analysis" → `cost_explorer`
- "forecast", "predict costs", "future spending" → `cost_explorer` (getCostForecast)
- "compare costs", "month over month" → `cost_comparison`

### Optimization Queries  
- "save money", "reduce costs", "optimization" → `cost_optimization`
- "rightsizing", "instance recommendations" → `compute_optimizer`
- "unused resources", "idle instances" → `cost_optimization`

### Budget & Monitoring
- "budget", "spending limits", "alerts" → `budgets`
- "anomaly", "unusual spending", "spikes" → `cost_anomaly`
- "free tier", "free usage" → `free_tier_usage`

### Pricing Intelligence
- "pricing", "cost comparison", "cheapest" → `get_pricing`
- "CDK costs", "terraform costs" → `analyze_cdk_project`, `analyze_terraform_project`

### Reserved Capacity
- "reserved instances", "RI utilization" → `ri_performance`  
- "savings plans", "SP coverage" → `sp_performance`

## Advanced Tools (Manual Approval)
- S3 storage analysis → `storage_lens`
- Custom SQL analysis → `session_sql`
- Pricing calculator → `bcm_pricing_calc`