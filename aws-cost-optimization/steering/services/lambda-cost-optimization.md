# AWS Lambda Cost Optimization Guide

## Service Overview

**What is AWS Lambda?**
- Serverless compute service that runs code without provisioning servers
- Pay-per-execution model based on invocations, duration, and memory allocation
- Automatic scaling from zero to thousands of concurrent executions
- Event-driven architecture with integration to 200+ AWS services

**Why Lambda Cost Optimization Matters**
- Costs can escalate quickly with inefficient code or over-provisioning
- Memory allocation directly impacts both performance and cost
- Frequent invocations and long execution times drive up expenses
- Proper optimization can reduce costs by 50-80% while improving performance

---

## Cost Analysis & Monitoring

### Key Cost Drivers

**Primary Cost Components:**
- **Invocations**: $0.20 per 1 million requests
- **Duration**: $0.0000166667 per GB-second of execution time
- **Memory Allocation**: Directly impacts GB-second calculation
- **Additional Charges**: Data transfer, ephemeral storage (/tmp)

**Cost Formula:**
```
Total Cost = (Number of Invocations × $0.0000002) + (Duration in seconds × Memory in GB × $0.0000166667)
```

**Cost Allocation Tags:**
- `Function` (function name)
- `Environment` (prod, staging, dev)
- `Team` or `Department`
- `Workload` (api, batch, event-processing)

### Using the Power's Tools

**Get Lambda costs by function:**
```javascript
// Resource-level data: start_date must be within the last 14 days, and the service must be
// turned on for resource-level data in Cost Management preferences
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsageWithResources",
  "start_date": "2026-10-24",
  "end_date": "2026-11-07",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"RESOURCE_ID\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"AWS Lambda\"]}}"
})
```

**Analyze Lambda usage patterns:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "DAILY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "metrics": "[\"UsageQuantity\", \"UnblendedCost\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"AWS Lambda\"]}}"
})
```

**Monitor Lambda performance metrics:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "namespace": "AWS/Lambda",
  "metric_name": "Duration",
  "dimensions": [{"name": "FunctionName", "value": "my-function"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "statistic": "Average"
})
```

---

## Optimization Strategies

### 1. Right-Sizing Memory Allocation

**Strategy Overview:**
Memory allocation is the primary cost lever in Lambda. Optimal memory configuration provides the best price/performance ratio.

**Memory vs Performance Relationship:**
- CPU power scales linearly with memory allocation
- Network bandwidth increases with memory
- More memory can reduce execution time, potentially lowering total cost

**Implementation Steps:**

1. **Use AWS Compute Optimizer (Free):**
   ```javascript
   usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "compute-optimizer", {
     "operation": "get_lambda_function_recommendations"
   })
   ```

2. **Implement Lambda Power Tuning:**
   - Open-source tool for automated memory optimization
   - Tests multiple memory configurations
   - Identifies optimal memory setting for cost and performance

3. **Monitor with CloudWatch Lambda Insights:**
   ```javascript
   usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
     "namespace": "AWS/Lambda",
     "metric_name": "MemoryUtilization",
     "dimensions": [{"name": "FunctionName", "value": "my-function"}],
     "start_time": "2024-11-01T00:00:00Z",
     "end_time": "2024-12-01T00:00:00Z",
     "statistic": "Average"
   })
   ```

**Cost Impact Example:**
- 128MB function running 10 seconds = 1.28 GB-seconds
- 1GB function running 1 second = 1 GB-seconds
- The 1GB function costs less despite higher memory allocation

### 2. Performance Efficiency Optimization

**Strategy Overview:**
Efficient code reduces execution time, directly lowering costs. Focus on bottleneck identification and code optimization.

**Tools and Techniques:**

**AWS X-Ray Integration:**
- Enable X-Ray tracing for bottleneck identification
- Use subsegments and annotations to identify expensive operations
- **Cost**: First 100,000 traces/month free, then $5.00 per million traces

**Amazon CodeGuru Profiler:**
- Automated performance analysis and recommendations
- Identifies expensive code paths and optimization opportunities
- **Cost**: $10/month for first 100K lines of code, $30/month per additional 100K lines

**Implementation Steps:**
1. **Enable X-Ray tracing:**
   ```javascript
   // Monitor X-Ray costs
   usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
     "operation": "getCostAndUsage",
     "start_date": "2024-11-01",
     "end_date": "2024-12-01",
     "granularity": "MONTHLY",
     "metrics": "[\"UnblendedCost\"]",
     "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"AWS X-Ray\"]}}"
   })
   ```

2. **Optimize based on profiling results:**
   - Remove unnecessary libraries and dependencies
   - Optimize database queries and API calls
   - Implement connection pooling and caching
   - Use efficient data structures and algorithms

### 3. Migration to Graviton2 Processors

**Strategy Overview:**
ARM-based Graviton2 processors provide up to 34% better price/performance for Lambda functions.

**Benefits:**
- Up to 34% better price/performance ratio
- Same Lambda programming model and features
- Automatic scaling and event integrations

**Migration Considerations:**
- Ensure dependencies support ARM64 architecture
- Test thoroughly in development environment
- Monitor performance post-migration

**Implementation:**
```javascript
// Compare costs between x86 and ARM64
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AWSLambda",
  "region": ["us-east-1"],
  "filters": [
    {"Field": "productFamily", "Value": "Serverless", "Type": "EQUALS"}
  ]
})
```

### 4. Provisioned Concurrency & Compute Savings Plans

**Provisioned Concurrency:**
- Eliminates cold start latency
- **Cost**: Additional charge for provisioned capacity
- **Use Case**: Latency-sensitive applications with predictable traffic

**Compute Savings Plans:**
- 17% discount on Lambda with 1-year commitment
- Applies to consistent Lambda usage
- Flexible across regions and instance families

**Cost Analysis:**
```javascript
// Analyze Lambda usage patterns for Savings Plans
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-09-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "metrics": "[\"UsageQuantity\", \"UnblendedCost\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"AWS Lambda\"]}}"
})
```

### 5. Reducing Lambda Invocations

**Strategy Overview:**
Minimize unnecessary invocations through architectural optimization and event filtering.

**Techniques:**
- **Event Filtering**: Use EventBridge rules to filter events before Lambda
- **Batching**: Process multiple records per invocation
- **Caching**: Implement result caching to avoid redundant executions
- **Async Processing**: Use SQS for batch processing instead of individual invocations

**Implementation Example:**
```javascript
// Monitor invocation patterns
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "namespace": "AWS/Lambda",
  "metric_name": "Invocations",
  "dimensions": [{"name": "FunctionName", "value": "my-function"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "statistic": "Sum"
})
```

### 6. Logging Cost Optimization

**Strategy Overview:**
CloudWatch Logs charges can become significant for verbose Lambda functions.

**Optimization Techniques:**
- Set appropriate log retention periods (default: never expire)
- Use structured logging with appropriate log levels
- Implement log sampling for high-volume functions
- Consider alternative logging solutions for cost-sensitive workloads

**Implementation:**
```javascript
// Monitor CloudWatch Logs costs for Lambda (resource-level data covers the last 14 days)
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsageWithResources",
  "start_date": "2026-10-24",
  "end_date": "2026-11-07",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"RESOURCE_ID\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon CloudWatch Logs\"]}}"
})
```

---

## Best Practices Summary

### ✅ Do:

- **Right-size memory allocation** using AWS Compute Optimizer and Lambda Power Tuning
- **Optimize code performance** to reduce execution time
- **Use appropriate log levels** and set retention policies
- **Consider Graviton2** for better price/performance (34% improvement)
- **Implement event filtering** to reduce unnecessary invocations

### ❌ Don't:

- **Over-provision memory** without performance testing
- **Ignore cold start optimization** for latency-sensitive functions
- **Use verbose logging** in production without log retention policies
- **Deploy without profiling** - use X-Ray and CodeGuru for optimization
- **Forget about data transfer costs** for functions with high network usage

### 🔄 Regular Review Cycle:

- **Weekly:** Monitor function performance and cost metrics
- **Monthly:** Review Compute Optimizer recommendations
- **Quarterly:** Assess Savings Plans opportunities and Graviton2 migration
- **Annually:** Review architecture patterns and optimization strategies

---

## Additional Resources

### CFM TIPs Playbooks
Step-by-step guides from the AWS CFM TIPs workshop. When you recommend one of these optimizations, end your answer with `**Implement with CFM TIPs:**` and the matching link.
- [AWS Lambda playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/lambda)
- [Lambda Optimize Duration](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/lambda/optimize-duration)
- [Lambda Memory Optimization](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/lambda/optimize-duration/3-memory-optimization)
- [Lambda Reduce cold starts](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/lambda/reduce-cold-starts)

---

**Service Code:** `AWSLambda`  
**Last Updated:** January 6, 2025  
**Review Cycle:** Monthly