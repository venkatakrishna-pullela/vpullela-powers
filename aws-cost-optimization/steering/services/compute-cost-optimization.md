# Compute Cost Optimization Guide

> **Navigation:** [← Tool Selection Guide](../tool-selection-guide.md) | [All Service Guides](./README.md) | [Power Overview](../../POWER.md)

## Service Overview

**What is AWS Compute?**
- Comprehensive compute services including EC2, Auto Scaling, Elastic Load Balancing, and AWS Batch
- Foundation for most AWS workloads with flexible instance types and pricing models
- Supports diverse workload patterns from web applications to high-performance computing

**Why Cost Optimization Matters**
- Compute typically represents 40-60% of total AWS spend for most organizations
- Instance right-sizing alone can reduce costs by 20-30% without performance impact
- Proper instance family selection and generation upgrades can provide additional 10-20% savings

---

## Cost Analysis & Monitoring

### Key Cost Metrics to Track

**Primary Cost Drivers:**
- Instance hours and on-demand vs reserved pricing - 60-80% of compute costs
- Data transfer and EBS storage attached to instances - 10-20% of compute costs
- Load balancer hours and processed bytes - 5-15% of compute costs

**Cost Allocation Tags:**
- Environment (production, staging, development)
- Application or service name
- Team or cost center ownership
- Instance purpose (web, database, batch processing)

### Using the Power's Tools

**Get EC2 costs by instance type:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"INSTANCE_TYPE\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"]}}"
})
```

**Analyze compute usage patterns:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "DAILY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "metrics": "[\"UsageQuantity\", \"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"]}}"
})
```

**Get EC2 pricing information:**
```javascript
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonEC2",
  "region": ["us-east-1", "us-west-2"],
  "filters": [
    {"Field": "instanceType", "Value": "m5.large", "Type": "EQUALS"},
    {"Field": "tenancy", "Value": "Shared", "Type": "EQUALS"},
    {"Field": "operating-system", "Value": "Linux", "Type": "EQUALS"}
  ]
})
```

**Monitor EC2 utilization for cost correlation:**
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
```

**Create compute efficiency metrics:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "metric_data_queries": [
    {
      "id": "cpu_utilization",
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
      "expression": "cpu_utilization / 100"
    }
  ],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z"
})
```

---

## Optimization Strategies

### 1. Right-Sizing & Performance Optimization

**Strategy Overview:**
- Identify over-provisioned instances running at low utilization
- Match instance types to actual workload requirements
- Balance performance needs with cost efficiency

**Implementation Steps:**
1. **Analyze current utilization:**
   ```javascript
   usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "compute_optimizer", {
     "operation": "get_ec2_instance_recommendations"
   })
   ```

2. **Review recommendations:**
   - Target instances with <40% average CPU utilization
   - Consider memory and network requirements beyond CPU
   - Plan changes during maintenance windows

3. **Monitor post-optimization:**
   - Track application performance metrics
   - Monitor cost reduction (typically 20-30% savings)
   - Set up alerts for performance degradation

### 2. Instance Generation Upgrades

**When to Upgrade Generations:**
- Current generation instances offer 10-20% better price-performance
- Newer generations include enhanced networking and storage capabilities
- Memory-optimized workloads benefit significantly from newer generations

**Analysis Commands:**
```javascript
// Check current instance generations in use
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"INSTANCE_TYPE\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"]}}"
})

// Compare pricing between generations
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonEC2",
  "region": ["us-east-1"],
  "filters": [
    {"Field": "instanceFamily", "Value": "General purpose", "Type": "EQUALS"}
  ]
})
```

### 3. Instance Family Optimization

**Cost-Efficient Instance Families:**
- **General Purpose (T, M family):** Balanced CPU, memory, networking for most workloads
- **Compute Optimized (C family):** High-performance processors for CPU-intensive tasks
- **Memory Optimized (R, X, Z family):** High memory-to-CPU ratio for in-memory databases
- **Storage Optimized (I, D family):** High sequential read/write for data warehousing

**Family Selection Guidelines:**
- T instances for variable workloads with CPU credits (up to 40% cost savings)
- M instances for steady-state general purpose workloads
- C instances for compute-intensive applications (better price-performance than oversized M instances)
- R instances for memory-intensive applications (avoid oversized general purpose instances)

### 4. Reserved Instances & Savings Plans

**When to Use Reserved Capacity:**
- Steady-state workloads running 24/7 with predictable usage
- Minimum 70% utilization over 1-3 year terms
- Up to 72% savings compared to on-demand pricing

**Analysis Commands:**
```javascript
// Check current Reserved Instance utilization
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "ri_performance", {
  "operation": "get_reservation_utilization",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"]}}"
})

// Check Compute Savings Plans coverage
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "sp_performance", {
  "operation": "get_savings_plans_coverage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"]}}"
})
```

### 5. Auto Scaling Optimization

**Automated Cost Controls:**
- Configure Auto Scaling groups to match demand patterns
- Use predictive scaling for known traffic patterns
- Implement scheduled scaling for batch workloads

**Implementation Examples:**
- Set target tracking policies based on CPU, memory, or custom metrics
- Configure scale-in protection for critical instances
- Use mixed instance types and Spot instances in Auto Scaling groups

### 6. Spot Instance Integration

**Cost-Effective Spot Usage:**
- Fault-tolerant workloads can achieve 50-90% cost savings
- Batch processing, CI/CD, and development environments ideal for Spot
- Use Spot Fleet or Auto Scaling with mixed instance types

**Implementation Strategy:**
```javascript
// Monitor Spot price history for planning
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonEC2",
  "region": ["us-east-1"],
  "filters": [
    {"Field": "marketoption", "Value": "Spot", "Type": "EQUALS"}
  ]
})
```

---

## Common Cost Pitfalls & Solutions

### Pitfall 1: Over-Provisioned Instances

**Problem Description:**
- Instances running at consistently low utilization (<40% CPU)
- Choosing instance types based on peak requirements rather than average
- Not monitoring actual resource consumption post-deployment

**Detection:**
```javascript
// Identify underutilized instances
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "AWS/EC2",
  "metric_name": "CPUUtilization",
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "period": 3600,
  "statistics": ["Average"]
})
```

**Solution:**
- Use AWS Compute Optimizer recommendations for right-sizing
- Implement gradual downsizing with performance monitoring
- Set up CloudWatch alarms for utilization thresholds

### Pitfall 2: Using Outdated Instance Generations

**Problem Description:**
- Running older generation instances (m4, c4, r4) instead of current generation
- Missing 10-20% price-performance improvements from newer generations
- Paying premium for legacy instance types with limited availability

**Detection & Solution:**
- Audit current instance types using Cost Explorer
- Plan migration to current generation instances (m5, c5, r5, or newer)
- Test performance impact in non-production environments first

### Pitfall 3: Inefficient Reserved Instance Management

**Problem Description:**
- Purchasing Reserved Instances without proper utilization analysis
- Wrong instance type or availability zone selections
- Not monitoring RI utilization and coverage over time

**Detection & Solution:**
- Use RI Utilization reports to identify unused reservations
- Implement RI modification or exchange when possible
- Consider Savings Plans for more flexibility across instance families

---

## Real-World Scenarios

### Scenario 1: E-commerce Platform Right-Sizing

**Situation:**
- Mid-size e-commerce company running 200+ EC2 instances
- Mix of web servers, application servers, and database instances
- Monthly compute costs of $45,000 with variable traffic patterns

**Analysis Approach:**
```javascript
// Step 1: Analyze current compute costs by instance type
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-10-01",
  "end_date": "2024-11-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"INSTANCE_TYPE\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"]}}"
})

// Step 2: Get right-sizing recommendations
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "compute_optimizer", {
  "operation": "get_ec2_instance_recommendations"
})

// Step 3: Analyze utilization patterns
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "AWS/EC2",
  "metric_name": "CPUUtilization",
  "start_time": "2024-10-01T00:00:00Z",
  "end_time": "2024-11-01T00:00:00Z",
  "period": 3600,
  "statistics": ["Average", "Maximum"]
})
```

**Solution Implementation:**
- Right-sized 60% of instances from m5.large to m5.medium (25% cost reduction)
- Migrated database instances from m5 to r5 family (15% better price-performance)
- Implemented Auto Scaling for web tier (30% reduction in over-provisioning)

**Results:**
- **Cost Savings:** $13,500/month (30% reduction)
- **Performance Impact:** No degradation, improved response times
- **Implementation Time:** 6 weeks with staged rollout

### Scenario 2: Development Environment Optimization

**Situation:**
- Software company with 50+ development environments
- Instances running 24/7 but only used during business hours
- $8,000/month in compute costs for non-production workloads

**Analysis Approach:**
```javascript
// Analyze development environment usage patterns
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-10-01",
  "end_date": "2024-11-01",
  "granularity": "DAILY",
  "group_by": "[{\"Type\": \"TAG\", \"Key\": \"Environment\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Tags\": {\"Key\": \"Environment\", \"Values\": [\"development\", \"staging\"]}}"
})
```

**Solution Implementation:**
- Implemented scheduled start/stop for development instances (60% time savings)
- Migrated to Spot instances for fault-tolerant development workloads (70% cost reduction)
- Right-sized instances based on actual development needs

**Results:**
- **Cost Savings:** $5,600/month (70% reduction)
- **Developer Impact:** Minimal with automated scheduling
- **Additional Benefits:** Faster environment provisioning

---

## Integration with Other Services

### Cost Impact of Service Integrations

**Common Integration Patterns:**
- EBS volumes attached to EC2 instances (storage costs)
- Elastic Load Balancers distributing traffic (networking costs)
- Auto Scaling groups managing instance lifecycle (operational costs)
- CloudWatch monitoring and logging (observability costs)

**Cross-Service Optimization:**
- Co-locate related services in same availability zones to reduce data transfer costs
- Use instance store volumes when possible to reduce EBS costs
- Optimize load balancer configurations to reduce processing costs

**Analysis Commands:**
```javascript
// Analyze compute-related costs across services
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"SERVICE\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\", \"Amazon Elastic Block Store\", \"Amazon Elastic Load Balancing\"]}}"
})
```

---

## Monitoring & Alerting

### Key Metrics to Monitor

**Cost Metrics:**
- Daily compute spend trends and monthly forecasts
- Cost per instance hour across different instance types
- Reserved Instance utilization and coverage percentages

**Usage Metrics:**
- CPU, memory, and network utilization across instance fleet
- Instance launch and termination patterns
- Auto Scaling group scaling activities

**Operational Metrics (via CloudWatch):**
- Instance health check failures that may indicate sizing issues
- Application performance metrics correlated with instance types
- Resource utilization efficiency ratios

### Recommended Alerts

**Budget Alerts:**
```javascript
// Monitor compute budget performance
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "budgets", {
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"]}}"
})
```

**Anomaly Detection:**
```javascript
// Set up anomaly monitoring for compute costs
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_anomaly", {
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "filters": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"]}}"
})
```

**Utilization Alerts:**
```javascript
// Monitor low utilization instances
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "describe_alarms", {
  "alarm_name_prefix": "LowCPUUtilization",
  "state_value": "ALARM"
})
```

### Dashboard Creation

**Key Visualizations:**
- Compute cost trends by instance type and family
- Utilization vs cost correlation charts
- Reserved Instance utilization tracking
- Right-sizing opportunity identification

**Implementation:**
```javascript
// Get existing compute dashboards
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "list_dashboards", {})

// Create custom compute cost dashboard
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_dashboard", {
  "dashboard_name": "ComputeCostOptimization"
})
```

---

## Best Practices Summary

### ✅ Do:

- **Monitor utilization continuously** - Set up CloudWatch alarms for instances below 40% CPU utilization
- **Right-size regularly** - Review and adjust instance types quarterly based on actual usage patterns
- **Use current generation instances** - Migrate to latest generation instances for 10-20% better price-performance
- **Implement Auto Scaling** - Use Auto Scaling groups to match capacity with demand automatically
- **Consider Spot instances** - Use Spot instances for fault-tolerant workloads to achieve 50-90% savings

### ❌ Don't:

- **Over-provision for peak loads** - Use Auto Scaling instead of permanently large instances
- **Ignore Reserved Instance utilization** - Monitor RI usage and modify or exchange underutilized reservations
- **Run development environments 24/7** - Implement scheduling to stop non-production instances during off-hours
- **Choose instances based on CPU alone** - Consider memory, network, and storage requirements holistically
- **Forget about data transfer costs** - Co-locate related services to minimize cross-AZ data transfer charges

### 🔄 Regular Review Cycle:

- **Weekly:** Review utilization metrics and identify optimization opportunities
- **Monthly:** Analyze cost trends and Reserved Instance utilization
- **Quarterly:** Comprehensive right-sizing review and instance generation upgrades
- **Annually:** Reserved Instance and Savings Plans strategy review

---

## Additional Resources

### AWS Documentation
- [EC2 Instance Types and Pricing](https://aws.amazon.com/ec2/instance-types/)
- [AWS Compute Optimizer User Guide](https://docs.aws.amazon.com/compute-optimizer/)
- [EC2 Auto Scaling Best Practices](https://docs.aws.amazon.com/autoscaling/ec2/userguide/auto-scaling-benefits.html)

### Tools & Calculators
- [AWS Pricing Calculator](https://calculator.aws/) for compute cost estimation
- [AWS Cost Explorer](https://aws.amazon.com/aws-cost-management/aws-cost-explorer/) for usage analysis
- [AWS Trusted Advisor](https://aws.amazon.com/premiumsupport/technology/trusted-advisor/) for optimization recommendations

### Related Power Guidance
- [Graviton Cost Optimization](./graviton-cost-optimization.md) for ARM-based instance optimization
- [Reserved Instances Cost Optimization](./reserved-instances-cost-optimization.md) for commitment-based savings
- [Monitoring Cost Optimization](./monitoring-cost-optimization.md) for CloudWatch cost management

---

**Service Code:** `AmazonEC2`  
**Last Updated:** January 6, 2026  
**Review Cycle:** Quarterly