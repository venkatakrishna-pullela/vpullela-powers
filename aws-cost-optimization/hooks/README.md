# Hooks (reference copies — not installed)

> [!IMPORTANT]
> The files in this directory are **not deployed when the power is installed**,
> and placing hook files here does not make them active.

Power installation deploys three components only: `POWER.md`, `mcp.json`, and
`steering/`. A `hooks/` directory is outside that set and is skipped, the same
way `README.md` and `LICENSE` are.

Hooks are also resolved **per workspace**, from that workspace's `.kiro/hooks/`
directory. The installed power directory is shared across every workspace, so
there is no location where a power-level hook could be discovered even if it
were copied here. The `"enabled": true` field inside each hook file is not a
global switch — it only applies once the file sits in a workspace's
`.kiro/hooks/`.

## Where the live definitions are

The authoritative hook definitions, along with the agent instructions that
install them into a workspace, are in
[`../steering/install-hooks.md`](../steering/install-hooks.md). That file *is*
installed and is reachable by the agent via the `readSteering` action, which is
what makes the hooks actually deliverable.

**Edit `steering/install-hooks.md` when changing hook behavior.** The copies in
this directory are kept for reference and may drift.

To install the hooks in a workspace, ask the agent:

> "Install the aws-cost-optimization cost check hooks in this workspace"
