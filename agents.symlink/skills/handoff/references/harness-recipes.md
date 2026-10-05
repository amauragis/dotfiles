# Harness recipes

How to start the receiver once a handoff file exists. Model names and flags change
often; if one of these fails, check the harness's `--help` or docs and update this
file.

The receiver prompt is the same everywhere:

> Use the handoff skill. Pick up `.handoff/<slug>.md`.

## Same harness, different model

### Claude Code
- Switch in-session: `/model sonnet` (or `opus`, `haiku`), then send the receiver prompt.
- Fresh session (recommended, clean context): `claude --model sonnet "Use the handoff skill. Pick up .handoff/<slug>.md"`
- Built-in plan/execute split: the `opusplan` model setting uses Opus in plan mode
  and Sonnet when executing. Pair it with this skill so the plan lands on disk
  instead of only in context.
- Subagent per role: define `.claude/agents/implementer.md` with `model: sonnet` in
  its frontmatter and tell the planner to delegate the handoff to it.

### GitHub Copilot (VS Code / CLI)
- Pick the model in the chat model picker (or the CLI's model option), start a new
  chat in agent mode, send the receiver prompt.
- Custom agents in `.github/agents/` can pin a model per role (planner vs
  implementer).

### Codex CLI
- `codex -m <model> "Use the handoff skill. Pick up .handoff/<slug>.md"`

## Across harnesses
Nothing special is needed: the handoff is a file in the repo. Make sure the skill
itself is installed where the receiving tool looks (see "Sharing this skill" in
the README), then send the receiver prompt. If the receiver doesn't support
skills, paste: "Read `.handoff/<slug>.md` and follow its Plan exactly; tick steps,
append to Log, update status when done."

## Round trip (plan → implement → review)
1. Planner (big model) writes handoff, `to: implementer`.
2. Implementer (fast model) executes, sets `status: needs-review`, `to: planner`.
3. Planner reviews the diff against Done-when and the Log, then either sets
   `done` or appends new steps and flips back to `ready`.
