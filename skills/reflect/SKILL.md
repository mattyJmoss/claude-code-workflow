---
name: reflect
description: >
  Reviews accumulated correction patterns from the corrections log and
  proposes permanent rules for CLAUDE.md or .claude/rules/ files. Run
  periodically (weekly or after a series of corrections) to turn
  one-time feedback into lasting improvements. Invoke with /reflect.
user-invocable: true
---

# Reflect — Self-Improvement Processor

You review the corrections log to identify recurring patterns and convert
them into permanent rules.

## Process

### Step 1: Read the Corrections Log
Read `~/.claude/corrections-log.jsonl`. If the file doesn't exist or is
empty, report "No corrections logged yet" and exit.

### Step 2: Analyze Patterns
Group corrections by:
- **Project** — are corrections concentrated in one project?
- **Pattern type** — are they about code style? Architecture? Testing?
  Product decisions? Design choices?
- **Recurrence** — has the same correction appeared 2+ times?
- **Recency** — focus on the last 30 days unless doing a deep review

### Step 3: Propose Rules
For each recurring pattern (2+ occurrences), draft a rule:

```
**Pattern:** [What keeps getting corrected]
**Occurrences:** [Count and dates]
**Examples:** [1-2 specific correction prompts]
**Proposed Rule:** [Clear, actionable instruction]
**Location:** [Where to add it — which CLAUDE.md or rules file]
```

### Step 4: Present for Approval
Show all proposed rules and ask:
- "Here are [N] patterns I found. For each one, should I:
  1. Add as a permanent rule to the suggested location
  2. Skip — this was a one-time correction
  3. Modify — the rule needs rewording"

### Step 5: Apply Approved Rules
For each approved rule:
- Add it to the specified CLAUDE.md or .claude/rules/ file
- Use the `#` shortcut format if it's a simple instruction
- For complex rules, add as a new section with context

### Step 6: Archive Processed Entries
After processing, move reviewed entries to
`~/.claude/corrections-log-archive.jsonl` so they don't get re-processed.
Keep the main log file for new entries only.

## Output Format

```
# Reflection Report — [Date]

## Corrections Analyzed: [N] entries from [date range]

### Pattern 1: [Description]
**Occurrences:** 4 times (Mar 2, Mar 5, Mar 9, Mar 14)
**Project:** COPY
**Examples:**
- "No, don't use useState for that — put it in the Zustand store"
- "I told you, audio state lives in AudioStore"
**Proposed Rule:** "In COPY, all audio-related state lives in AudioStore
(Zustand), never in component-local useState."
**Location:** COPY/.claude/rules/architecture.md → State Management section

### Pattern 2: [Description]
...

## Summary
- Patterns found: [N]
- Rules proposed: [N]
- Awaiting your approval to apply.
```

## When to Run
- After a frustrating session where you corrected Claude multiple times
- Weekly as part of workflow hygiene
- After onboarding a new project (lots of initial corrections are normal)
