# Slash Commands Reference

All slash commands live in `~/.claude/commands/` and take the project name as `$ARGUMENTS`.

---

## Lifecycle

Commands follow a natural project lifecycle, with two utility commands that branch off at any point:

```
/new-project ──► /scope ──► /kickoff ──► /techdebt
   Create         Plan       Build        Clean up
   project        features   tickets      debt
                     │
                     ├─── /quickfix      (branch off anytime for urgent bugs)
                     ├─── /reflect       (branch off anytime to review corrections)
                     └─── /sync-workflow (branch off anytime to publish workflow changes)
```

- **Left to right** is the happy path for a new project.
- **`/kickoff`** is the command you'll use most — it's the daily driver.
- **`/quickfix`** and **`/reflect`** can be invoked at any point in the lifecycle.

---

## Commands

### `/new-project`

**When to use:** You're starting a brand-new project from scratch.

**What it does:**
1. Creates the `.kilocode/rules/memory-bank/` directory
2. Copies all template files (brief, product, architecture, tech, design, context, tasks, plus optional interaction and patterns)
3. Fills in `brief.md` from your project description
4. Creates a root `CLAUDE.md` for the project

**How often:** Once per project.

**Example:**
```
/new-project WalkieTalkie
```
Then describe the project when Claude asks. It scaffolds everything and you're ready to plan.

---

### `/scope`

**When to use:** You need to plan a new feature, epic, or multi-ticket body of work.

**What it does:**
1. Reads the memory bank for current context
2. Enters plan mode to draft an implementation plan
3. Runs **G1** — Staff Engineer reviews the plan (architecture, concurrency, testability)
4. Breaks the plan into tickets with acceptance criteria
5. Runs **G2** — Design Director reviews UI tickets (design system, platform conventions)
6. Creates tickets in Plane (or your tracker) with refined acceptance criteria
7. Updates `tasks.md` in the memory bank

**How often:** At the start of each feature or epic. Not needed for single bug fixes.

**Example:**
```
/scope WalkieTalkie
```
Then describe the feature: "I want to add push notifications when a friend sends a message."

---

### `/kickoff`

**When to use:** You're sitting down to work on a project that already has tickets.

**What it does:**
1. Reads the full memory bank (brief through tasks)
2. Syncs with Plane to get current ticket statuses
3. Identifies the next unblocked ticket in priority order
4. Proposes the ticket and waits for your go-ahead
5. Once confirmed, follows the full implementation workflow: TDD protocol, implementation, G3 code review, G4 UI review (if applicable), commit, PR, memory bank update

**How often:** Every session. This is the daily driver.

**Example:**
```
/kickoff WalkieTalkie
```
Claude reads context, proposes "WTALK-15: Add mute toggle to channel view", and you say "go" or redirect to a different ticket.

---

### `/quickfix`

**When to use:** There's a bug that needs fixing now. You don't want the overhead of full planning (G1/G2).

**What it does:**
1. Reads the memory bank for context
2. Skips the planning phase (no G1, no G2)
3. You describe the bug
4. Claude implements a fix with tests
5. Runs **G3** — Staff Engineer reviews the fix (still gets code review)
6. Runs the bug retrospective: "Why didn't TDD catch this?"
7. Logs the root cause in `context.md` under Test Blind Spots
8. Commits and updates the memory bank

**How often:** Whenever a bug comes in that doesn't need architectural planning.

**Example:**
```
/quickfix WalkieTalkie
```
Then describe the bug: "Push notifications crash when the user has no channels."

---

### `/techdebt`

**When to use:** You want to identify and address accumulated technical debt.

**What it does:**
1. Reads the memory bank, focusing on `context.md` tech debt notes
2. Scans the codebase for TODOs, FIXMEs, and patterns flagged during previous G3 reviews
3. Categorizes debt by severity (Pay Now, Pay Soon, Pay Eventually)
4. Proposes a prioritized list of cleanup tasks
5. Creates tickets for actionable items
6. Optionally works on the highest-priority item immediately

**How often:** After a milestone, before a release, or when things feel "crusty."

**Example:**
```
/techdebt WalkieTalkie
```
Claude surfaces things like: "3 endpoints have no input validation (Pay Now), test coverage dropped below 80% in the auth module (Pay Soon), the notification dispatcher could be extracted into its own module (Pay Eventually)."

---

### `/reflect`

**When to use:** Periodically, to turn accumulated corrections into permanent rules.

**What it does:**
1. Reads the corrections log at `~/.claude/corrections-log.jsonl` (populated automatically by the UserPromptSubmit hook)
2. Groups corrections by pattern (e.g., "kept using Float for money", "forgot to check branch before switching")
3. Proposes CLAUDE.md rule updates — either new rules or amendments to existing ones
4. Applies approved updates to the global or project CLAUDE.md
5. Clears processed corrections from the log

**How often:** Every week or two, or when you notice Claude making the same mistake repeatedly.

**Example:**
```
/reflect WalkieTalkie
```
Claude might say: "I found 4 corrections about forgetting to update `context.md` after completing tasks. Proposed rule: **ALWAYS update context.md as the final step of any ticket completion, before asking what's next.**"

---

### `/sync-workflow`

**When to use:** You've made changes to your local workflow files (`~/.claude/`) and want to publish them to your public workflow repo.

**What it does:**
1. Reads `~/.claude/sync-workflow-rules.json` for file mappings and sanitization rules
2. Copies each mapped source file to the public repo, applying sanitization (stripping personal names, project-specific references, secrets)
3. Shows you a diff of what changed
4. On your approval, commits and pushes
5. Optionally syncs updated templates to your Obsidian vault

**How often:** Whenever you modify prompts, commands, templates, or the global CLAUDE.md.

**Setup required:** Create a `~/.claude/sync-workflow-rules.json` config file that defines:
- `file_mappings` — which source file maps to which repo destination
- `sanitize_rules` — patterns to strip or replace (personal names, project refs, workspace slugs)
- `exclude_files` — files that should never be synced (containing secrets, personal integrations)
- `manually_maintained` — repo files that aren't auto-synced (README, LICENSE, docs)

**Example:**
```
/sync-workflow
```
Claude diffs your local files against the public repo, shows what changed, and asks for approval before pushing.

```
/sync-workflow dry-run
```
Shows what would change without committing.

---

## Decision Guide

| Situation | Command |
|-----------|---------|
| Starting a brand-new project | `/new-project` |
| Planning a new feature or epic | `/scope` |
| Starting a work session on an existing project | `/kickoff` |
| Fixing a bug quickly | `/quickfix` |
| Cleaning up after a sprint or milestone | `/techdebt` |
| Claude keeps making the same mistake | `/reflect` |
| Changed a prompt, command, or template | `/sync-workflow` |
| Need to work on a specific ticket (not next in queue) | `/kickoff` then redirect |
| Want to plan without creating tickets yet | `/scope` (you can stop before ticket creation) |

---

## Git Branching

| Command | Creates a Branch? | Branch Convention |
|---------|-------------------|-------------------|
| `/new-project` | No | Works on `main` (scaffolding only) |
| `/scope` | No | Planning only — no code changes |
| `/kickoff` | Yes | `feature/TICKET-ID-short-description` or `fix/TICKET-ID-short-description` |
| `/quickfix` | Yes | `fix/TICKET-ID-short-description` |
| `/techdebt` | Yes (if working on an item) | `chore/TICKET-ID-short-description` |
| `/reflect` | No | Updates CLAUDE.md only — no branch needed |
| `/sync-workflow` | No | Syncs to external repo — no project branch needed |

---

## Notes

- All commands take the project name as `$ARGUMENTS` (e.g., `/kickoff WalkieTalkie`).
- Commands are composable — `/scope` plans the work, `/kickoff` executes it.
- Gates are not skippable by default. `/quickfix` is the explicit "skip planning gates" path.
- The memory bank is always read first, regardless of which command you use.
