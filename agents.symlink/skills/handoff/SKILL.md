---
name: handoff
description: Write or pick up a structured handoff so work moves cleanly between agents (Claude, Claude Code, Copilot, Codex, etc.) or between models in one harness (e.g. plan with Opus, implement with Sonnet). Use when asked to "hand off", "write a handoff", "pick up the handoff", "plan this for another model", or when resuming work another agent started.
---

# Handoff

A handoff is a single Markdown file in the repo that carries everything the next
agent needs, so it never has to re-derive context or guess intent. The file is the
contract; chat history is not. Any agent that can read a file can receive one.

Handoffs live in `.handoff/` at the repo root, one file per unit of work:
`.handoff/<short-slug>.md`. Commit them or gitignore them; either works, but they
must be on disk before the sender stops.

## Decide your role first

- **Sending** (you are finishing a phase: planning, a partial implementation, a
  review) → follow "Writing a handoff".
- **Receiving** (the user points you at a handoff, or `.handoff/` has a file with
  `status: ready`) → follow "Picking up a handoff".
- **Returning** (you were the receiver and are done or blocked) → update the same
  file per "Closing the loop".

## Writing a handoff

1. Capture repo state by running `scripts/repo-state.sh` (or the equivalent git
   commands by hand: branch, HEAD sha, `git status --short`, `git diff --stat`).
   Paste its output into the State section verbatim.
2. Copy `references/template.md` to `.handoff/<slug>.md` and fill every section.
   Write "none" rather than deleting a section, so the receiver knows it was
   considered.
3. Apply the receiver test to every step in the Plan: *could a capable engineer
   who has never seen this conversation do this step without asking a question?*
   If not, add the missing detail: exact file paths, function names, the
   interface to match, the command that proves it worked.
4. Put every decision you made in Decisions **with the reason**. A receiver that
   doesn't know why will "fix" it.
5. Put every choice you deliberately did *not* make in Judgment calls. These are
   the places the receiver must stop and ask rather than improvise.
6. Record dead ends in Tried and rejected, so the receiver doesn't repeat them.
7. Set `status: ready` and `to:` in the frontmatter. Tell the user the file path
   and the one-line command or prompt to start the receiver (see
   `references/harness-recipes.md`).

### Extra rules when planning for a smaller or cheaper model

The planner's job is to spend its reasoning so the implementer doesn't have to.

- Break work into steps small enough to finish and verify independently. Prefer
  10 narrow steps over 3 broad ones.
- Each step names the files it touches and ends with a **Verify** line: a command,
  test, or observable result.
- Specify interfaces and signatures exactly; leave bodies to the implementer.
- Call out traps explicitly ("`foo()` looks reusable but mutates global state;
  don't call it here").
- Don't paste large code blocks the implementer will write anyway; paste only
  what is load-bearing (a tricky regex, a protocol frame layout, a migration).

## Picking up a handoff

1. Read the whole handoff before touching anything.
2. Check the State section against reality (`scripts/repo-state.sh`). If the
   branch or sha differs, or there are unexpected uncommitted changes, stop and
   tell the user before proceeding.
3. Restate the Goal and Done-when in one or two sentences to the user (or in the
   file's Log if running unattended). If you can't, the handoff is incomplete:
   ask.
4. Execute the Plan **in order**. Do not re-plan or redesign. Tick each step's
   checkbox in the file as it passes its Verify line.
5. If a step is ambiguous, contradicts the code, or hits a Judgment call: stop
   that step, write the problem under Open questions, and either ask the user or
   continue with steps that don't depend on it.
6. Respect Constraints and Non-goals even if you see a "better" approach. Note
   the idea under Log instead.

## Closing the loop

When you finish or get blocked, update the same file:

- Tick completed steps; leave others unticked.
- Append to **Log**: what you did, any deviations from the plan and why, and the
  final Verify results.
- Refresh the **State** section.
- Set `status:` to `done`, `blocked`, or `needs-review`, and set `to:` to whoever
  should act next (often the original planner).

Never delete a handoff's history; append to it. The file becomes the audit trail.
