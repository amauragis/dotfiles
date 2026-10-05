---
title: <one-line description of the work>
status: ready          # draft | ready | in-progress | blocked | needs-review | done
from: <agent/model, e.g. claude-code/opus>
to: <agent/model, e.g. claude-code/sonnet, copilot, codex, any>
created: <YYYY-MM-DD>
---

## Goal
<What outcome the user wants, in plain terms. One short paragraph.>

## Done when
- [ ] <Observable acceptance criterion, e.g. "`make test` passes and CAN0 receives frames at 2 Mbit">
- [ ] <...>

## State
```
<paste output of scripts/repo-state.sh>
```

## Context
<Only what the receiver can't get by reading the code: background, the user's
preferences for this task, links to docs/issues, relevant files to read first.>

Read first:
- `<path>` — <why>

## Decisions
- <Decision> — because <reason>.

## Constraints and non-goals
- Must: <...>
- Must not: <...>
- Out of scope: <...>

## Plan
1. [ ] <Step>
   - Files: `<path>`, `<path>`
   - Details: <interfaces, exact names, gotchas>
   - Verify: `<command>` → <expected result>
2. [ ] <Step>
   - Files:
   - Details:
   - Verify:

## Judgment calls (receiver must ask, not decide)
- <Choice left open and why>

## Tried and rejected
- <Approach> — <why it failed or was ruled out>

## Open questions
- <none>

## Log
<!-- Receivers append here: date, agent/model, what was done, deviations, verify results. -->
