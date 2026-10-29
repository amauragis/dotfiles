---
name: "coding-handoff"
description: "Write a .handoff/HANDOFF.md capturing plan and live state of a coding task so a fresh agent can resume, and resume from one by checking it against the repo first."
---

# Coding handoff

A handoff exists because the next agent starts with nothing but the repo and this file. The code already says *what* exists. The handoff has to carry everything the code can't: what the work is for, what has been decided and why, what was tried and abandoned, what's verified versus merely believed, and exactly what to do next.

The skill has two modes. Work out which one from the request:

- **Write** — "hand off", "save state", "checkpoint", "I'm starting a new session". You have the context; capture it.
- **Resume** — "pick up the handoff", "continue from HANDOFF.md", or you've been started in a repo with `.handoff/HANDOFF.md` and asked to keep going. You have no context; rebuild it and check it's still true.

---

## Write mode

### 1. Gather the facts from the repo, not from memory

Take a git snapshot from the repo root (all read-only):

```bash
git status --short --branch                       # branch, upstream ahead/behind, staged/unstaged/untracked
git log -1 --format='%h %s (%cr)'                 # HEAD
base=$(for b in main master develop trunk; do git rev-parse -q --verify $b >/dev/null && echo $b && break; done)
[ -n "$base" ] && git log --oneline "$(git merge-base HEAD $base)..HEAD" | head -15   # this branch's commits
git diff --cached --stat; git diff --stat          # size of staged / unstaged changes
git stash list
gd=$(git rev-parse --git-dir); ls -d $gd/rebase-merge $gd/rebase-apply $gd/MERGE_HEAD $gd/CHERRY_PICK_HEAD 2>/dev/null  # op in progress?
```

If an upstream is missing, note that nothing on the branch is pushed. If a rebase/merge is in progress, say so at the top of the handoff. Not a git repo: list changed files by hand. Fill the Git state section from this output rather than recalling what you think you changed — your memory of the session is exactly what drifts, and the next agent will check these numbers.

Then run the project's verification commands (tests, build, lint — whatever this session has been using) **now**, and record what actually happened. "Tests passed earlier" is a belief; "`pytest tests/` → 41 passed, 1 failed (`test_retry_after`) at abc1234 + uncommitted changes" is a fact. If a run takes too long or can't run here, say that instead of guessing.

### 2. Write `.handoff/HANDOFF.md`

Use the template at the end of this file. Fill every section; if a section genuinely has nothing, write "None" so the reader knows it was considered rather than forgotten.

What makes a handoff good:

- **Written for a stranger.** The reader is capable but has never seen this conversation. Don't refer to "the approach we discussed" or "the bug from earlier" — say what it is. Define any shorthand the user introduced.
- **Pointers, not pastes.** Reference `path/to/file.py:120-160` and function names instead of copying code blocks. The reader can open the file; a pasted copy goes stale the moment someone edits it. Short snippets are fine when the *exact* text matters (an error message, a failing assertion, a config value).
- **Verified vs. believed, labeled.** When you state something about behavior, say how you know: ran it, read it, or assuming it. The reader will trust labeled facts and re-check the rest.
- **Dead ends with the reason.** An abandoned approach without the reason it failed will get retried. "Tried `threading.Lock` around the bucket refill — deadlocked because `refill()` is called from inside `acquire()`" saves the next agent an hour.
- **User decisions are sacred.** Anything the user explicitly decided or asked for goes in Decisions with "(user)" so the next agent doesn't relitigate it. Your own judgment calls are marked "(agent)" — the next agent may revisit those if it finds a reason.
- **One concrete next step.** The reader should be able to start working within a minute of reading. "Continue implementing rate limiting" is not a next step; "Make `test_retry_after` pass: `RateLimiter.acquire()` in `client/ratelimit.py:88` ignores the `Retry-After` header — parse it in `_handle_429()` and sleep that long" is.
- **Short enough to read.** Aim for something a reader takes in within a few minutes — usually 60–200 lines. A handoff that reproduces the whole session defeats the point of a clean context. Cut narrative ("first I looked at…, then…"); keep conclusions.

### 3. Keep it out of the way

- If `.handoff/HANDOFF.md` already exists, it's the previous handoff. Move it to `.handoff/archive/HANDOFF-<YYYYMMDD-HHMM>.md` before writing the new one, and carry forward anything from it that's still open.
- Add `.handoff/` to `.git/info/exclude` (local-only, unlike `.gitignore`) so the file doesn't show up in `git status` or get swept into a commit. Don't edit `.gitignore` and don't commit the handoff unless the user asks — e.g. they're resuming on a different machine, in which case committing it on the work branch is reasonable.
- Don't commit, stash, or reset the user's work to make the handoff "cleaner." Describe the tree as it is. If uncommitted work would be at risk (say, they're about to switch machines), point that out in your reply and let them decide.

### 4. Finish

Tell the user in a couple of lines where the file is, the one-sentence state of the work, and the next step. Give them the line to start the next agent with:

> Read `.handoff/HANDOFF.md` and resume the task.

---

## Resume mode

The handoff was true when it was written. Your job is to find out whether it still is before you build on it — the user or another agent may have touched the repo since.

1. **Read `.handoff/HANDOFF.md` in full**, then read the files it points to for the next step. Skim `.handoff/archive/` only if the current handoff references it or something doesn't add up.
2. **Check for drift.** Take the same git snapshot as in Write mode and compare with the handoff's Git state: branch, HEAD commit, the set of modified/untracked files, stashes. Then rerun the verification commands it lists and compare results.
3. **Report before working.** Give the user a short summary: the goal in a sentence, where things stand, and any drift you found ("HEAD is now `9f2e…`, two commits past the handoff — `fix: retry header parsing` looks like it addressed the next step"; "handoff says 1 failing test, now 3"). If there's no drift, say so in one line.
4. **Decide whether to proceed.**
   - No drift, or drift that's clearly benign: start on the next step.
   - Drift that changes the plan (the next step looks already done, new failures, files the handoff mentions are gone): explain what changed and what you think the new next step is, and ask before doing anything substantial.
   - Open questions addressed to the user in the handoff: ask them now if the next step depends on them; otherwise proceed and raise them when relevant.
5. **Respect what was settled.** Follow "(user)" decisions unless the user changes them. Don't retry anything under Dead ends unless you have a concrete reason the original failure no longer applies — and say what that reason is.
6. **Keep the handoff alive.** Once you've finished the next step or the plan changes, the old file is stale. When the user asks for a new handoff (or the session is wrapping up), write a fresh one in Write mode — the archive step keeps the history.

---

## Handoff template

Keep the headings in this order — the resuming agent reads top to bottom and the order mirrors what it needs first. Replace the italic guidance with content.

```markdown
# Handoff: <short task name>

Written <YYYY-MM-DD HH:MM> · branch `<branch>` · HEAD `<short-sha>` (<+ uncommitted changes | clean tree>)

## Goal
_One to three sentences: what the work is for and what "done" looks like. Include the user's acceptance criteria if they gave any._

## Status
_Where it stands right now, in a few bullets. Lead with a one-line summary ("Feature works for the happy path; retry handling half-done; 1 test failing")._

## Next step
_The single most concrete action to take first: file, function, what to change, how you'll know it worked. Then, optionally, 2–5 following steps in order._

1.
2.

## Plan
_The remaining plan as a checklist. Mark done items. Keep it to the work that's left plus enough done items for orientation._

- [x]
- [ ]

## Decisions
_Choices already made, each with a short reason. Tag who made it: (user) = do not relitigate; (agent) = judgment call, may revisit with cause._

- (user)
- (agent)

## Dead ends
_Approaches tried and abandoned, each with why it failed. "None" if none._

-

## Open questions
_Split by who answers. Say what each one blocks, if anything._

**For the user:**
-

**For the next agent to figure out:**
-

## Verify
_The commands to build/test/lint/run, and what they returned when this handoff was written. Note anything that couldn't be run here and why._

| Command | Result at handoff |
|---|---|
| `<cmd>` | <e.g. 41 passed, 1 failed: test_retry_after> |

## Git state
_From the git snapshot. Note anything at risk (uncommitted work, unpushed commits, stashes that matter)._

- Branch / upstream:
- HEAD:
- Recent commits on this branch:
- Staged:
- Modified (unstaged):
- Untracked:
- Stashes:

## Key files
_Where the relevant code lives, with one line on each. Pointers (path:line, symbol names), not pasted code._

- `path/to/file` —

## Gotchas
_Non-obvious things about the environment or codebase the next agent would trip over: env vars, flaky tests, slow commands, generated files not to edit, quirks the user mentioned. "None" if none._

-
```