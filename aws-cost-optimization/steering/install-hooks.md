---
inclusion: manual
---

# Installing the Cost Check Hooks

This power ships three agent hooks that review infrastructure-as-code for cost
optimization issues each time Kiro edits a matching file: one for CDK, one for
CloudFormation, and one for Terraform.

Kiro's file hooks respond only to changes the agent makes. Edits the user makes
in the editor don't trigger them, so a file the user changed by hand is reviewed
only when the user asks for a review.

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

**The definitions in this file are the only ones that ship.** This power's
`hooks/` directory holds no hook files for that reason — see
`hooks/README.md`.

The definitions use the hook schema that Kiro IDE 1.0 and Kiro CLI V3 load:
standalone JSON files at `.kiro/hooks/<name>.json` with `"version": "v1"`, a
PascalCase `trigger`, a `matcher` regular expression, and an `action`.

## Agent instructions

When the user asks to install these hooks:

1. **Detect what the workspace actually contains.** Look for CDK sources
   (`cdk.json`, a `lib/` or `stacks/` directory with stack definitions),
   CloudFormation templates, and Terraform files (`*.tf`).
2. **Write only the hooks that apply.** Do not install the Terraform hook into a
   workspace with no Terraform. If none of the three apply, say so rather than
   installing hooks that can never fire.
3. **Adapt each `matcher` to the real layout.** The `matcher` is a regular
   expression tested against the saved file's path. The defaults below assume a
   conventional CDK/CloudFormation project with `lib/`, `stacks/`,
   `templates/`, and `cloudformation/` directories. Rewrite the expression to
   match where the user's IaC actually lives — a hook whose matcher matches
   nothing is worse than no hook, because it looks installed.
4. **Create `.kiro/hooks/` if it does not exist**, then write each hook as its
   own file using the filenames given below.
5. **Check for hooks from an earlier install.** Earlier versions of this guide
   wrote `.kiro/hooks/cdk-cost-check-on-save.kiro.hook`,
   `cfn-cost-check-on-save.kiro.hook`, and `terraform-cost-check-on-save.kiro.hook`
   in the IDE 0.x format, which Kiro IDE 1.0 shows as legacy hooks. If any of
   them exist, tell the user and offer to delete them so each review doesn't
   run twice.
6. **Confirm what was installed** and which hooks were skipped, with the reason.
   Tell the user that the hooks review files when Kiro edits them, not when the
   user edits and saves a file in the editor.

## Hook definitions

### `.kiro/hooks/cdk-cost-check-on-save.json`

```json
{
  "version": "v1",
  "hooks": [
    {
      "name": "CDK Cost Check on Save",
      "description": "When Kiro edits a CDK source file, review it for cost optimization issues against the aws-cost-optimization standards",
      "trigger": "PostFileSave",
      "matcher": "(^|/)(lib|stacks)/.+\\.(ts|py|java)$",
      "action": {
        "type": "agent",
        "prompt": "Review the saved CDK file for AWS cost optimization issues. Only flag issues if this appears to be AWS infrastructure code; if it is not, stay silent. Check for: oversized or previous-generation instance types (prefer Graviton/current-gen), EbsDeviceVolumeType.GP2 instead of GP3, DatabaseInstanceEngine or instance classes using db.t families for production, missing removalPolicy on stateful constructs, missing Schedule tags on EC2/RDS resources, Lambda functions with over-provisioned memory, and missing enablePerformanceInsights on RDS. For the full set of standards, load the power's developer guide: call action \"readSteering\" with powerName=\"aws-cost-optimization\", steeringFile=\"developer-cost-optimization.md\"."
      }
    }
  ]
}
```

### `.kiro/hooks/cfn-cost-check-on-save.json`

```json
{
  "version": "v1",
  "hooks": [
    {
      "name": "CloudFormation Cost Check on Save",
      "description": "When Kiro edits a CloudFormation template, review it against the cost-optimization standards and flag any violations",
      "trigger": "PostFileSave",
      "matcher": "(^|/)(templates|cloudformation|lib|stacks)/.+\\.ya?ml$",
      "action": {
        "type": "agent",
        "prompt": "Review the saved CloudFormation template against the cost-optimization standards. Only flag issues if this is actually a CloudFormation template; if it is not, stay silent. Flag any violations: gp2 storage, db.t instance families, missing DeletionPolicy or UpdateReplacePolicy on stateful resources, missing Schedule tags on RDS/EC2, string-quoted Number defaults, missing MinValue/MaxValue on Number parameters, missing Performance Insights on RDS, and Fn::Join with an empty delimiter instead of !Sub. For the full set of standards, load the power's developer guide: call action \"readSteering\" with powerName=\"aws-cost-optimization\", steeringFile=\"developer-cost-optimization.md\"."
      }
    }
  ]
}
```

### `.kiro/hooks/terraform-cost-check-on-save.json`

```json
{
  "version": "v1",
  "hooks": [
    {
      "name": "Terraform Cost Check on Save",
      "description": "When Kiro edits a Terraform file, review it for cost optimization issues against the aws-cost-optimization standards",
      "trigger": "PostFileSave",
      "matcher": "\\.tf$",
      "action": {
        "type": "agent",
        "prompt": "Review the saved Terraform file for AWS cost optimization issues. Only flag issues if this file provisions AWS resources; if it does not, stay silent. Check for: oversized or previous-generation instance types (prefer current-gen like m7g, c7g, r7g), gp2 EBS volumes instead of gp3, db.t instance families for production RDS, missing deletion_protection on stateful resources, missing Schedule tags on EC2/RDS resources, over-provisioned IOPS, missing performance_insights_enabled on RDS, and hardcoded regions that miss cheaper alternatives. For the full set of standards, load the power's developer guide: call action \"readSteering\" with powerName=\"aws-cost-optimization\", steeringFile=\"developer-cost-optimization.md\"."
      }
    }
  ]
}
```

## Verifying installation

After writing the files, confirm each one is valid JSON with `"version": "v1"`
and that its `matcher` matches the path of at least one IaC file in the
workspace. Hooks load when a session starts, so tell the user to start a new
session before testing. A hook only fires on edits Kiro makes after the hook is
active. To test it, the user can ask Kiro to make a small change to a matching
file, such as adding a tag.

## Removing the hooks

Delete the corresponding files from `.kiro/hooks/`, or set `"enabled": false` on
a hook to keep it in place while silencing it.
