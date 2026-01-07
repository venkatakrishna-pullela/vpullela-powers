# Amazon DynamoDB Cost Optimization Guide

## Service Overview

**What is Amazon DynamoDB?**
- Fully managed NoSQL database service with single-digit millisecond performance
- Serverless with automatic scaling capabilities
- Pay-per-use pricing model with multiple capacity modes
- Built-in security, backup, and multi-region replication

**Why DynamoDB Cost Optimization Matters**
- Costs can vary dramatically between On-Demand and Provisioned modes (up to 70% difference)
- Read/write capacity units directly impact costs
- Storage class selection affects long-term costs
- Feature selection (Global Tables, backups, streams) adds significant costs

---

## Cost Analysis & Monitoring

### Key Cost Drivers

**Core Cost Dimensions:**
- **Provisioned Write Capacity Units (WCU)**: $0.000065 per WCU-hour (1 WCU = 1KB/second)
- **Provisioned Read Capacity Units (RCU)**: $0.00013 per RCU-hour (1 RCU = 4KB/second strongly consistent, 8KB eventually consistent)
- **Data Storage**: $0.10 per GB-month (Standard), lower for Standard-IA
- **On-Demand Pricing**: $1.25 per million write requests, $0.25 per million read requests

**Optional Cost Features:**
- **Point-in-Time Recovery (PITR)**: $0.20 per GB-month
- **On-Demand Backup**: $0.10 per GB-month
- **Data Transfer Out**: $0.09 per GB to other regions
- **Data Export to S3**: $0.10 per GB
- **Global Tables**: $0.000975 per replicated WCU-hour

### Using the Power's Tools

**Get DynamoDB costs by API operation:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "DAILY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"API_OPERATION\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon DynamoDB\"]}}"
})
```

**Analyze DynamoDB usage patterns:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "metrics": "[\"UsageQuantity\", \"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon DynamoDB\"]}}"
})
```

**Monitor DynamoDB performance metrics:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "AWS/DynamoDB",
  "metric_name": "ConsumedReadCapacityUnits",
  "dimensions": [{"Name": "TableName", "Value": "my-table"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "period": 3600,
  "statistics": ["Sum", "Average"]
})
```

---

## Optimization Strategies

### 1. Capacity Mode Selection

**Strategy Overview:**
Choose between On-Demand and Provisioned capacity based on traffic patterns and predictability.

**On-Demand Mode:**
- **Best for**: Unpredictable workloads, new applications, sporadic traffic
- **Pricing**: $1.25 per million write requests, $0.25 per million read requests
- **Benefits**: No capacity planning, automatic scaling, pay-per-request

**Provisioned Mode:**
- **Best for**: Predictable workloads, steady traffic patterns
- **Pricing**: $0.000065 per WCU-hour, $0.00013 per RCU-hour
- **Benefits**: Up to 70% cost savings for consistent workloads

**Cost Comparison Analysis:**
```javascript
// Calculate break-even point between modes
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonDynamoDB",
  "region": ["us-east-1"],
  "filters": [
    {"Field": "productFamily", "Value": "Database Storage", "Type": "EQUALS"}
  ]
})
```

**Decision Framework:**
- **Use On-Demand if**: Traffic varies >50% day-to-day, new application, <40% utilization
- **Use Provisioned if**: Steady traffic, >40% utilization, predictable patterns

### 2. Auto Scaling Configuration

**Strategy Overview:**
Optimize Provisioned mode with auto-scaling to handle traffic variations while minimizing costs.

**Auto Scaling Best Practices:**
- **Target Utilization**: 70% for cost optimization, 40% for performance
- **Scale-up**: Aggressive (double capacity)
- **Scale-down**: Conservative (50% reduction, longer cooldown)

**Implementation:**
```javascript
// Monitor auto-scaling effectiveness
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "AWS/DynamoDB",
  "metric_name": "ProvisionedReadCapacityUnits",
  "dimensions": [{"Name": "TableName", "Value": "my-table"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "period": 3600,
  "statistics": ["Average", "Maximum"]
})
```

**Optimization Techniques:**
- Set minimum capacity based on baseline traffic
- Use predictive scaling for known traffic patterns
- Monitor throttling events to adjust scaling policies
- Implement application-level retry logic with exponential backoff

### 3. Read/Write Optimization

**Strategy Overview:**
Optimize read and write operations to minimize capacity unit consumption.

**Write Optimization:**
- **Batch Operations**: Use BatchWriteItem for multiple items (up to 25 items)
- **Conditional Writes**: Avoid unnecessary writes with condition expressions
- **Item Size**: Keep items under 1KB to minimize WCU consumption
- **Sparse Indexes**: Use GSI projections to reduce write amplification

**Read Optimization:**
- **Eventually Consistent Reads**: Use when possible (50% cost reduction)
- **Query vs Scan**: Always prefer Query over Scan operations
- **Projection Expressions**: Retrieve only needed attributes
- **Pagination**: Use proper pagination to avoid large result sets

**Implementation Example:**
```javascript
// Monitor read/write patterns
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "metric_data_queries": [
    {
      "id": "read_efficiency",
      "metric_stat": {
        "metric": {
          "namespace": "AWS/DynamoDB",
          "metric_name": "ConsumedReadCapacityUnits",
          "dimensions": [{"Name": "TableName", "Value": "my-table"}]
        },
        "period": 3600,
        "stat": "Sum"
      }
    },
    {
      "id": "write_efficiency",
      "metric_stat": {
        "metric": {
          "namespace": "AWS/DynamoDB",
          "metric_name": "ConsumedWriteCapacityUnits",
          "dimensions": [{"Name": "TableName", "Value": "my-table"}]
        },
        "period": 3600,
        "stat": "Sum"
      }
    }
  ],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z"
})
```

### 4. Storage Class Optimization

**Strategy Overview:**
Use appropriate table classes based on access patterns to optimize storage costs.

**Standard Class:**
- **Use for**: Frequently accessed data
- **Cost**: $0.10 per GB-month
- **Best for**: Active applications, real-time workloads

**Standard Infrequent Access (Standard-IA):**
- **Use for**: Infrequently accessed data
- **Cost**: Lower storage cost, higher access cost
- **Best for**: Archive data, backup tables, historical records

**Implementation:**
```javascript
// Analyze storage costs by table class
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon DynamoDB\"]}, \"And\": [{\"Dimensions\": {\"Key\": \"USAGE_TYPE\", \"Values\": [\"TimedStorage-ByteHrs\"]}}]}"
})
```

### 5. Global Tables Cost Management

**Strategy Overview:**
Optimize Global Tables configuration to balance availability requirements with cost implications.

**Cost Considerations:**
- Each region incurs separate storage costs
- Replicated write capacity units (rWCU) charged at $0.000975 per hour
- Cross-region data transfer charges apply
- TTL is not free with Global Tables

**Optimization Techniques:**
- **Selective Replication**: Only replicate necessary tables
- **Regional Optimization**: Place tables in regions closest to users
- **Write Optimization**: Minimize cross-region writes
- **Monitoring**: Track replication costs separately

**Implementation:**
```javascript
// Monitor Global Tables costs
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"REGION\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon DynamoDB\"]}}"
})
```

### 6. Backup and Recovery Optimization

**Strategy Overview:**
Balance data protection requirements with backup costs through strategic backup configuration.

**Backup Options:**
- **Point-in-Time Recovery (PITR)**: $0.20 per GB-month, 35-day retention
- **On-Demand Backups**: $0.10 per GB-month, custom retention
- **Cross-Region Backup**: Additional data transfer costs

**Optimization Strategies:**
- Use PITR only for critical tables
- Implement lifecycle policies for on-demand backups
- Consider application-level backup strategies for cost-sensitive workloads
- Use S3 export for long-term archival at lower cost

**Cost Analysis:**
```javascript
// Monitor backup costs
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"API_OPERATION\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon DynamoDB\"]}, \"And\": [{\"Dimensions\": {\"Key\": \"API_OPERATION\", \"Values\": [\"BackupStorage\", \"RestoreTableFromBackup\"]}}]}"
})
```

---

## Common Cost Pitfalls & Solutions

### Pitfall 1: Using On-Demand for Steady Workloads

**Problem Description:**
Using On-Demand pricing for predictable, steady workloads results in 70% higher costs compared to Provisioned mode.

**Detection:**
```javascript
// Analyze traffic consistency
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "AWS/DynamoDB",
  "metric_name": "ConsumedReadCapacityUnits",
  "dimensions": [{"Name": "TableName", "Value": "my-table"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "period": 86400,
  "statistics": ["Average", "Maximum", "Minimum"]
})
```

**Solution:**
- Switch to Provisioned mode for tables with <50% daily variation
- Implement auto-scaling with 70% target utilization
- Monitor for 2-4 weeks before making capacity adjustments

### Pitfall 2: Over-Provisioning Capacity

**Problem Description:**
Provisioning more capacity than needed due to poor traffic analysis or fear of throttling.

**Detection:**
```javascript
// Check capacity utilization
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "metric_data_queries": [
    {
      "id": "utilization",
      "expression": "consumed / provisioned * 100",
      "label": "Capacity Utilization %"
    },
    {
      "id": "consumed",
      "metric_stat": {
        "metric": {
          "namespace": "AWS/DynamoDB",
          "metric_name": "ConsumedReadCapacityUnits"
        },
        "period": 3600,
        "stat": "Average"
      }
    },
    {
      "id": "provisioned",
      "metric_stat": {
        "metric": {
          "namespace": "AWS/DynamoDB",
          "metric_name": "ProvisionedReadCapacityUnits"
        },
        "period": 3600,
        "stat": "Average"
      }
    }
  ],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z"
})
```

**Solution:**
- Target 70% average utilization for cost optimization
- Use auto-scaling to handle traffic spikes
- Regularly review and adjust baseline capacity

### Pitfall 3: Inefficient Query Patterns

**Problem Description:**
Using Scan operations instead of Query, or retrieving unnecessary data, leading to excessive capacity consumption.

**Detection:**
Monitor throttling events and high capacity consumption without corresponding business value.

**Solution:**
- Always use Query instead of Scan when possible
- Implement proper GSI design for access patterns
- Use projection expressions to retrieve only needed attributes
- Implement pagination for large result sets

---

## Best Practices Summary

### ✅ Do:

- **Choose the right capacity mode** based on traffic predictability
- **Use auto-scaling** with 70% target utilization for cost optimization
- **Optimize query patterns** - prefer Query over Scan operations
- **Use eventually consistent reads** when strong consistency isn't required
- **Monitor capacity utilization** regularly and adjust accordingly

### ❌ Don't:

- **Use On-Demand for predictable workloads** - can cost 70% more
- **Over-provision capacity** - target 70% utilization for cost efficiency
- **Enable PITR on all tables** - only use for critical data
- **Ignore Global Tables costs** - replication and cross-region charges add up
- **Use Scan operations** when Query would work - much more expensive

### 🔄 Regular Review Cycle:

- **Weekly:** Monitor capacity utilization and throttling events
- **Monthly:** Review capacity mode decisions and auto-scaling effectiveness
- **Quarterly:** Assess table class optimization and backup strategies
- **Annually:** Review Global Tables necessity and regional optimization

---

**Service Code:** `AmazonDynamoDB`  
**Last Updated:** January 6, 2025  
**Review Cycle:** Monthly