---
inclusion: manual
---

# CFM TIPs Playbook Links

[AWS CFM TIPs](https://catalog.workshops.aws/awscff/en-US) (Cloud Financial Management Technical Implementation Playbooks) is a free AWS workshop. AWS subject matter experts curate its step-by-step guides, which follow the AWS Well-Architected Cost Optimization Pillar. Use the links in this file to point users to the implementation steps behind this power's recommendations.

## How to cite CFM TIPs

- When you recommend an optimization, a setup step, or a governance control that a page below covers, end your answer with `**Implement with CFM TIPs:**` followed by a link to that page. Link one or two pages and pick the most specific match.
- Use only the URLs in this file and in the "CFM TIPs Playbooks" sections of the service guides. Don't build CFM TIPs URLs yourself, because page paths don't follow service names consistently.
- Skip the link when no page matches, for short factual answers such as a single price or a cost total, and in hook-triggered file reviews that find no issues.
- In a hook-triggered review that flags an issue, you can add the matching link after the finding, for example the gp2 to gp3 migration page for a gp2 volume.
- In an unused resource review (`unused-resource-review.md`), link the matching page in each row of the findings table instead of one or two pages at the end.

## Start here

- [CFM TIPs home](https://catalog.workshops.aws/awscff/en-US): the six pillars and how to work through them
- [Introduction](https://catalog.workshops.aws/awscff/en-US/introduction)

## Cloud financial management practices

| Topic | CFM TIPs page |
|---|---|
| Cost-aware culture, cost optimization function, finance and technology partnership | [Culture Change](https://catalog.workshops.aws/awscff/en-US/culture-change) |
| Budgets and budget alerts | [Setup Budgets](https://catalog.workshops.aws/awscff/en-US/foundations/1-budgets) |
| Tagging strategy and cost allocation tags | [Setup Tagging Strategy](https://catalog.workshops.aws/awscff/en-US/foundations/2-tagging-strategy) |
| Cost anomaly detection | [Setup Cost Anomaly Detection Monitors](https://catalog.workshops.aws/awscff/en-US/foundations/3-cost-anomaly) |
| Trusted Advisor cost checks | [Review AWS Trusted Advisor Cost Optimization pillar](https://catalog.workshops.aws/awscff/en-US/foundations/4-trusted-advisor) |
| Opting in to Compute Optimizer and its preferences | [Enable AWS Compute Optimizer](https://catalog.workshops.aws/awscff/en-US/foundations/5-enable-compute-optimizer) |
| Rightsizing recommendations from Compute Optimizer | [AWS Compute Optimizer](https://catalog.workshops.aws/awscff/en-US/playbooks/costmanagement/computeoptimizer) |
| Cost and usage analysis | [AWS Cost Explorer](https://catalog.workshops.aws/awscff/en-US/visualizations/1-cost-explorer) |
| Cost and Usage Report (CUR 2.0) exports | [AWS Data Exports](https://catalog.workshops.aws/awscff/en-US/visualizations/4-data-exports) |
| Cost dashboards and KPIs (CUDOS, KPI, CORA) | [Cloud Intelligence Dashboards](https://catalog.workshops.aws/awscff/en-US/visualizations/3-cid) |
| Chargeback and showback groupings | [AWS Cost Categories](https://catalog.workshops.aws/awscff/en-US/playbooks/costmanagement/costcategories), [AWS Billing Conductor](https://catalog.workshops.aws/awscff/en-US/playbooks/costmanagement/billingconductor) |
| Forecasting | [Forecasting](https://catalog.workshops.aws/awscff/en-US/playbooks/costmanagement/forecasting) |
| Estimates before deployment | [AWS Pricing Calculator](https://catalog.workshops.aws/awscff/en-US/playbooks/costmanagement/pricingcalculator) |
| AWS Marketplace spend | [AWS Marketplace](https://catalog.workshops.aws/awscff/en-US/playbooks/costmanagement/marketplace) |
| Preventive and detective cost controls (SCPs, AWS Config rules) | [Governance](https://catalog.workshops.aws/awscff/en-US/governance) |
| Cost management for AI workloads | [FinOps for AI](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/2-finops-for-ai), [Tokenomics](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/3-tokenomics) |
| Kiro subscription and credit spend | [FinOps for AI: Kiro](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/2-finops-for-ai#kiro) |

## Idle and unused resources

| Finding | CFM TIPs page |
|---|---|
| Idle EC2 instances | [Low Utilization EC2 instances](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/2-low-utilization-ec2) |
| Stopped EC2 instances and unattached Elastic IP addresses (AWS Config rules) | [EC2 Detection](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/governance/2-detection) |
| Unused On-Demand Capacity Reservations | [Unused On Demand Capacity Reservations](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/8-unused-on-demand-capacity-reservations) |
| Idle RDS DB instances | [RDS Idle Instances](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/1-idle-instances) |
| RDS backup storage | [RDS ChargedBackup](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/6-rds-charged-backup) |
| Unattached or idle EBS volumes | [Underutilized EBS volumes](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/4-ta-ebs), [EBS Detection](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/governance/2-detection) |
| EBS snapshot storage | [EBS Snapshot Spend](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/3-snapshot) |
| Fast snapshot restore left on | [Fast Snapshot Restore](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/6-fast-snapshot-restore) |
| Idle NAT gateways | [Idle NAT Gateways](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/nat/5-idle-nat-gateways) |
| Idle Elastic IP addresses and other public IPv4 addresses | [Public IPv4](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc/11-public-ipv4) |
| Idle VPC endpoints | [Idle VPC Endpoints](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc/10-idle-vpc-endpoints) |
| Log groups that never expire | [CloudWatch Logs](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudwatch/3-logs) |
| Unused KMS keys | [Removing unused KMS keys](https://catalog.workshops.aws/awscff/en-US/playbooks/security/kms/3-removing-unused-kms) |
| Idle load balancers and other Trusted Advisor cost checks | [Review AWS Trusted Advisor Cost Optimization pillar](https://catalog.workshops.aws/awscff/en-US/foundations/4-trusted-advisor) |

## Service playbooks

All service playbooks: [Service Cost Optimization Playbooks](https://catalog.workshops.aws/awscff/en-US/playbooks)

### Compute and containers

- **Amazon EC2:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2), [RightSizing](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/3-rightsizing), [Graviton Compatible](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/4-graviton-compatible), [Spot Instances](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/6-spot), [Scheduling](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/11-scheduling), [Commitment Plans](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/7-commitment-plans), [Unused Capacity Reservations](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/8-unused-on-demand-capacity-reservations), [Limit instance types with SCPs](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/governance/1-prevention)
- **AWS Lambda:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/lambda), [Optimize Duration](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/lambda/optimize-duration), [Memory optimization](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/lambda/optimize-duration/3-memory-optimization), [Reduce cold starts](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/lambda/reduce-cold-starts)
- **Amazon ECS and AWS Fargate:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/containers/ecs), [Right-Sizing ECS Tasks](https://catalog.workshops.aws/awscff/en-US/playbooks/containers/ecs/3-rightsizing-ecs-tasks), [Fargate purchase options](https://catalog.workshops.aws/awscff/en-US/playbooks/containers/ecs/6-optimizing-fargate-by-purchase-option), [Split Cost Allocation Data](https://catalog.workshops.aws/awscff/en-US/playbooks/containers/ecs/2-split-cost-allocation)
- **Amazon EKS:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/containers/eks), [Overall cluster costs](https://catalog.workshops.aws/awscff/en-US/playbooks/containers/eks/1-eks-overall-cluster-costs), [EKS Extended Support](https://catalog.workshops.aws/awscff/en-US/playbooks/containers/eks/12-eks-extended-support)
- **Amazon ECR:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/containers/ecr)

### Databases

- **Amazon RDS:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds), [RightSizing](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/3-rightsizing), [Graviton Compatible](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/2-graviton-compatiable), [Instance Scheduling](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/4-instance-schedule), [Extended Support](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/12-rds-extended-support), [Reserved Instances](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/10-rds-ris)
- **Amazon Aurora:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/aurora), [Compute](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/aurora/2-compute), [Aurora I/O cost](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/aurora/4-aurora-io)
- **Database Savings Plans:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/dbsp)
- **Amazon DynamoDB:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/dynamodb), [Capacity Modes](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/dynamodb/1-capacity-modes), [Table Classes](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/dynamodb/2-table-classes)
- **Amazon ElastiCache:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/elasticache), [ElastiCache Nodes](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/elasticache/2-elasticache-nodes), [ElastiCache Serverless](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/elasticache/6-serverless), [ElastiCache for Valkey](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/elasticache/7-valkey)
- **Amazon OpenSearch Service:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/opensearch), [Migrate from gp2 to gp3](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/opensearch/3-gp3-migration), [UltraWarm and cold storage](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/opensearch/4-ultrwarm-cold-storage), [OR1](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/opensearch/8-or1)
- **Amazon DocumentDB:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/documentdb)
- **Amazon Neptune:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/neptune)

### Analytics

- **Amazon Redshift:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/redshift), [Redshift Serverless](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/redshift/2-redshift-serverless), [Redshift Advisor](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/redshift/3-redshift-advisor)
- **Amazon Athena:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/athena), [Workgroups cost control](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/athena/2-athena-workgroups), [Partitioning](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/athena/6-partitioning)
- **Amazon EMR:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/emr), [Optimize Compute](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/emr/2-optimize-compute)
- **AWS Glue:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/glue)
- **Amazon MSK:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/msk), [Cluster Rightsizing](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/msk/2-rightsizing-your-cluster), [Tiered storage](https://catalog.workshops.aws/awscff/en-US/playbooks/analytics/msk/4-configure-tiered-storage-on-provisioned-msk-clusters)

### Storage

- **Amazon S3:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/s3), [Choosing the right storage class](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/s3/2-choosing-storage-class), [Incomplete multipart uploads](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/s3/6-mpu), [S3 governance](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/s3/10-governance)
- **Amazon EBS:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs), [Migrate gp2 to gp3](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/2-migrate-gp2-to-gp3), [Snapshot spend](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/3-snapshot), [Underutilized volumes](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/4-ta-ebs), [Prevent gp2 volumes with SCPs](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/governance/1-prevention)
- **Amazon EFS:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/efs), [EFS Storage Classes](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/efs/2-storage-classes), [EFS Throughput Mode](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/efs/4-throughput)
- **AWS Backup:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/backup)

### Networking

- **Data transfer:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/datatransfer), [Inter-AZ and Regional](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/datatransfer/3-dto-inter-az), [Between AWS Regions](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/datatransfer/2-dto-betweeen-regions), [Amazon CloudFront](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/datatransfer/4-dto-cloudfront)
- **NAT gateways:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/nat), [Processed traffic cost](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/nat/2-nat-traffic), [Idle NAT gateways](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/nat/5-idle-nat-gateways)
- **Amazon VPC:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc), [VPC Endpoints](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc/3-endpoints), [Idle VPC endpoints](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc/10-idle-vpc-endpoints), [Public IPv4](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc/11-public-ipv4), [AWS Transit Gateway](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc/7-transit-gateway)
- **Amazon API Gateway:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/apigateway)
- **AWS Direct Connect:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/directconnect)

### Monitoring and management

- **Amazon CloudWatch:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudwatch), [CloudWatch Metrics](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudwatch/2-metrics), [CloudWatch Logs](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudwatch/3-logs), [Alarms and dashboards](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudwatch/4-alarms-and-dashboards)
- **AWS CloudTrail:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudtrail), [Data Events](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudtrail/3-data-events), [CloudTrail governance](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudtrail/10-governance)
- **AWS Config:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/config), [Recording mode optimization](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/config/3-recording-mode-optimization), [Config rules optimization](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/config/4-config-rules-optimization)

### AI and machine learning

- **Amazon Bedrock:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/bedrock), [Choosing a Model](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/bedrock/3-choosing-the-right-model), [Run Model Inference](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/bedrock/6-run-model-inference), [FinOps for AI: Amazon Bedrock](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/2-finops-for-ai#bedrock)
- **Amazon SageMaker AI:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/sagemaker), [Deploy (inference options)](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/sagemaker/deploy), [Savings Plans](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/sagemaker/7-sp), [FinOps for AI: Amazon SageMaker](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/2-finops-for-ai#sagemaker)
- **GPU instances on Amazon EC2:** [FinOps for AI: Amazon EC2](https://catalog.workshops.aws/awscff/en-US/playbooks/aiml/2-finops-for-ai#ec2)

### Security

- **Security services:** [playbooks](https://catalog.workshops.aws/awscff/en-US/playbooks/security)
- **Amazon GuardDuty:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/security/guardduty)
- **AWS WAF:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/security/waf), [Scope-down statements](https://catalog.workshops.aws/awscff/en-US/playbooks/security/waf/5-scope-down-statements)
- **AWS KMS:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/security/kms), [Removing unused KMS keys](https://catalog.workshops.aws/awscff/en-US/playbooks/security/kms/3-removing-unused-kms)
- **Amazon Inspector:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/security/inspector)
- **AWS CloudHSM:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/security/cloudhsm)

### Application integration and other services

- **Amazon SQS:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/application-integration/sqs), [Batching](https://catalog.workshops.aws/awscff/en-US/playbooks/application-integration/sqs/2-batching), [Polling Modes](https://catalog.workshops.aws/awscff/en-US/playbooks/application-integration/sqs/3-polling-modes)
- **Amazon SNS:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/application-integration/sns)
- **AWS Step Functions:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/application-integration/stepfunctions), [Standard vs Express Workflows](https://catalog.workshops.aws/awscff/en-US/playbooks/application-integration/stepfunctions/3-standard-vs-express-workflows)
- **Amazon MQ:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/application-integration/mq)
- **Amazon WorkSpaces:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/endusercomputing/workspaces)
- **Amazon Pinpoint:** [playbook](https://catalog.workshops.aws/awscff/en-US/playbooks/business-applications/pinpoint)

---

**Source:** Page paths checked against the published CFM TIPs build on November 7, 2026. To check them again, compare them with the `path` values in the workshop manifest, which the build listed in `https://static.us-east-1.prod.workshops.aws/public/quicklinks/awscff/published.json` points to.
