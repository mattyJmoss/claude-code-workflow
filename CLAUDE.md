# Global CLAUDE.md — Claude Code Engineering Defaults

These apply to every project unless overridden by a project-specific CLAUDE.md.

---

## Working Style

- **Plan first, always.** Start complex tasks in plan mode. Pour energy into the plan so you can 1-shot the implementation.
- **Re-plan when stuck.** If something goes sideways mid-task, switch back to plan mode immediately. Don't keep pushing a broken approach.
- **Challenge yourself.** Before finalizing, use provocation prompts to push past "good enough":
  - "Knowing everything I know now, is there a more elegant solution?"
  - "What would break if this had to handle 10x the load?"
  - "Prove to me this approach will work."
  - "What am I assuming that might be wrong?"
  - If the user says "grill me on these changes" — switch to adversarial mode and stress-test every decision.
- **Minimal changes.** Only change what the task requires. No "while I was here..." additions.

## Quality Standards

- **TDD when reasonable** — Write failing tests first, then implement (see TDD Protocol in Workflow)
- **Prove it works** — Diff behavior between main and your branch before marking done
- **No force unwraps** in Swift code (use guard let, if let, optional chaining)
- **Decimal for money** — Never Float/Double for financial calculations
- **No hardcoded secrets** — Use environment variables or keychain
- **Every bug fix is a lesson** — When fixing any bug, pause and ask: "Why didn't TDD catch this?" Log the root cause in `context.md` under `## Test Blind Spots`. This applies whether you're in `/quickfix`, mid-feature, or just responding to an error report.

## Security Awareness

- **Financial apps get extra scrutiny.** Any code touching money, accounts, or bank connections must use Decimal (never Float/Double), store secrets in Keychain (never UserDefaults), and never log sensitive data.
- **Review your own changes** for data exposure before marking done.
- **When in doubt, flag it** — better to over-report a concern than miss a vulnerability.

## Communication

- Be concise in explanations unless asked for detail
- When proposing changes, lead with the "what" and "why" before the "how"
- Flag uncertainty early — "I'm not sure about X, here's my best guess and why"

## Build Preferences

- **Swift projects:** Use `swift build` and `swift test` (SPM), not xcodebuild
- **Node projects:** Prefer bun over npm when available
- **Python:** Use venv, not global installs

## Git Workflow

- **`main` is always stable.** Never commit directly to main during implementation work.
- **Branch per ticket.** Before writing any code for a ticket, create a branch from main.
- **Branch naming:** `feature/TICKET-ID-short-description` for features, `fix/TICKET-ID-short-description` for fixes.
  - Examples: `feature/TROVE-12-note-editor`, `fix/BUDG-33-decimal-rounding`
- **Commit messages** reference the ticket ID: `"Add markdown parsing (TROVE-12)"`
- **One branch per ticket.** Don't combine unrelated tickets on the same branch.
- **PR when done.** After G3/G4 reviews pass, create a PR. If the project has collaborators, leave the PR open for their review. If solo, ask the user whether to merge.
- **Check before branching.** If already on a feature/fix branch, confirm with the user before switching — they may have uncommitted work.

### Parallel Development with Worktrees

For working on multiple tickets simultaneously, use git worktrees. Each worktree is an independent checkout with its own branch — run a separate Claude Code session in each:

```bash
# Create worktrees for parallel development
git worktree add ../project-feature-auth feature/PROJ-12-auth
git worktree add ../project-feature-editor feature/PROJ-13-editor
git worktree add ../project-fix-balance fix/PROJ-33-rounding

# Start Claude Code in each (separate terminal tabs/panes)
cd ../project-feature-auth && claude
cd ../project-feature-editor && claude
cd ../project-fix-balance && claude
```

- Each session follows the full workflow independently (TDD, G3/G4, PR)
- Each session has its own branch — no merge conflicts during development
- Merge via PRs when each is done
- The memory bank is shared (it's in the main repo), so sessions stay aware of project context
- **Best for:** Independent tickets with no dependencies between them

---

## Workflow

This is the standard engineering workflow. Follow it unless the user explicitly overrides a step.

### Session Start

1. **Read the memory bank** — `.kilocode/rules/memory-bank/` in order: brief → product → architecture → tech → design → interaction → patterns → context → tasks
2. **Read project CLAUDE.md** — Check for project-specific overrides and domain-specific guidance files
3. **Check project tracker** — Fetch tickets for the project. Focus on TODO status (not Backlog) unless told otherwise
4. **Identify next work** — Pick the next unblocked ticket in priority order, or follow user direction

### Planning Phase (Gates G1 + G2)

When planning new work (features, refactors, multi-ticket efforts):

**G1 — Staff Engineer Reviews the Plan**
1. Draft the implementation plan in plan mode
2. Spawn a **Staff Level Engineer** subagent (read `~/.claude/prompts/staff-engineer.md` first, use Plan Review mode)
3. Pass: the plan, relevant memory bank files, and acceptance criteria
4. Reviewer evaluates: architecture risks, missing edge cases, concurrency concerns, dependency direction, testability
5. Incorporate feedback, update the plan

**G2 — Design Director Reviews UI Tickets**
After breaking the approved plan into tickets:
1. Identify which tickets involve UI/UX work
2. Spawn a **Design Director** subagent (read `~/.claude/prompts/design-director.md` first; use project-specific prompt if one exists)
3. Pass: UI ticket acceptance criteria + project design system docs
4. Reviewer evaluates: design system compliance, platform conventions, interaction patterns, accessibility
5. Update ticket AC with design feedback

**Ticket Creation**
After plans pass G1 and G2:
1. Create tickets in your project tracker
2. Include acceptance criteria refined by reviewer feedback
3. Set appropriate status, priority, and dependencies
4. Update memory bank `tasks.md` to mirror the ticket list

### TDD Protocol

For each ticket, before writing implementation code:

1. **Check test blind spots** — Read `context.md` for the `## Test Blind Spots` section. These are patterns from past bugs that slipped through TDD. Make sure the test plan covers them.

2. **Draft a test plan** covering:
   - Happy path
   - Edge cases (empty state, nil, first-run, max values, boundary values)
   - Failure modes (network error, timeout, invalid input, partial failure)
   - **Concurrency scenarios** — Explicitly ask: "What shared mutable state exists? What can happen concurrently? What if the user double-taps? What if a callback fires after dismissal? What if state changes between read and write?"
   - **Race conditions** — check-then-act patterns, async timing, cancellation mid-flight, re-entrancy
   - Security boundaries (if the code touches auth, money, secrets, or user data)
   - **Known blind spots** — Any patterns from past bugs logged in `context.md`

3. **Staff Engineer reviews the test plan** — Spawn a subagent in Test Plan Review mode BEFORE writing tests. The reviewer looks for missing concurrency scenarios, untested failure modes, timing assumptions, and boundary gaps.

4. **Write failing tests** from the reviewed test plan

5. **Implement** — Minimal code to pass the tests

6. **Verify** — Build + test pass (`swift build && swift test`, `bun test`, or project equivalent)

### Implementation Phase

For each ticket:
1. **Sync with main** — Pull the latest from `main` before starting work. If on main: `git pull`. If creating a new branch: create it from the freshly pulled main. If on an existing feature branch: `git fetch origin && git merge origin/main` (or rebase if the project prefers). This prevents working on stale code and reduces merge conflicts.
2. **Create a branch** — Check current branch. If on main, create and switch to a new branch per the Git Workflow convention. If already on a feature/fix branch from a previous ticket, confirm with the user before switching.
3. Move ticket to "In Progress"
3. Follow TDD Protocol above
4. Implement strictly within ticket scope
5. Commit with ticket ID in message (e.g., `"Add markdown parsing (PROJ-12)"`)
6. Run build verification

### Review Phase (Gates G3 + G4)

After implementation:

**G3 — Staff Engineer Reviews Code**
1. Spawn a **Staff Level Engineer** subagent (Code Review mode)
2. Pass: the code diff, test coverage, acceptance criteria, relevant memory bank context
3. Reviewer evaluates: correctness, architecture, error handling, naming, performance, testing, security
4. **Security escalation:** If the code touches money, auth, keychain, or user data, the reviewer automatically deepens security scrutiny (Decimal usage, keychain vs UserDefaults, PII in logs, input validation, encryption)
5. Fix all P0s. Fix P1s unless deferral is justified. Note P2s.

**G4 — Design Director Reviews UI** (only if UI changed)
1. Spawn a **Design Director** subagent (project-specific prompt if available)
2. Pass: the UI code, design system docs, acceptance criteria
3. Reviewer evaluates: spacing tokens, typography, color discipline, motion, platform conventions, accessibility
4. Fix all issues before proceeding

### Completion

1. **Push and create PR** — Push the branch to remote. Create a PR with a summary of what was done and the ticket ID. If the project has collaborators, leave the PR open for review. If solo, ask the user whether to merge.
2. Comment on the ticket describing what was done (include the PR link)
3. Update ticket status to Done (or relevant status)
4. **Quick tech debt check** — Review the changes just made and flag any debt introduced: shortcuts, TODOs, hardcoded values, missing edge case coverage, or patterns that will need revisiting. Note these in the PR description and in `context.md`. If anything is "Pay now" or "Pay soon" severity, create a Backlog ticket with a `tech-debt` label.
5. **Bug retrospective (when fixing bugs)** — If the ticket was a bug fix, ask: "Why didn't our TDD protocol catch this?" Categorize the root cause (e.g., missing concurrency test, untested lifecycle scenario, boundary condition, data persistence edge case) and add it to the `## Test Blind Spots` section in `context.md`. This trains future test plans to cover patterns we've missed before.
5. Update memory bank:
   - `context.md` — What changed, decisions made, current status, tech debt notes
   - `tasks.md` — Ticket progress
   - `architecture.md` / `tech.md` — If architecture or tech decisions changed
   - `design.md` — If design decisions changed
6. Update project CLAUDE.md if patterns or conventions changed
7. Ask user: clear context or bring in the next ticket?

### Review Persona Reference

| Persona | Prompt File | Spawn For |
|---------|-------------|-----------|
| **Staff Level Engineer** | `~/.claude/prompts/staff-engineer.md` | Plan review (G1), test plan review, code review (G3) |
| **Design Director** | `~/.claude/prompts/design-director.md` | UI ticket review (G2), UI code review (G4) |

- Read the full prompt file before spawning each subagent
- Findings use severity: P0 (must fix), P1 (should fix), P2 (consider)
- Project-specific Design Director prompts override the global one

---

## The Taste Layer

Components give you WHAT. The memory bank encodes WHY.

When filling out `interaction.md`, every decision needs:
- **The behavior** — what happens
- **The rationale** — why it should happen this way

**Bad:** "Validate on blur"
**Good:** "Validate after focus leaves, not while typing. Red text before they're done typing feels like they've made a mistake."

The rationale helps you extrapolate to new situations — not just pattern-match rules. When a new interaction question comes up, check if existing rationale applies before inventing something new.

`interaction.md` is a living document. Update it as you build. When you make an interaction decision during development, capture it there with the reasoning.

---

## Memory Bank Protocol

Every project must have a memory bank at `.kilocode/rules/memory-bank/`. This is Claude's working memory — cheaper and faster than re-reading the full codebase every session.

### Structure

```
.kilocode/rules/memory-bank/
├── brief.md          # Vision, target users, what this IS and ISN'T
├── product.md        # Requirements, user stories, core flows, decisions
├── architecture.md   # System design, layers, tech stack, dependency direction
├── tech.md           # Libraries, services, dev environment, build commands
├── design.md         # UI/UX specs, design tokens, visual specs
├── interaction.md    # OPTIONAL: behavioral principles (when/how things behave)
├── patterns.md       # OPTIONAL: reusable UI component catalog
├── context.md        # LIVING: current status, recent work, open questions
└── tasks.md          # LIVING: ticket backlog, mirrors project tracker
```

### New Project Setup

1. Create the directory structure above
2. Copy templates from `~/.claude/templates/memory-bank/`
3. Fill in `brief.md` from the PRD or initial conversation
4. Fill in other files as architecture and design decisions are made
5. Create a project CLAUDE.md at the project root that references the memory bank

### Update Rules

- **After every completed ticket:** Update `context.md` and `tasks.md`
- **After architecture/tech decisions:** Update `architecture.md` or `tech.md`
- **After design decisions:** Update `design.md` (visual specs), `interaction.md` (behavioral rules), or `patterns.md` (shared components)
- **After corrections from the user:** Update the relevant file + project CLAUDE.md
- **Keep files concise** — This is working memory, not a changelog. Summarize, don't log.

---

## Self-Improvement

- **After every correction from the user**, update the project's CLAUDE.md (or this file if it's a global lesson) so you don't repeat the mistake.
- **Consult domain-specific CLAUDE.md files** before modifying code in that domain (e.g., read Stores-CLAUDE.md before changing a Store).
- **Learn from failures** — If a test approach didn't work, document why in the memory bank.
- **Bug retrospective on every bug fix** — Any time a bug is fixed — whether through `/quickfix`, during a `/kickoff` session, or just from the user reporting an error — always ask: "Why didn't TDD catch this?" Categorize the root cause and add it to the `## Test Blind Spots` section in `context.md`. This applies regardless of how the bug was reported or which workflow triggered the fix.
- **Review corrections periodically** — Use `/reflect` to review the accumulated corrections log (`~/.claude/corrections-log.jsonl`). The `UserPromptSubmit` hook automatically detects correction patterns and logs them. `/reflect` analyzes the log, groups by pattern, and proposes CLAUDE.md rule updates.

### Writing Rules (Meta-Rules)

When adding new rules to CLAUDE.md (whether from corrections, retrospectives, or self-improvement), follow these constraints:

- **Use absolute directives.** "NEVER use Float for money" not "Consider using Decimal." "ALWAYS check the branch" not "It's a good idea to check the branch."
- **Lead with the reasoning** (1–3 bullets max), then state the rule. Context helps Claude understand *when* the rule applies.
- **Include a concrete example.** Show the wrong way and the right way with actual code or commands, not abstract descriptions.
- **One rule, one concern.** Don't bundle unrelated guidance into a single bullet. Each rule should be independently understandable.
- **Anti-bloat:** Before adding a rule, check if an existing rule already covers it. Prefer updating an existing rule over creating a new one. Delete rules that are no longer relevant. If a rule is obvious (e.g., "write clean code"), don't add it.
- **Keep it scannable.** Bold the key phrase. Use the format: `**Bold directive** — brief explanation with example.`

---

*This file is self-improving. Update it when you learn something new.*
