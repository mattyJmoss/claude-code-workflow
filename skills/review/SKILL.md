---
name: review
description: >
  Single-pass code review before committing. Reviews staged changes for
  architecture coherence, correctness, and potential issues. Replaces
  the multi-reviewer commit-gate with one focused pass.
user-invocable: true
---

# Review — Single-Pass Code Review

Run a focused code review on staged or uncommitted changes before committing.
One pass, one verdict — not three parallel reviewers.

## Process

### Step 1: Read the Diff
Run `git diff --cached` (staged changes). If nothing is staged, run
`git diff` (unstaged changes) and note that nothing is staged yet.

### Step 2: Review Through These Lenses

**Architecture & Correctness:**
- Does this respect existing architectural boundaries?
- Are there race conditions, stale closures, or timing issues?
- Is state at the right level? Any derived state that could desync?
- Are errors handled explicitly, not swallowed?

**Security (for this project):**
- Private keys never leave the device
- Audio is encrypted before upload
- Inputs validated on the Worker side
- No custom crypto — libsodium primitives only

**Quality:**
- Any `console.log` without `__DEV__` guard in hot paths?
- Any `any` types that should be `unknown` with type guards?
- Any effects missing cleanup functions?
- Any animations using old `Animated` API instead of Reanimated?

**Scope:**
- Does this change do one thing, or is it a mega-commit that should be split?
- Any unrelated changes bundled in?

### Step 3: Verdict

```markdown
## Review

**Verdict:** PASS | CONCERNS | CRITICAL

### Issues
- [CRITICAL] Description — what breaks and how to fix
- [CONCERN] Description — worth considering before committing
- [NOTE] Observation — not blocking

### What's Good
[1-2 things done right]
```

## Rules
- If CRITICAL: recommend fixing before committing
- If CONCERNS only: note them but don't block
- Keep it brief — this is a quick sanity check, not a design review
- Don't flag style issues that a linter would catch
- Don't suggest refactors beyond the scope of the change
