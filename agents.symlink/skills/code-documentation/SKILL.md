---
name: code-documentation
description: >-
  Write concise docstrings and code comments, and document public API changes
  with version markers. Use when adding or editing these forms of documentation.
---

# Code documentation

## Comments and docstrings

- Default to no comment. Make the code clearer before adding an explanation.
- Add a comment only when a reader needs the reason for a non-obvious decision,
  edge case, performance trade-off, or magic value.
- Explain why, not what the code does.
- Describe current behavior. Do not narrate bug history, removed or refactored
  code, or agent actions such as “imported” and “updated.” Put bug history in
  the commit message.
- If a comment warns about a trap likely to recur, state the rule positively.

```javascript
// Good: The API rejects duplicate IDs, so check before writing.
if (ids.has(id)) return;

// Bad: Check whether the ID exists.
if (ids.has(id)) return;
```

## Version markers

Use markers only for user-facing public API changes, such as a changed
signature, return type, or output format. State what readers need to know; omit
the before-picture.

```text
* New in v11.
* Changed in v11: `stringOutput()` always returns a `str`.
```

A bug fix that restores behavior already promised by the API needs no marker
or doctest. Put its history in the commit message.
