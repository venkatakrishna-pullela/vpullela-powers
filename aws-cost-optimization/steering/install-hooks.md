---
inclusion: manual
---

# Installing the Cost Check Hooks

This power ships three agent hooks that review infrastructure-as-code for cost
optimization issues each time a file is saved: one for CDK, one for
CloudFormation, and one for Terraform.

## Why the agent has to install these

Power installation deploys three components only: `POWER.md`, `mcp.json`, and
`steering/`. A `hooks/` directory in a power repository is **not** copied to the
installed power, so shipping hook files alongside the power does not make them
active.

Hooks are also resolved **per workspace**, from that workspace's `.kiro/hooks/`
directory. The installed power directory is shared across every workspace, so
there is no location where a power-level hook could be discovered even if it
were copied. The hook definitions below are therefore templates that the agent
writes into the user's workspace on request.

The copies under this power's `hooks/` directory are kept for reference only.
**The definitions in this file are authoritative.**

## Agent instructions

When the user asks to install these hooks:

1. **Detect what the workspace actually contains.** Look for CDK sources
   (`cdk.json`, a `lib/` or `stacks/` directory with stack definitions),
   CloudFormation templates, and Terraform files (`*.tf`).
2. **Write only the hooks that apply.** Do not install the Terraform hook into a
   workspace with no Terraform. If none of the three apply, say so rather than
   installing hooks that can never fire.
3. **Adapt each `patterns` array to the real layout.** The defaults below assume
   a conventional CDK/CloudFormation project with top-level `lib/`, `stacks/`,
   `templates/`, and `cloudformation/` directories. Rewrite the globs to match
   where the user's IaC actually lives — a hook with patterns that match nothing
   is worse than no hook, because it looks installed.
4. **Create `.kiro/hooks/` if it does not exist**, then write each hook as its
   own file using the filenames given below.
5. **Confirm what was installed** and which hooks were skipped, with the reason.

## Hook definitions

### `.kiro/hooks/cdk-cost-check-on-save.kiro.hook`

```json
{
  "enabled": true,
  "name": "CDK Cost Check on Save",
  "description": "When a CDK source file is saved, automatically review it for cost optimization issues against the aws-cost-optimization standards",
  "version": "1",
  "when": {
    "type": "fileEdited",
    "patterns": [
      "lib/**/*.ts",
      "stacks/**/*.ts",
      "lib/**/*.py",
      "stacks/**/*.py",
      "lib/**/*.java",
      "stacks/**/*.java"
    ]
  },
  "then": {
    "type": "askAgent",
    "prompt": "Review the edited CDK file for AWS cost optimization issues. Only flag issues if this appears to be AWS infrastructure code; if it is not, stay silent. Check for: oversized or previous-generation instance types (prefer Graviton/current-gen), EbsDeviceVolumeType.GP2 instead of GP3, DatabaseInstanceEngine or instance classes using db.t families for production, missing removalPolicy on stateful constructs, missing Schedule tags on EC2/RDS resources, Lambda functions with over-provisioned memory, and missing performanceInsightEnabled on RDS. For the full set of standards, load the power's guidance by calling the kiro_powers tool with action=\"readSteering\", powerName=\"aws-cost-optimization\", steeringFile=\"developer-cost-optimization.md\"."
  }
}
```

### `.kiro/hooks/cfn-cost-check-on-save.kiro.hook`

```json
{
  "enabled": true,
  "name": "CloudFormation Cost Check on Save",
  "description": "When a CloudFormation template is saved, automatically review it against the cost-optimization standards and flag any violations",
  "version": "1",
  "when": {
    "type": "fileEdited",
    "patterns": [
      "templates/**/*.yaml",
      "templates/**/*.yml",
      "cloudformation/**/*.yaml",
      "cloudformation/**/*.yml",
      "lib/**/*.yaml",
      "lib/**/*.yml",
      "stacks/**/*.yaml",
      "stacks/**/*.yml"
    ]
  },
  "then": {
    "type": "askAgent",
    "prompt": "Review the edited CloudFormation template against the cost-optimization standards. Only flag issues if this is actually a CloudFormation template; if it is not, stay silent. Flag any violations: gp2 storage, db.t instance families, missing DeletionPolicy or UpdateReplacePolicy on stateful resources, missing Schedule tags on RDS/EC2, string-quoted Number defaults, missing MinValue/MaxValue on Number parameters, missing Performance Insights on RDS, and Fn::Join with an empty delimiter instead of !Sub. For the full set of standards, load the power's guidance by calling the kiro_powers tool with action=\"readSteering\", powerName=\"aws-cost-optimization\", steeringFile=\"developer-cost-optimization.md\"."
  }
}
```

### `.kiro/hooks/terraform-cost-check-on-save.kiro.hook`

```json
{
  "enabled": true,
  "name": "Terraform Cost Check on Save",
  "description": "When a Terraform file is saved, automatically review it for cost optimization issues against the aws-cost-optimization standards",
  "version": "1",
  "when": {
    "type": "fileEdited",
    "patterns": [
      "**/*.tf"
    ]
  },
  "then": {
    "type": "askAgent",
    "prompt": "Review the edited Terraform file for AWS cost optimization issues. Only flag issues if this file provisions AWS resources; if it does not, stay silent. Check for: oversized or previous-generation instance types (prefer current-gen like m7g, c7g, r7g), gp2 EBS volumes instead of gp3, db.t instance families for production RDS, missing deletion_protection on stateful resources, missing Schedule tags on EC2/RDS resources, over-provisioned IOPS, missing enable_performance_insights on RDS, and hardcoded regions that miss cheaper alternatives. For the full set of standards, load the power's guidance by calling the kiro_powers tool with action=\"readSteering\", powerName=\"aws-cost-optimization\", steeringFile=\"developer-cost-optimization.md\"."
  }
}
```

## Verifying installation

After writing the files, confirm each one is valid JSON and that its patterns
match at least one file in the workspace. A hook only fires on files saved after
it is installed, so the user will not see output until their next edit.

## Removing the hooks

Delete the corresponding files from `.kiro/hooks/`, or set `"enabled": false` in
a hook to keep it in place while silencing it.
