# AWS Storage Services Cost Analysis Estimate Report

## Service Overview

AWS Storage Services is a fully managed, serverless service that allows you to This project uses multiple AWS services.. This service follows a pay-as-you-go pricing model, making it cost-effective for various workloads.

## Pricing Model

This cost analysis estimate is based on the following pricing model:
- **ON DEMAND** pricing (pay-as-you-go) unless otherwise specified
- Standard service configurations without reserved capacity or savings plans
- No caching or optimization techniques applied

## Assumptions

- Analysis based on current week (Jan 1-7, 2025) usage patterns
- Standard S3 pricing tiers applied
- No Reserved Capacity or Savings Plans considered
- Data transfer costs included for cross-region replication

## Limitations and Exclusions

- EBS volume costs (no EBS usage detected)
- EFS and FSx costs (no usage detected)
- S3 Glacier storage costs
- CloudFront distribution costs
- VPC endpoint costs

## Cost Breakdown

### Unit Pricing Details

| Service | Resource Type | Unit | Price | Free Tier |
|---------|--------------|------|-------|------------|
| Amazon S3 Storage | First 50Tb | GB-Month | $0.023 | First 5GB free for 12 months (new accounts) |
| Amazon S3 Storage | Next 450Tb | GB-Month | $0.022 | First 5GB free for 12 months (new accounts) |
| Amazon S3 Storage | Over 500Tb | GB-Month | $0.021 | First 5GB free for 12 months (new accounts) |
| S3 API Requests | Put Requests | 1,000 requests | $0.005 | 2,000 PUT/POST and 20,000 GET requests free monthly |
| S3 API Requests | Get Requests | 1,000 requests | $0.0004 | 2,000 PUT/POST and 20,000 GET requests free monthly |
| S3 Data Transfer | Cross Region | GB | $0.02 | 1GB free data transfer out monthly |
| S3 Data Transfer | Internet Out | GB | $0.09 | 1GB free data transfer out monthly |

### Cost Calculation

| Service | Usage | Calculation | Monthly Cost |
|---------|-------|-------------|-------------|
| Amazon S3 Storage | ~3.75 GB average storage (Storage Bytes: 3.75 GB-Month average) | ~3.75 GB-Month × $0.023/GB = $0.086/day average | $0.52/week |
| S3 API Requests | ~4,400 PUT/POST, ~10,100 GET requests weekly (Put Requests: 4,400 requests/week, Get Requests: 10,100 requests/week) | ~4,400 PUT/POST requests × $0.005/1K + ~10,100 GET requests × $0.0004/1K | $0.026/week |
| S3 Data Transfer | Minimal cross-region data transfer (Transfer Bytes: <0.01 GB/week) | Cross-region transfer charges for replication | $0.0001/week |
| **Total** | **All services** | **Sum of all calculations** | **$0.55/month** |

### Free Tier

Free tier information by service:
- **Amazon S3 Storage**: First 5GB free for 12 months (new accounts)
- **S3 API Requests**: 2,000 PUT/POST and 20,000 GET requests free monthly
- **S3 Data Transfer**: 1GB free data transfer out monthly

## Cost Scaling with Usage

The following table illustrates how cost estimates scale with different usage levels:

| Service | Low Usage | Medium Usage | High Usage |
|---------|-----------|--------------|------------|
| Amazon S3 Storage | $0/month | $0/month | $1/month |
| S3 API Requests | $0/month | $0/month | $0/month |
| S3 Data Transfer | $0/month | $0/month | $0/month |

### Key Cost Factors

- **Amazon S3 Storage**: ~3.75 GB average storage
- **S3 API Requests**: ~4,400 PUT/POST, ~10,100 GET requests weekly
- **S3 Data Transfer**: Minimal cross-region data transfer

## Projected Costs Over Time

The following projections show estimated monthly costs over a 12-month period based on different growth patterns:

Base monthly cost calculation:

| Service | Monthly Cost |
|---------|-------------|
| Amazon S3 Storage | $0.52 |
| S3 API Requests | $0.03 |
| S3 Data Transfer | $0.00 |
| **Total Monthly Cost** | **$0** |

| Growth Pattern | Month 1 | Month 3 | Month 6 | Month 12 |
|---------------|---------|---------|---------|----------|
| Steady | $0/mo | $0/mo | $0/mo | $0/mo |
| Moderate | $0/mo | $0/mo | $0/mo | $0/mo |
| Rapid | $0/mo | $0/mo | $0/mo | $1/mo |

* Steady: No monthly growth (1.0x)
* Moderate: 5% monthly growth (1.05x)
* Rapid: 10% monthly growth (1.1x)

## Detailed Cost Analysis

### Pricing Model

ON DEMAND


### Exclusions

- EBS volume costs (no EBS usage detected)
- EFS and FSx costs (no usage detected)
- S3 Glacier storage costs
- CloudFront distribution costs
- VPC endpoint costs

### Total Weekly Cost

$0.55


### Recommendations

#### Immediate Actions

- Review current storage usage patterns for optimization opportunities
- Implement lifecycle policies for data older than 30 days
- Enable S3 Storage Class Analysis to identify transition opportunities
- Set up CloudWatch alarms for unusual storage growth
- Consider S3 Intelligent Tiering for automatic optimization
#### Best Practices

- Implement S3 Intelligent Tiering for automatic cost optimization
- Set up lifecycle policies to transition old data to cheaper storage classes
- Monitor and optimize data transfer patterns
- Use S3 Storage Lens for detailed storage analytics
- Consider S3 One Zone-IA for non-critical, reproducible data



## Cost Optimization Recommendations

### Immediate Actions

- Review current storage usage patterns for optimization opportunities
- Implement lifecycle policies for data older than 30 days
- Enable S3 Storage Class Analysis to identify transition opportunities

### Best Practices

- Implement S3 Intelligent Tiering for automatic cost optimization
- Set up lifecycle policies to transition old data to cheaper storage classes
- Monitor and optimize data transfer patterns

## Conclusion

By following the recommendations in this report, you can optimize your AWS Storage Services costs while maintaining performance and reliability. Regular monitoring and adjustment of your usage patterns will help ensure cost efficiency as your workload evolves.
