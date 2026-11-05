# {SERVICE_NAME} Cost Optimization Guide

> **Navigation:** [← Tool Selection Guide](../tool-selection-guide.md) | [All Service Guides](./README.md) | [Power Overview](../../POWER.md)

## Service Overview

**What is {SERVICE_NAME}?**
- Brief description of the service and its primary use cases
- Common deployment patterns and architectures
- Typical cost drivers and billing model

**Why Cost Optimization Matters**
- Service-specific cost challenges and opportunities
- Impact on overall AWS spend (percentage of typical bills)
- Common cost surprises or gotchas

---

## Cost Analysis & Monitoring

### Key Cost Metrics to Track

**Primary Cost Drivers:**
- {Driver 1} - Description and typical cost impact
- {Driver 2} - Description and typical cost impact
- {Driver 3} - Description and typical cost impact

**Cost Allocation Tags:**
- Recommended tagging strategy for this service
- Service-specific tag keys for cost tracking
- Examples of effective cost allocation

### Using the Power's Tools

**Get {SERVICE_NAME} costs by dimension:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"SERVICE\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"{AWS_SERVICE_CODE}\"]}}"
})
```

**Analyze {SERVICE_NAME} usage patterns:**
```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "DAILY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "metrics": "[\"UsageQuantity\", \"UnblendedCost\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"{AWS_SERVICE_CODE}\"]}}"
})
```

**Get pricing information:**
```javascript
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "{AWS_SERVICE_CODE}",
  "region": ["us-east-1", "us-west-2"],
  "filters": [
    {"Field": "{PRICING_DIMENSION}", "Value": "{VALUE}", "Type": "EQUALS"}
  ]
})
```

**Monitor resource utilization for cost correlation:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "namespace": "AWS/{SERVICE_NAMESPACE}",
  "metric_name": "{UTILIZATION_METRIC}",
  "dimensions": [{"name": "{DIMENSION_NAME}", "value": "{RESOURCE_ID}"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "statistic": "Average"
})
```

**Create cost efficiency metrics:**
```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "queries": [
    {
      "id": "utilization",
      "metric_stat": {
        "namespace": "AWS/{SERVICE_NAMESPACE}",
        "metric_name": "{UTILIZATION_METRIC}",
        "dimensions": [{"name": "{DIMENSION_NAME}", "value": "{RESOURCE_ID}"}],
        "statistic": "Average",
        "period": 3600
      }
    },
    {"id": "efficiency", "expression": "utilization / 100"}
  ],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z"
})
```

---

## Optimization Strategies

### 1. Right-Sizing & Performance Optimization

**Strategy Overview:**
- How to identify over-provisioned resources
- Performance vs cost trade-offs
- Monitoring and adjustment cycles

**Implementation Steps:**
1. **Analyze current utilization:**
   ```javascript
   usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "compute-optimizer", {
     "operation": "get_{service}_recommendations"
   })
   ```

2. **Review recommendations:**
   - Specific metrics to evaluate
   - Risk assessment for changes
   - Implementation timeline

3. **Monitor post-optimization:**
   - Key performance indicators
   - Cost impact measurement
   - Rollback procedures if needed

### 2. Reserved Capacity & Savings Plans

**When to Use Reserved Capacity:**
- Usage patterns that benefit from commitments
- Minimum utilization thresholds
- Term length considerations

**Analysis Commands:**
```javascript
// Check current Reserved Instance utilization
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "ri-performance", {
  "operation": "get_reservation_utilization",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"{AWS_SERVICE_CODE}\"]}}"
})

// Check Savings Plans coverage
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "sp-performance", {
  "operation": "get_savings_plans_coverage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"{AWS_SERVICE_CODE}\"]}}"
})
```

### 3. Architecture Optimization

**Cost-Efficient Architecture Patterns:**
- Service-specific architectural best practices
- Integration patterns that reduce costs
- Anti-patterns to avoid

**Design Considerations:**
- Trade-offs between cost and other factors (performance, availability, security)
- Regional deployment strategies
- Multi-service integration optimization

### 4. Lifecycle Management

**Automated Cost Controls:**
- Scheduling and auto-scaling strategies
- Cleanup and retention policies
- Monitoring and alerting setup

**Implementation Examples:**
- Specific automation scripts or configurations
- Integration with AWS native tools
- Third-party tool recommendations

### 5. Operational Monitoring & Alerting

**Cost-Performance Correlation:**
- Monitor resource utilization metrics that impact cost
- Set up efficiency-based alerting (cost per unit of work)
- Create dashboards combining cost and operational metrics

**Implementation Examples:**
```javascript
// Monitor cost-related alarms
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_active_alarms", {
  "max_items": 50  // returns alarms in ALARM state; look for names starting with "{SERVICE_NAME}Cost"
})

// Analyze utilization patterns
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "namespace": "AWS/{SERVICE_NAMESPACE}",
  "metric_name": "{KEY_UTILIZATION_METRIC}",
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "statistic": "Average"
})
```

---

## Common Cost Pitfalls & Solutions

### Pitfall 1: {COMMON_ISSUE_1}

**Problem Description:**
- What causes this issue
- How it impacts costs
- How common it is

**Detection:**
```javascript
// Tool command to identify this issue
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-anomaly", {
  "start_date": "2024-11-01",
  "end_date": "2024-12-01"
})
```

**Solution:**
- Step-by-step remediation
- Prevention strategies
- Monitoring to avoid recurrence

### Pitfall 2: {COMMON_ISSUE_2}

**Problem Description:**
- Detailed explanation of the issue
- Cost impact examples
- Warning signs to watch for

**Detection & Solution:**
- Similar structure as Pitfall 1

### Pitfall 3: {COMMON_ISSUE_3}

**Problem Description:**
- Another common cost issue
- Real-world examples
- Impact on different organization sizes

**Detection & Solution:**
- Consistent format for all pitfalls

---

## Real-World Scenarios

### Scenario 1: {REALISTIC_SCENARIO_1}

**Situation:**
- Detailed description of a common real-world scenario
- Organization size and context
- Initial cost challenges

**Analysis Approach:**
```javascript
// Step 1: Analyze current costs
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  // Specific parameters for this scenario
})

// Step 2: Get optimization recommendations
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-optimization", {
  // Targeted filters for this use case
})

// Step 3: Analyze pricing alternatives
usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  // Comparison parameters
})
```

**Solution Implementation:**
- Step-by-step optimization process
- Expected cost savings
- Implementation timeline and risks

**Results:**
- Quantified cost savings achieved
- Performance impact (if any)
- Lessons learned

### Scenario 2: {REALISTIC_SCENARIO_2}

**Similar structure for additional scenarios**

---

## Integration with Other Services

### Cost Impact of Service Integrations

**Common Integration Patterns:**
- How this service typically integrates with others
- Cost implications of different integration approaches
- Data transfer and networking costs

**Cross-Service Optimization:**
- Opportunities to optimize costs across service boundaries
- Shared resource strategies
- Regional co-location benefits

**Analysis Commands:**
```javascript
// Analyze cross-service costs
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"SERVICE\"}]",
  "metrics": "[\"UnblendedCost\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"{AWS_SERVICE_CODE}\", \"{RELATED_SERVICE_1}\", \"{RELATED_SERVICE_2}\"]}}"
})
```

---

## Monitoring & Alerting

### Key Metrics to Monitor

**Cost Metrics:**
- Daily/monthly spend trends
- Cost per unit metrics (e.g., cost per request, cost per GB)
- Budget variance and forecasting

**Usage Metrics:**
- Resource utilization rates
- Performance indicators that impact cost
- Efficiency ratios

**Operational Metrics (via CloudWatch):**
- Service-specific utilization metrics
- Performance thresholds that affect cost
- Error rates that may indicate inefficient resource usage

### Recommended Alerts

**Budget Alerts:**
```javascript
// Monitor service-specific budget performance
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "budgets", {})
```

**Anomaly Detection:**
```javascript
// Set up anomaly monitoring for this service
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-anomaly", {
  "start_date": "2024-11-01",
  "end_date": "2024-12-01"
})
```

**Operational Alerts:**
```javascript
// Monitor cost-related operational alarms
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_active_alarms", {
  "max_items": 50  // returns alarms in ALARM state; look for names starting with "{SERVICE_NAME}"
})
```

### Dashboard Creation

**Key Visualizations:**
- Cost trend charts
- Usage vs cost correlation
- Optimization opportunity tracking
- Resource utilization efficiency metrics

**Implementation:**
The CloudWatch MCP server can't read or create dashboards. Build the dashboard in the CloudWatch console or with infrastructure as code, and use `get_metric_data` to check each metric before you chart it. For organization-wide cost dashboards, see [Cloud Intelligence Dashboards](https://catalog.workshops.aws/awscff/en-US/visualizations/3-cid).

**Custom Metrics Creation:**
- CloudWatch dashboard setup
- Third-party tool integration
- Custom reporting automation

---

## Best Practices Summary

### ✅ Do:

- **Service-specific best practice 1** - Detailed explanation
- **Service-specific best practice 2** - Implementation guidance
- **Service-specific best practice 3** - Monitoring recommendations
- **Service-specific best practice 4** - Optimization timing
- **Service-specific best practice 5** - Integration considerations

### ❌ Don't:

- **Common mistake 1** - Why to avoid and alternatives
- **Common mistake 2** - Cost impact and prevention
- **Common mistake 3** - Detection and remediation
- **Common mistake 4** - Risk mitigation strategies
- **Common mistake 5** - Long-term implications

### 🔄 Regular Review Cycle:

- **Weekly:** Usage pattern monitoring and anomaly review
- **Monthly:** Cost trend analysis and budget performance
- **Quarterly:** Architecture review and optimization opportunities
- **Annually:** Reserved capacity planning and contract optimization

---

## Additional Resources

### CFM TIPs Playbooks
Step-by-step guides from the AWS CFM TIPs workshop. When you recommend one of these optimizations, end your answer with `**Implement with CFM TIPs:**` and the matching link.
- {SERVICE_NAME} playbook and key pages, copied from `../cfm-tips-playbooks.md`

### AWS Documentation
- Official {SERVICE_NAME} pricing documentation
- {SERVICE_NAME} best practices guides
- Cost optimization whitepapers

### Tools & Calculators
- AWS Pricing Calculator configurations
- Third-party cost optimization tools
- Community resources and forums

### Related Power Guidance
- Link to relevant steering files in this power
- Cross-references to other optimization strategies
- Integration with broader cost management workflows

---

**Service Code:** `{AWS_SERVICE_CODE}`  
**Last Updated:** {DATE}  
**Review Cycle:** Quarterly