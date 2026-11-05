# Service Guides

> **Navigation:** [← Tool Selection Guide](../tool-selection-guide.md) | [Power Overview](../../POWER.md)

This power includes 22 service-specific cost optimization guides. To load one, call action "readSteering" with powerName="aws-cost-optimization" and steeringFile set to the path in the table, for example steeringFile="services/compute-cost-optimization.md".

## Compute

| Guide | Covers |
|---|---|
| `services/compute-cost-optimization.md` | Amazon EC2 rightsizing, Auto Scaling, Spot Instances, and instance generations |
| `services/lambda-cost-optimization.md` | AWS Lambda memory, duration, concurrency, and Graviton |
| `services/containers-cost-optimization.md` | Amazon ECS, Amazon EKS, and AWS Fargate |
| `services/ec2-amd-cost-optimization.md` | Amazon EC2 instances with AMD EPYC processors |
| `services/graviton-cost-optimization.md` | AWS Graviton for EC2, Lambda, RDS, and ElastiCache |

## AI and machine learning

| Guide | Covers |
|---|---|
| `services/bedrock-cost-optimization.md` | Amazon Bedrock model choice, inference options, and prompt costs |
| `services/bedrock-agents-cost-optimization.md` | Amazon Bedrock Agents |
| `services/sagemaker-cost-optimization.md` | Amazon SageMaker AI training, hosting, and Savings Plans |
| `services/ai-workloads-cost-optimization.md` | Training, inference, and data costs across AI workloads |

## Databases

| Guide | Covers |
|---|---|
| `services/rds-aurora-cost-optimization.md` | Amazon RDS and Amazon Aurora |
| `services/dynamodb-cost-optimization.md` | Amazon DynamoDB |
| `services/redshift-cost-optimization.md` | Amazon Redshift |
| `services/opensearch-cost-optimization.md` | Amazon OpenSearch Service |
| `services/elasticache-redis-cost-optimization.md` | Amazon ElastiCache for Redis |

## Storage

| Guide | Covers |
|---|---|
| `services/storage-cost-optimization.md` | Amazon S3, Amazon EBS, and Amazon EFS |
| `services/fsx-netapp-ontap-cost-optimization.md` | Amazon FSx for NetApp ONTAP |

## Networking

| Guide | Covers |
|---|---|
| `services/networking-cost-optimization.md` | Data transfer, NAT gateways, load balancers, public IPv4 addresses, and Route 53 |

## Security and governance

| Guide | Covers |
|---|---|
| `services/security-cost-optimization.md` | AWS KMS, Amazon GuardDuty, AWS Security Hub, AWS WAF, and AWS Config rules |
| `services/cloudtrail-cost-optimization.md` | AWS CloudTrail |

## Monitoring and commitments

| Guide | Covers |
|---|---|
| `services/monitoring-cost-optimization.md` | Amazon CloudWatch and cost intelligence reporting |
| `services/reserved-instances-cost-optimization.md` | Reserved Instances for EC2, RDS, ElastiCache, Redshift, and OpenSearch |

## Application integration

| Guide | Covers |
|---|---|
| `services/sqs-cost-optimization.md` | Amazon SQS |

For step-by-step implementation guides that match these topics, see `cfm-tips-playbooks.md`.
