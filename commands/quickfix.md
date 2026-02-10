Read the memory bank at `.kilocode/rules/memory-bank/` (brief → context → tasks) and the project CLAUDE.md. You can skip the full memory bank deep-read — just enough to understand where things stand.

This is a **quick fix** — skip the full planning workflow (no G1/G2).

Pull the latest from main before starting (`git pull` on main, or `git fetch origin && git merge origin/main` on a feature branch). Then check the current git branch. If on main, you'll create a fix branch before writing code.

I'll describe the issue. Then:

1. **Understand the problem** — Read the relevant code. Use subagents for research if needed.
2. **Propose the fix** — Show me what you plan to change and why. Wait for my approval.
3. **Create a fix branch** — Branch from main (e.g., `fix/FIN-33-rounding-error`) before making changes.
4. **TDD if applicable** — If the fix is testable, write a failing test first, then fix. For trivial fixes (typos, config changes), skip TDD.
5. **Implement the fix** — Minimal change, strictly scoped to the issue. Commit with ticket ID in message.
6. **G3 — Staff Engineer reviews code** — Spawn a Staff Level Engineer subagent (read `~/.claude/prompts/staff-engineer.md`, Code Review mode). Pass the diff and context. Fix any P0s.
7. **Push and create PR** — Push the branch, create a PR with a summary of what was fixed. If the project has collaborators, leave open for review.
8. **Bug retrospective** — Ask: "Why didn't TDD catch this?" Categorize the root cause (missing concurrency test? untested lifecycle scenario? boundary condition?) and add it to the `## Test Blind Spots` section in context.md. This trains future test plans.
9. **Capture unrelated observations** — If you discover an unrelated issue while fixing the bug (tech debt, inconsistency, edge case), add it to `issues.md` rather than fixing it in scope.
10. **Update memory bank** — Update context.md with what was fixed, the blind spot entry, and ticket status/PR link.

The project is: **$ARGUMENTS**
