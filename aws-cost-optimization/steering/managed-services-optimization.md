# Managed Services Optimization

> **Navigation:** [← Tool Selection Guide](./tool-selection-guide.md) | [Power Overview](../POWER.md)

This steering file provides comprehensive guidance for optimizing costs by leveraging managed services aligned with the AWS Well-Architected Cost Optimization Pillar's fourth design principle: **Stop Spending Money on Undifferentiated Heavy Lifting**.

## Core Principle

Use managed services to reduce operational overhead, eliminate infrastructure management costs, and focus resources on business-differentiating activities that drive value.

## Key Components

### Managed Service Migration
- **Infrastructure abstraction**: Move from self-managed to AWS-managed infrastructure
- **Operational overhead reduction**: Eliminate maintenance, patching, and management tasks
- **Scalability automation**: Leverage automatic scaling and capacity management
- **Cost optimization**: Benefit from AWS economies of scale and optimization

### Service Selection Strategy
- **Total cost of ownership**: Consider all costs including operational overhead
- **Operational complexity**: Evaluate management and maintenance requirements
- **Scalability requirements**: Assess automatic scaling capabilities
- **Feature alignment**: Match service capabilities with business requirements

### Migration Planning
- **Workload assessment**: Evaluate workloads for managed service suitability
- **Migration prioritization**: Prioritize based on cost savings and complexity
- **Risk assessment**: Evaluate migration risks and mitigation strategies
- **Performance validation**: Ensure performance requirements are met

## Workflow 1: Managed Service Opportunity Assessment

**Goal**: Identify opportunities to replace self-managed infrastructure with managed services

### Steps:

1. **Analyze Current Infrastructure Costs**
   ```
   Use getCostAndUsage to understand:
   - Self-managed infrastructure costs
   - Operational overhead costs
   - Maintenance and management time costs
   - Scaling and capacity management costs
   ```

2. **Identify Managed Service Candidates**
   ```
   Use cost_optimization to find:
   - Services suitable for managed alternatives
   - Infrastructure components with high operational overhead
   - Workloads requiring frequent scaling
   - Components with standardized requirements
   ```

3. **Compare Total Cost of Ownership**
   ```
   Use get_pricing to analyze:
   - Managed service pricing models
   - Cost comparison with self-managed alternatives
   - Operational cost savings potential
   - Long-term cost projections
   ```

### Example Managed Service Assessment:

```javascript
// Step 1: Analyze current self-managed infrastructure costs
const selfManagedCosts = usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"SERVICE\"}]",
  "filter": "{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\", \"Amazon Elastic Block Store\", \"Amazon Virtual Private Cloud\"], \"MatchOptions\": [\"EQUALS\"]}}",
  "metrics": "[\"UnblendedCost\"]"
})

// Step 2: Monitor current infrastructure performance
const infrastructurePerformance = usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "AWS/EC2",
  "metric_name": "CPUUtilization",
  "dimensions": [{"Name": "InstanceType", "Value": "m5.large"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "period": 3600,
  "statistics": ["Average", "Maximum"]
})

// Step 3: Get managed service migration recommendations
const managedServiceRecs = usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_optimization", {
  "operation": "list_recommendations",
  "filters": "{\"actionTypes\": [\"MigrateToGraviton\"], \"implementationEfforts\": [\"Low\", \"Medium\"]}"
})

// Step 4: Compare managed service pricing
const managedServicePricing = usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonRDS",
  "region": ["us-east-1"],
  "filters": [
    {"Field": "instanceType", "Value": "db.t3.medium", "Type": "EQUALS"},
    {"Field": "databaseEngine", "Value": "PostgreSQL", "Type": "EQUALS"},
    {"Field": "deploymentOption", "Value": "Single-AZ", "Type": "EQUALS"}
  ]
})

// Step 5: Monitor operational metrics for comparison
const operationalMetrics = usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "metric_data_queries": [
    {
      "id": "availability",
      "metric_stat": {
        "metric": {
          "namespace": "AWS/ApplicationELB",
          "metric_name": "HealthyHostCount"
        },
        "period": 3600,
        "stat": "Average"
      }
    },
    {
      "id": "response_time",
      "metric_stat": {
        "metric": {
          "namespace": "AWS/ApplicationELB",
          "metric_name": "TargetResponseTime"
        },
        "period": 3600,
        "stat": "Average"
      }
    }
  ],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z"
})

// Step 6: Calculate total cost of ownership comparison
const tcoComparison = usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "session_sql", {
  "query": `
    WITH self_managed AS (
      SELECT 
        'Self-Managed' as option,
        SUM(infrastructure_cost) as infrastructure_cost,
        SUM(operational_cost) as operational_cost,
        SUM(maintenance_cost) as maintenance_cost,
        SUM(infrastructure_cost + operational_cost + maintenance_cost) as total_cost
      FROM cost_analysis
      WHERE service_type = 'self_managed'
    ),
    managed_service AS (
      SELECT 
        'Managed Service' as option,
        SUM(service_cost) as infrastructure_cost,
        0 as operational_cost,
        0 as maintenance_cost,
        SUM(service_cost) as total_cost
      FROM cost_analysis
      WHERE service_type = 'managed'
    )
    SELECT * FROM self_managed
    UNION ALL
    SELECT * FROM managed_service
  `
})
```

## Workflow 2: Database Migration to Managed Services

**Goal**: Migrate self-managed databases to Amazon RDS, Aurora, or other managed database services

### Steps:

1. **Assess Current Database Infrastructure**
   ```
   Use getCostAndUsage to analyze:
   - Database server costs (EC2, storage, networking)
   - Backup and disaster recovery costs
   - Maintenance and patching overhead
   - High availability and scaling costs
   ```

2. **Evaluate Managed Database Options**
   ```
   Use get_pricing to compare:
   - RDS pricing for equivalent capacity
   - Aurora pricing and performance benefits
   - DynamoDB for NoSQL workloads
   - DocumentDB for document databases
   ```

3. **Calculate Migration Benefits**
   ```
   Use generate_cost_report to analyze:
   - Cost savings from managed services
   - Operational overhead reduction
   - Performance improvements
   - Scalability and availability benefits
   ```

### Example Database Migration Analysis:

```javascript
// Step 1: Analyze current database infrastructure costs
const databaseInfrastructure = usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "filter": "{\"And\": [{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"], \"MatchOptions\": [\"EQUALS\"]}}, {\"Tags\": {\"Key\": \"Application\", \"Values\": [\"Database\"], \"MatchOptions\": [\"EQUALS\"]}}]}",
  "metrics": "[\"UnblendedCost\"]"
})

// Step 2: Monitor current database performance
const databasePerformance = usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "AWS/EC2",
  "metric_name": "CPUUtilization",
  "dimensions": [{"Name": "Tag:Application", "Value": "Database"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "period": 3600,
  "statistics": ["Average", "Maximum"]
})

// Step 3: Get RDS pricing for equivalent capacity
const rdsPricing = usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonRDS",
  "region": ["us-east-1"],
  "filters": [
    {"Field": "instanceType", "Value": ["db.r5.large", "db.r5.xlarge"], "Type": "ANY_OF"},
    {"Field": "databaseEngine", "Value": "PostgreSQL", "Type": "EQUALS"},
    {"Field": "deploymentOption", "Value": "Multi-AZ", "Type": "EQUALS"}
  ]
})

// Step 4: Compare Aurora pricing
const auroraPricing = usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonRDS",
  "region": ["us-east-1"],
  "filters": [
    {"Field": "instanceType", "Value": ["db.r5.large", "db.r5.xlarge"], "Type": "ANY_OF"},
    {"Field": "databaseEngine", "Value": "Aurora PostgreSQL", "Type": "EQUALS"}
  ]
})

// Step 5: Monitor database connection and query patterns
const databaseMetrics = usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "metric_data_queries": [
    {
      "id": "connections",
      "metric_stat": {
        "metric": {
          "namespace": "CWAgent",
          "metric_name": "DatabaseConnections",
          "dimensions": [{"Name": "InstanceId", "Value": "i-database-instance"}]
        },
        "period": 3600,
        "stat": "Average"
      }
    },
    {
      "id": "query_time",
      "metric_stat": {
        "metric": {
          "namespace": "CWAgent",
          "metric_name": "QueryExecutionTime",
          "dimensions": [{"Name": "InstanceId", "Value": "i-database-instance"}]
        },
        "period": 3600,
        "stat": "Average"
      }
    }
  ],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z"
})

// Step 6: Generate migration cost-benefit analysis
const migrationAnalysis = usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "generate_cost_report", {
  "pricing_data": {
    "current_infrastructure": databaseInfrastructure,
    "rds_option": rdsPricing,
    "aurora_option": auroraPricing
  },
  "service_name": "Database Migration Analysis",
  "assumptions": [
    "Current database runs 24/7 on dedicated EC2 instances",
    "Requires Multi-AZ deployment for high availability",
    "Includes automated backups and point-in-time recovery",
    "Operational overhead estimated at 20 hours/month"
  ],
  "exclusions": [
    "Migration costs and downtime",
    "Application modification costs",
    "Training and learning curve costs"
  ],
  "recommendations": {
    "immediate": [
      "Start with RDS for immediate operational benefits",
      "Consider Aurora for performance-critical workloads",
      "Implement automated backup and monitoring"
    ],
    "strategic": [
      "Plan for Aurora Serverless for variable workloads",
      "Consider read replicas for read-heavy applications",
      "Implement database performance insights"
    ]
  }
})
```

## Workflow 3: Container Orchestration Migration

**Goal**: Migrate self-managed container orchestration to Amazon ECS, EKS, or Fargate

### Steps:

1. **Assess Current Container Infrastructure**
   ```
   Use getCostAndUsage to analyze:
   - Container host costs (EC2 instances)
   - Orchestration overhead costs
   - Load balancer and networking costs
   - Management and monitoring costs
   ```

2. **Evaluate Managed Container Options**
   ```
   Use get_pricing to compare:
   - ECS with EC2 launch type
   - ECS with Fargate launch type
   - EKS managed service costs
   - Container registry and monitoring costs
   ```

3. **Calculate Serverless Container Benefits**
   ```
   Use analyze_cdk_project to:
   - Analyze container workload patterns
   - Model Fargate pricing for workloads
   - Compare operational overhead reduction
   - Assess scaling and availability benefits
   ```

### Example Container Migration Analysis:

```javascript
// Step 1: Analyze current container infrastructure
const containerInfrastructure = usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost_explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2024-11-01",
  "end_date": "2024-12-01",
  "granularity": "DAILY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "filter": "{\"And\": [{\"Dimensions\": {\"Key\": \"SERVICE\", \"Values\": [\"Amazon Elastic Compute Cloud - Compute\"], \"MatchOptions\": [\"EQUALS\"]}}, {\"Tags\": {\"Key\": \"Environment\", \"Values\": [\"Container-Host\"], \"MatchOptions\": [\"EQUALS\"]}}]}",
  "metrics": "[\"UnblendedCost\"]"
})

// Step 2: Monitor container host utilization
const containerUtilization = usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_statistics", {
  "namespace": "ContainerInsights",
  "metric_name": "cluster_cpu_utilization",
  "dimensions": [{"Name": "ClusterName", "Value": "my-cluster"}],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z",
  "period": 3600,
  "statistics": ["Average", "Maximum"]
})

// Step 3: Get Fargate pricing for equivalent workloads
const fargatePricing = usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonECS",
  "region": ["us-east-1"],
  "filters": [
    {"Field": "usagetype", "Value": "Fargate", "Type": "CONTAINS"}
  ]
})

// Step 4: Get EKS managed service pricing
const eksPricing = usePower("aws-cost-optimization", "awslabs.aws-pricing-mcp-server", "get_pricing", {
  "service_code": "AmazonEKS",
  "region": ["us-east-1"]
})

// Step 5: Monitor container performance metrics
const containerPerformance = usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "metric_data_queries": [
    {
      "id": "cpu_utilization",
      "metric_stat": {
        "metric": {
          "namespace": "ContainerInsights",
          "metric_name": "pod_cpu_utilization",
          "dimensions": [{"Name": "ClusterName", "Value": "my-cluster"}]
        },
        "period": 3600,
        "stat": "Average"
      }
    },
    {
      "id": "memory_utilization",
      "metric_stat": {
        "metric": {
          "namespace": "ContainerInsights",
          "metric_name": "pod_memory_utilization",
          "dimensions": [{"Name": "ClusterName", "Value": "my-cluster"}]
        },
        "period": 3600,
        "stat": "Average"
      }
    }
  ],
  "start_time": "2024-11-01T00:00:00Z",
  "end_time": "2024-12-01T00:00:00Z"
})

// Step 6: Analyze container workload patterns
const workloadPatterns = usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "session_sql", {
  "query": `
    SELECT 
      hour_of_day,
      AVG(cpu_utilization) as avg_cpu,
      AVG(memory_utilization) as avg_memory,
      AVG(running_tasks) as avg_tasks,
      MAX(running_tasks) as peak_tasks,
      MIN(running_tasks) as min_tasks
    FROM container_metrics
    WHERE date >= '2024-11-01'
    GROUP BY hour_of_day
    ORDER BY hour_of_day
  `
})
```

## Workflow 4: Storage Migration to Managed Services

**Goal**: Migrate self-managed storage solutions to managed storage services

### Steps:

1. **Analyze Current Storage Infrastructure**
   ```
   Use storage_lens to understand:
   - Storage utilization patterns
   - Access frequency and patterns
   - Backup and replication costs
   - Management overhead costs
   ```

2. **Evaluate Managed Storage Options**
   ```
   Use get_pricing to compare:
   - S3 storage classes for different access patterns
   - EFS for shared file storage
   - FSx for high-performance workloads
   - Storage Gateway for hybrid scenarios
   ```

3. **Optimize Storage Lifecycle**
   ```
   Use storage_lens analytics to:
   - Design optimal lifecycle policies
   - Implement intelligent tiering
   - Automate storage optimization
   - Monitor and adjust policies
   ```

### Example Storage Migration Analysis:

```javascript
// Step 1: Analyze current storage patterns
const storagePatterns = usePower("aws-cost-optimization", "aws-billing-cost-management", "storage_lens", {
  "query": `
    SELECT
      bucket_name,
      storage_class,
      SUM(CAST(metric_value AS BIGINT)) as total_bytes,
      AVG(CASE WHEN metric_name = 'NumberOfObjects' THEN CAST(metric_value AS BIGINT) END) as object_count
    FROM {table}
    WHERE metric_name IN ('StorageBytes', 'NumberOfObjects')
    GROUP BY bucket_name, storage_class
    ORDER BY total_bytes DESC
  `
})

// Step 2: Get S3 pricing for different storage classes
const s3Pricing = usePower("aws-cost-optimization", "aws-pricing", "get_pricing", {
  "service_code": "AmazonS3",
  "region": "us-east-1",
  "filters": [
    {"Field": "storageClass", "Value": ["General Purpose", "Infrequent Access", "Glacier"], "Type": "ANY_OF"}
  ]
})

// Step 3: Analyze lifecycle optimization opportunities
const lifecycleOptimization = usePower("aws-cost-optimization", "aws-billing-cost-management", "storage_lens", {
  "query": `
    SELECT
      bucket_name,
      SUM(CASE WHEN metric_name = 'StorageBytes' AND storage_class = 'STANDARD' THEN CAST(metric_value AS BIGINT) ELSE 0 END) as standard_bytes,
      SUM(CASE WHEN metric_name = 'StorageBytes' AND storage_class = 'STANDARD_IA' THEN CAST(metric_value AS BIGINT) ELSE 0 END) as ia_bytes,
      SUM(CASE WHEN metric_name = 'StorageBytes' AND storage_class = 'GLACIER' THEN CAST(metric_value AS BIGINT) ELSE 0 END) as glacier_bytes
    FROM {table}
    WHERE metric_name = 'StorageBytes'
    GROUP BY bucket_name
    HAVING standard_bytes > 0
    ORDER BY standard_bytes DESC
  `
})

// Step 4: Calculate storage optimization potential
const storageOptimization = usePower("aws-cost-optimization", "aws-billing-cost-management", "cost_optimization", {
  "operation": "list_recommendations",
  "filters": "{\"resourceTypes\": [\"EbsVolume\"], \"actionTypes\": [\"Delete\", \"Rightsize\"]}"
})
```

## Managed Service Migration Strategies

### Database Migration Strategy
1. **Assessment Phase**
   - Analyze current database workloads and performance requirements
   - Evaluate compatibility with managed database services
   - Assess data migration complexity and requirements
   - Plan for minimal downtime migration

2. **Service Selection**
   - **RDS**: For traditional relational databases with standard requirements
   - **Aurora**: For high-performance, cloud-native applications
   - **DynamoDB**: For NoSQL workloads requiring high scalability
   - **DocumentDB**: For MongoDB-compatible document databases

3. **Migration Execution**
   - Use AWS Database Migration Service for data migration
   - Implement read replicas for minimal downtime
   - Test performance and functionality thoroughly
   - Plan rollback procedures

### Container Migration Strategy
1. **Containerization Assessment**
   - Evaluate current container orchestration complexity
   - Assess workload patterns and scaling requirements
   - Analyze operational overhead and management costs
   - Plan for container registry migration

2. **Service Selection**
   - **ECS with Fargate**: For serverless container execution
   - **ECS with EC2**: For cost-optimized container hosting
   - **EKS**: For Kubernetes-native applications
   - **App Runner**: For simple web applications and APIs

3. **Migration Planning**
   - Containerize applications if not already containerized
   - Plan service discovery and networking migration
   - Implement monitoring and logging solutions
   - Test scaling and performance characteristics

### Storage Migration Strategy
1. **Storage Assessment**
   - Analyze current storage utilization and access patterns
   - Evaluate performance and availability requirements
   - Assess backup and disaster recovery needs
   - Plan for data migration and synchronization

2. **Service Selection**
   - **S3**: For object storage with intelligent tiering
   - **EFS**: For shared file storage across multiple instances
   - **FSx**: For high-performance file systems
   - **Storage Gateway**: For hybrid cloud storage

3. **Migration Implementation**
   - Implement lifecycle policies for automatic optimization
   - Use AWS DataSync for large-scale data migration
   - Plan for gradual migration with validation
   - Monitor performance and cost optimization

## Cost Optimization Benefits

### Operational Cost Reduction
- **Elimination of management overhead**: No patching, maintenance, or capacity planning
- **Reduced operational staff requirements**: Less need for specialized infrastructure expertise
- **Automated scaling and optimization**: Built-in cost optimization features
- **Improved reliability**: Higher availability with lower operational effort

### Infrastructure Cost Optimization
- **Pay-per-use pricing**: Only pay for actual resource consumption
- **Economies of scale**: Benefit from AWS's scale and optimization
- **Reduced over-provisioning**: Automatic scaling eliminates capacity waste
- **Built-in optimization**: Services include cost optimization features

### Innovation Acceleration
- **Focus on business value**: Redirect resources to business-differentiating activities
- **Faster time-to-market**: Reduced infrastructure setup and management time
- **Access to advanced features**: Leverage AWS innovation and new capabilities
- **Improved agility**: Faster response to business requirements

## Implementation Best Practices

### Migration Planning
- **Start with non-critical workloads**: Gain experience with lower-risk migrations
- **Plan for gradual migration**: Implement phased migration approach
- **Validate performance**: Ensure managed services meet performance requirements
- **Plan rollback procedures**: Have contingency plans for migration issues

### Cost Management
- **Monitor costs closely**: Track costs during and after migration
- **Optimize configurations**: Right-size managed service configurations
- **Leverage cost optimization features**: Use built-in optimization capabilities
- **Regular cost reviews**: Continuously optimize managed service usage

### Operational Excellence
- **Update monitoring and alerting**: Adapt monitoring for managed services
- **Train teams**: Ensure teams understand managed service operations
- **Update processes**: Modify operational processes for managed services
- **Document changes**: Maintain documentation for new architectures

## Success Metrics

### Cost Optimization Metrics
- **Total cost reduction**: Overall cost savings from managed service adoption
- **Operational cost savings**: Reduction in operational overhead costs
- **Time savings**: Reduction in management and maintenance time
- **Cost per unit**: Improvement in cost per business metric

### Operational Metrics
- **Availability improvement**: Increased system availability and reliability
- **Performance optimization**: Performance improvements from managed services
- **Scaling efficiency**: Improved scaling responsiveness and efficiency
- **Error reduction**: Reduction in operational errors and incidents

### Business Value Metrics
- **Innovation velocity**: Increased rate of new feature development
- **Time-to-market**: Faster deployment of new capabilities
- **Resource reallocation**: Percentage of resources redirected to business value
- **Competitive advantage**: Business benefits from managed service capabilities