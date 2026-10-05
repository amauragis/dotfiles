# handoff skill

Portable Agent Skill (SKILL.md standard) for passing work between agents and models.

## Sharing this skill

Keep one canonical copy and link it into each tool's skill directory.

Per-repo (shared with anyone who clones):
```
mkdir -p .agents/skills && cp -r handoff .agents/skills/
ln -s ../.agents/skills .claude/skills    # Claude Code
ln -s ../.agents/skills .github/skills    # Copilot (also reads .claude/skills and .agents/skills)
```

Personal (all repos):
```
mkdir -p ~/.agents/skills && cp -r handoff ~/.agents/skills/
ln -s ~/.agents/skills/handoff ~/.claude/skills/handoff
ln -s ~/.agents/skills/handoff ~/.copilot/skills/handoff
ln -s ~/.agents/skills/handoff ~/.codex/skills/handoff
```

Claude (app): zip the `handoff/` folder and upload it as a custom skill in Settings.

Remember `chmod +x scripts/repo-state.sh`.
