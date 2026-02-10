Review what we just implemented in this session and identify any technical debt we introduced or should address soon.

Read the memory bank at `.kilocode/rules/memory-bank/` (context.md and tasks.md) to understand what was done this session.

Then review the recent changes (use `git diff main` or check recently modified files) and evaluate:

1. **Debt we introduced** — Shortcuts, TODOs, hardcoded values, missing error handling, incomplete test coverage, known limitations we accepted to ship
2. **Debt we discovered** — Pre-existing issues uncovered while working (brittle patterns, outdated dependencies, missing abstractions, code that should be refactored)
3. **Debt we should address soon** — Things that are fine now but will become problems at scale or when the next feature is built on top

For each item, classify:
- **Pay now** — Will cause bugs or block upcoming work if not addressed
- **Pay soon** — Should be a ticket in the next planning session
- **Pay later** — Note it, but it's not urgent

Create Plane tickets (status: Backlog) for any "Pay now" or "Pay soon" items in the **$ARGUMENTS** project. Add a `tech-debt` label if one exists (create it if not).

Also read `issues.md` if it exists (the parking lot for observations). For each open item:
- If it's "Pay now" or "Pay soon," promote it to a Plane ticket
- If it was resolved during this session, mark it Resolved with a note
- Leave "Pay later" items in the file

Update the memory bank `context.md` with a "Tech Debt Notes" entry summarizing what was found.
