# Claude Code user configuration

Bootstrap keeps `~/.claude` as a real, machine-local directory. It links
`CLAUDE.md`, which imports the shared instructions from `~/.agents/AGENTS.md`,
and links each skill in `agents.symlink/skills/` into `~/.claude/skills/`
individually, since Claude Code does not read `~/.agents/skills`. Links to
skills removed from the repo are pruned. `~/.claude/skills/synced/` belongs to
the Claude app and is left alone. Re-run bootstrap after adding a skill.

If `~/.claude/settings.json` does not exist, bootstrap copies
`settings.example.json` there with owner-only permissions. Existing settings are
never overwritten, including on subsequent runs. Changes to the example must be
applied manually to existing installations.

Keep permissions, secrets, and machine-specific paths out of the example.
Configure plugin marketplaces separately on each machine. Claude can update the
live settings without modifying a tracked file.

Automatic `settings.local.json` overrides are project-scoped, not global user
overrides.
