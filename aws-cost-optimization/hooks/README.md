# Hooks (definitions live in `steering/`)

> [!IMPORTANT]
> Hook files placed in this directory are **not deployed when the power is
> installed** and will never activate. Do not add them here.

Power installation deploys three components only: `POWER.md`, `mcp.json`, and
`steering/`. A `hooks/` directory is outside that set and is skipped, the same
way `README.md` and `LICENSE` are. The skip is silent.

Hooks are also resolved **per workspace**, from that workspace's `.kiro/hooks/`
directory. The installed power directory is shared across every workspace, so
there is no location where a power-level hook could be discovered even if it
were copied here. The `"enabled": true` field inside a hook file is not a global
switch — it only applies once the file sits in a workspace's `.kiro/hooks/`.

## Where the definitions are

The hook definitions, along with the agent instructions that install them into a
workspace, are in
[`../steering/install-hooks.md`](../steering/install-hooks.md). That file *is*
installed and is reachable by the agent via the `readSteering` action, which is
what makes the hooks deliverable.

**Edit `steering/install-hooks.md` to change hook behavior.**

To install the hooks in a workspace, ask the agent:

> "Install the aws-cost-optimization cost check hooks in this workspace"

This directory is retained only to carry this note. Earlier revisions kept
copies of the three `.kiro.hook` files here; they were removed because they
duplicated the definitions in `steering/install-hooks.md` and could drift out of
sync. See the git history for those revisions.
