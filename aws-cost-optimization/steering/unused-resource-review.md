---
inclusion: manual
---

# Unused Resource Review

Most of this power's guidance sizes, prices, and commits to resources that are in use. This guide finds resources that keep billing after their work is done: unattached EBS volumes, idle Elastic IP addresses, NAT gateways with no traffic, snapshots and backups that nobody needs, unused capacity reservations, and log groups that never expire.

The review follows Well-Architected question [COST 4: How do you decommission resources?](https://docs.aws.amazon.com/wellarchitected/latest/framework/cost-04.html), in particular [COST04-BP03 Decommission resources](https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/cost_decomissioning_resources_decommission.html) and [COST04-BP05 Enforce data retention policies](https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/cost_decomissioning_resources_data_retention.html).

## Rules

- **Read-only.** Report findings and link the cleanup steps. Never delete, stop, release, or modify a resource. The resource owner decides what to remove.
- **This power's MCP tools only.** Don't run AWS CLI commands. The power's IAM policy has no EC2 `Describe*` permissions, so the review works from recommendations, billing data, and CloudWatch.
- **On demand.** Run the review when the user asks, for example monthly or after a migration, a load test, or a project shutdown. Don't create hooks, schedules, or alarms for it.
- **Cost.** Cost Explorer charges $0.01 per API request. A full review makes up to 8 requests, and more if results run to extra pages. Say how many you made in the report.
- **Large results.** The billing server keeps a large result in a session table and returns `data_stored: true` with a `table_name` instead of the rows. Read the rows with the `session-sql` tool, for example `SELECT * FROM <table_name>`.
- **Account scope.** From the management account, Cost Explorer covers every account in the organization, and Cost Optimization Hub covers member accounts if it's enrolled for the organization. Compute Optimizer takes one account per call (`account_ids`). CloudWatch Logs covers only the account that the power's credentials belong to.

## What each source can find

| Finding | Source | Names each resource |
|---|---|---|
| Idle EC2 instances, Auto Scaling groups, ECS services, RDS and Aurora DB instances, and the other types in [Compute Optimizer's idle recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/view-idle-recommendations.html) | Cost Optimization Hub or Compute Optimizer | Yes |
| Unattached and idle EBS volumes | Cost Optimization Hub or Compute Optimizer | Yes |
| NAT gateways with no route table association and no traffic | Cost Optimization Hub or Compute Optimizer | Yes |
| Idle Elastic IP addresses | Cost Explorer | Only with resource-level data |
| NAT gateways that carry little traffic | Cost Explorer, then CloudWatch | Only with resource-level data or a gateway ID |
| EBS snapshot storage and fast snapshot restore | Cost Explorer | Only with resource-level data. No source shows snapshot age |
| RDS backup storage | Cost Explorer | Only with resource-level data |
| Unused EC2 On-Demand Capacity Reservations | Cost Explorer | Only with resource-level data |
| Log groups that never expire | CloudWatch Logs | Yes |

Resource-level data covers the last 14 days. It's free, and the management account turns it on in Cost Management preferences, for chosen services or all of them ([Configuring multi-year and granular data](https://docs.aws.amazon.com/cost-management/latest/userguide/ce-configuring-data.html), [pricing announcement](https://aws.amazon.com/about-aws/whats-new/2023/11/aws-cost-explorer-provides-historical-granular-data/)). Data appears within 48 hours.

## Dates in the examples

The examples are for a review run on 2026-11-07. Work out the dates from today's date:

- Last full month: `2026-10-01` to `2026-11-01`
- Last six full months: `2026-05-01` to `2026-11-01`
- Last 14 days, for resource-level data: `2026-10-24` to `2026-11-07`
- Last 30 days, for CloudWatch: `2026-10-08T00:00:00Z` to `2026-11-07T00:00:00Z`

Cost Explorer end dates are exclusive.

## Step 1: Check the sources and find the active Regions

1. Check whether Cost Optimization Hub is enrolled:

```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-optimization", {
  "operation": "list_enrollment_statuses"
})
```

If the status is Active, use Cost Optimization Hub in Step 2. If it's Inactive, use Compute Optimizer instead, and add enrolling in Cost Optimization Hub to the report ([Getting started with Cost Optimization Hub](https://docs.aws.amazon.com/cost-management/latest/userguide/coh-getting-started.html)).

2. Find the Regions that had usage last month:

```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2026-10-01",
  "end_date": "2026-11-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"REGION\"}]",
  "metrics": "[\"AmortizedCost\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"RECORD_TYPE\", \"Values\": [\"Usage\", \"DiscountedUsage\", \"SavingsPlanCoveredUsage\"]}}"
})
```

The filter keeps usage charges and leaves out credits, refunds, and discounts, so a Region still shows its usage when credits pay for it. `AmortizedCost` counts usage that Reserved Instances and Savings Plans cover at its effective cost.

Use these Regions in Steps 2 and 4:
- Skip `global` and `NoRegion`, which hold costs that belong to no Region.
- Skip Regions with less than $1 of usage. An idle resource's charges count toward its Region's usage, so a Region below $1 can't hold anything worth more than that.

## Step 2: List idle resources from recommendations

### If Cost Optimization Hub is active

Cost Optimization Hub covers every Region in one call, and it includes Compute Optimizer's idle findings. Its `Stop`, `Delete`, and `ScaleIn` actions are the ones for idle or unused resources ([cost optimization strategies](https://docs.aws.amazon.com/cost-management/latest/userguide/coh-optimization-strategies.html)). Don't also call Compute Optimizer, because it would list the same resources a second time.

1. Get the deduplicated savings total and the counts by resource type:

```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-optimization", {
  "operation": "list_recommendation_summaries",
  "group_by": "ResourceType",
  "filters": "{\"actionTypes\": [\"Delete\", \"Stop\", \"ScaleIn\"]}"
})
```

2. List the resources with the highest savings:

```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-optimization", {
  "operation": "list_recommendations",
  "filters": "{\"actionTypes\": [\"Delete\", \"Stop\", \"ScaleIn\"]}",
  "order_by": "{\"dimension\": \"EstimatedMonthlySavings\", \"order\": \"Desc\"}",
  "max_items": 25
})
```

- Use `estimated_total_deduped_savings` from the summary as the total. Never add up `estimated_monthly_savings` across the listed items, because they can overlap.
- For EBS volumes, `Delete` covers unattached volumes and attached volumes that are idle. A `recommended_resource_summary` that starts with "Detach volume from instance" marks an attached volume.
- Report each item's `lookback_period_in_days` with the finding.

### If Cost Optimization Hub is inactive

Compute Optimizer is regional, so call it once for each Region from Step 1:

```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "compute-optimizer", {
  "operation": "get_idle_recommendations",
  "region": "us-east-1",
  "filters": "[{\"name\": \"Finding\", \"values\": [\"Idle\", \"Unattached\", \"Unused\"]}]",
  "max_items": 25
})
```

Results come sorted by savings after discounts, highest first. The findings mean:

- `Unattached`: an EBS volume that wasn't attached to any instance during the 32-day lookback.
- `Unused`: a NAT gateway that is available, has no route table association, and had no connections or packets during the lookback.
- `Idle`: a resource with almost no use. Each resource type has its own criteria and lookback, usually 14 days ([idle recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/view-idle-recommendations.html)).

Report `savings_opportunity_after_discounts` when it's present, otherwise `savings_opportunity`, and say which one you used. Don't add the two together. If Compute Optimizer isn't turned on for the account, say so and link [Enable AWS Compute Optimizer](https://catalog.workshops.aws/awscff/en-US/foundations/5-enable-compute-optimizer).

## Step 3: Find idle charges that recommendations miss

Recommendations don't cover Elastic IP addresses, snapshots, backups, or capacity reservations, and they flag a NAT gateway only when it has no route table association and no traffic at all. Cost Explorer shows what these cost.

### 3.1 Find the exact usage types

Cost Explorer filters match exact values only. Most usage types start with a Region code, such as `USE2-` for us-east-2, and services differ in whether they add one in us-east-1. Look up the exact names with one `getDimensionValues` call for each search string in the table:

```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getDimensionValues",
  "dimension": "USAGE_TYPE",
  "search_string": "IdleAddress",
  "start_date": "2026-05-01",
  "end_date": "2026-11-01"
})
```

| Search string | Usage types to keep | What they bill |
|---|---|---|
| `IdleAddress` | `PublicIPv4:IdleAddress` | Elastic IP addresses that aren't associated with a resource |
| `NatGateway` | `NatGateway-Hours`, `NatGateway-Bytes` | NAT gateway hours and data processed |
| `Snapshot` | `EBS:SnapshotUsage`, `EBS:SnapshotArchiveStorage`, `EBS:FastSnapshotRestore` | EBS snapshot storage in the standard and archive tiers, and fast snapshot restore |
| `BackupUsage` | `RDS:ChargedBackupUsage`, and other database types that end in `BackupUsage` | Database backup storage above the free amount |
| `Unused` | `UnusedBox:<instance type>`, `UnusedDed:<instance type>` | Capacity Reservation hours that no instance used |

Sources: [public IPv4 usage types](https://repost.aws/knowledge-center/vpc-identify-public-ipv4-charges), [EBS billing codes](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-billing-usage-reports.html), [EC2 billing codes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-billing-usage-reports.html).

A search that returns no values means the account had no charges of that type in the six months. Leave those usage types out of 3.2. If no search returns values, skip 3.2 and 3.3 and report that the account had none of these charges.

### 3.2 Get six months of cost and usage

Get all the usage types from 3.1 in one call. The values below are examples; use the exact values that 3.1 returned:

```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsage",
  "start_date": "2026-05-01",
  "end_date": "2026-11-01",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}]",
  "metrics": "[\"UnblendedCost\", \"UsageQuantity\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"USAGE_TYPE\", \"Values\": [\"PublicIPv4:IdleAddress\", \"USE2-PublicIPv4:IdleAddress\", \"NatGateway-Hours\", \"NatGateway-Bytes\", \"EBS:SnapshotUsage\", \"EBS:FastSnapshotRestore\", \"RDS:ChargedBackupUsage\", \"UnusedBox:m5.large\"]}}"
})
```

How to read each usage type:

- **`PublicIPv4:IdleAddress`:** a steady charge means addresses that are kept but not used. `UsageQuantity` is address-hours, so divide it by the hours in the month (720 or 744) for the average number of idle addresses.
- **`NatGateway-Hours` with little `NatGateway-Bytes` in the same Region:** gateways that bill every hour but carry little traffic. Hours divided by the hours in the month gives the average number of gateways.
- **`EBS:SnapshotUsage`:** growth every month while EBS volume costs stay flat points to snapshots kept with no retention policy. `UsageQuantity` is GB-months.
- **`EBS:FastSnapshotRestore`:** billed for as long as it stays enabled on a snapshot, in each Availability Zone, even when no volumes are created from it. It's often left on after a migration or a restore test.
- **`RDS:ChargedBackupUsage`:** backup storage above the free amount, which equals the provisioned storage of the Region's databases. It grows when manual snapshots are kept, including snapshots of deleted databases, whose storage no longer counts toward the free amount.
- **`UnusedBox` and `UnusedDed`:** Capacity Reservations that are billed while no instance uses them. Any steady charge is a candidate.

Costs are net of credits and refunds, so credits can make these charges look smaller. Credits don't change `UsageQuantity`, so judge idle resources by it.

### 3.3 Name the resources (optional)

If resource-level data is on for these services, one call names the resources behind the usage types that had steady charges in 3.2:

```javascript
usePower("aws-cost-optimization", "awslabs.billing-cost-management-mcp-server", "cost-explorer", {
  "operation": "getCostAndUsageWithResources",
  "start_date": "2026-10-24",
  "end_date": "2026-11-07",
  "granularity": "MONTHLY",
  "group_by": "[{\"Type\": \"DIMENSION\", \"Key\": \"USAGE_TYPE\"}, {\"Type\": \"DIMENSION\", \"Key\": \"RESOURCE_ID\"}]",
  "metrics": "[\"UnblendedCost\", \"UsageQuantity\"]",
  "filter": "{\"Dimensions\": {\"Key\": \"USAGE_TYPE\", \"Values\": [\"PublicIPv4:IdleAddress\", \"NatGateway-Hours\", \"EBS:SnapshotUsage\"]}}"
})
```

- If the call fails with `AccessDeniedException` and a message that resource-level data is an opt-in feature, resource-level data is off for the organization. That isn't a missing IAM permission, so don't report it as one. Skip this step, and add turning it on from the management account to the report as a setup step.
- Costs that come back without a resource ID usually mean resource-level data is on, but not for that service. Add turning it on for the service to the report.
- An account can have thousands of snapshots. If the result is partial (`complete_dataset: false`), query one usage type at a time.

### 3.4 Check a NAT gateway's traffic (optional)

For a NAT gateway ID from Step 2, from 3.3, or from the user, check the last 30 days of traffic. A gateway with almost no bytes is a candidate even if a route table still points at it:

```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "get_metric_data", {
  "namespace": "AWS/NATGateway",
  "metric_name": "BytesOutToDestination",
  "dimensions": [{"name": "NatGatewayId", "value": "nat-0123456789abcdef0"}],
  "statistic": "Sum",
  "start_time": "2026-10-08T00:00:00Z",
  "end_time": "2026-11-07T00:00:00Z",
  "target_datapoints": 30,
  "region": "us-east-2"
})
```

Check `ActiveConnectionCount` with the `Maximum` statistic the same way. An empty `datapoints` list, rather than zeros, means CloudWatch has no data for that gateway ID in that Region, so check both before you call the gateway idle. A quiet NAT gateway can still be standby capacity for failover or disaster recovery, so say so in the finding.

## Step 4: Find log groups that never expire

A log group keeps its data forever unless it has a retention period, and stored data bills every month. Check each Region from Step 1:

```javascript
usePower("aws-cost-optimization", "awslabs.cloudwatch-mcp-server", "describe_log_groups", {
  "region": "us-east-1"
})
```

- A `retentionInDays` of `null` means the log group never expires.
- Rank those log groups by `storedBytes` and report the largest, with their stored size in GB.
- In a Region with many log groups, list one prefix at a time with `log_group_name_prefix`, such as `/aws/lambda/`.
- Some logs must be kept for compliance, so the owner picks the retention period. Link [log retention settings](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html).

## Step 5: Report the findings

Put the findings in one table, highest cost first:

| Resource or usage type | Region | Finding | Monthly cost or estimated savings | Source | CFM TIPs page |
|---|---|---|---|---|---|

- Give the deduplicated Cost Optimization Hub total from Step 2, not a sum of the listed items.
- Report recommendation savings and Cost Explorer costs as separate subtotals. Don't add them together: one is an estimate and the other is billed cost, and the same NAT gateway can appear in both.
- State each source's period: the recommendation lookback, the six months of Cost Explorer data, and the 14 days of resource-level data.
- Link the matching CFM TIPs page in each row, from the table below.
- Before the owner removes anything, they should confirm that nothing depends on it, such as failover capacity or an IP address that partners allowlist. Recommend a snapshot before deleting an EBS volume, and a check of retention requirements before deleting snapshots, backups, or logs.
- End with what the review couldn't check: Regions skipped, accounts not covered, sources that aren't turned on, and the gaps in [What this review can't see](#what-this-review-cant-see).

## CFM TIPs pages for each finding

| Finding | CFM TIPs page |
|---|---|
| Idle EC2 instances | [Low Utilization EC2 instances](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/2-low-utilization-ec2) |
| Idle RDS DB instances | [RDS Idle Instances](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/1-idle-instances) |
| Unattached or idle EBS volumes | [Underutilized EBS volumes](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/4-ta-ebs) |
| Idle or unused NAT gateways | [Idle NAT Gateways](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/nat/5-idle-nat-gateways) |
| Idle Elastic IP addresses | [Public IPv4](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc/11-public-ipv4) |
| EBS snapshot storage | [EBS Snapshot Spend](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/3-snapshot) |
| Fast snapshot restore | [Fast Snapshot Restore](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/6-fast-snapshot-restore) |
| RDS backup storage | [RDS ChargedBackup](https://catalog.workshops.aws/awscff/en-US/playbooks/databases/rds/6-rds-charged-backup) |
| Unused capacity reservations | [Unused On Demand Capacity Reservations](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/8-unused-on-demand-capacity-reservations) |
| Log groups that never expire | [CloudWatch Logs](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/cloudwatch/3-logs) |
| Other idle resource types | The service's playbook, listed in `cfm-tips-playbooks.md` |

## What this review can't see

- **Snapshot age.** Cost Explorer shows what snapshots cost, but not when they were taken or whether their source volume still exists. The EC2 console shows each snapshot's start time. To keep snapshots from piling up, use [Amazon Data Lifecycle Manager](https://docs.aws.amazon.com/ebs/latest/userguide/snapshot-lifecycle.html) or [AWS Backup plans](https://docs.aws.amazon.com/aws-backup/latest/devguide/about-backup-plans.html).
- **Elastic IP addresses without resource-level data.** [Public IP Insights](https://docs.aws.amazon.com/vpc/latest/ipam/view-public-ip-insights.html) in Amazon VPC IP Address Manager lists public IPv4 addresses by type and shows which ones are associated.
- **Stopped instances.** A stopped instance still pays for its EBS volumes. The AWS Config rule `ec2-stopped-instance` flags instances stopped for longer than a set number of days ([EC2 Detection](https://catalog.workshops.aws/awscff/en-US/playbooks/compute/ec2/governance/2-detection)).
- **Idle load balancers and VPC endpoints.** Trusted Advisor's [cost optimization checks](https://docs.aws.amazon.com/awssupport/latest/user/cost-optimization-checks.html) include idle load balancers, unassociated Elastic IP addresses, and inactive NAT gateways, but this power can't read Trusted Advisor ([Review AWS Trusted Advisor Cost Optimization pillar](https://catalog.workshops.aws/awscff/en-US/foundations/4-trusted-advisor)). For VPC endpoints, see [Idle VPC Endpoints](https://catalog.workshops.aws/awscff/en-US/playbooks/networking/vpc/10-idle-vpc-endpoints).
- **New waste after the review.** The review is a point-in-time check. The AWS Config rules [eip-attached](https://docs.aws.amazon.com/config/latest/developerguide/eip-attached.html) and [ec2-volume-inuse-check](https://docs.aws.amazon.com/config/latest/developerguide/ec2-volume-inuse-check.html) flag unattached Elastic IP addresses and EBS volumes when their configuration changes ([EBS Detection](https://catalog.workshops.aws/awscff/en-US/playbooks/storage/ebs/governance/2-detection), [Governance](https://catalog.workshops.aws/awscff/en-US/governance)).
  - Expect a same-day catch, not an instant one: eip-attached results can take up to 6 hours to appear after an evaluation.
  - If you turn on AWS Config for these rules, record only the resource types they check, `AWS::EC2::EIP` and `AWS::EC2::Volume`, to keep the Config bill down ([Recording mode optimization](https://catalog.workshops.aws/awscff/en-US/playbooks/management-and-governance/config/3-recording-mode-optimization)).
  - Keep those types on continuous recording. The rules evaluate when Config records a change, and daily recording records changes only once a day, which can delay a finding to the next day ([recording frequency](https://docs.aws.amazon.com/config/latest/developerguide/managing-recorder_console-change-recording-frequency.html)).

## Example prompts

- "Find resources I'm still paying for but not using"
- "Do we have idle Elastic IP addresses or NAT gateways, and what do they cost?"
- "Are our EBS snapshot costs growing?"
- "Run an unused resource review for us-east-1 and eu-west-1"
- "Which log groups never expire, and how much do they store?"
