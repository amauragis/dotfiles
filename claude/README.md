# Claude Code user configuration

Bootstrap keeps `~/.claude` as a real, machine-local directory. It links only
`CLAUDE.md`, which imports the shared instructions from `~/.agents/AGENTS.md`.

If `~/.claude/settings.json` does not exist, bootstrap copies
`settings.example.json` there with owner-only permissions. Existing settings are
never overwritten, including on subsequent runs. Changes to the example must be
applied manually to existing installations.

Keep permissions, secrets, and machine-specific paths out of the example.
Configure plugin marketplaces separately on each machine. Claude can update the
live settings without modifying a tracked file.

Automatic `settings.local.json` overrides are project-scoped, not global user
overrides.
