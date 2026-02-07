# How to Use the Claude Code Workflow

This guide walks you through how to use the engineering workflow. Everything lives in `~/.claude/` where Claude Code reads it.

---

## Starting a New Project

### 1. Create the project directory

Set up your project however you normally would (SPM, Expo, etc.).

### 2. Scaffold the memory bank

Open Claude Code in the project directory and run:

```
/new-project MyProject
```

Claude will:
- Copy the template files into `.kilocode/rules/memory-bank/` (7 core files, plus optional `interaction.md` and `patterns.md` for projects with design systems)
- Fill in `brief.md` from your description
- Create a project `CLAUDE.md` at the root

### 3. Fill in the memory bank

As you discuss architecture, tech choices, and design decisions with Claude, it will populate:
- `product.md` — requirements, user stories, flows
- `architecture.md` — system design, layers, tech stack
- `tech.md` — libraries, services, dev environment
- `design.md` — UI specs, tokens, components
- `interaction.md` — behavioral rules (when/how things behave) — *optional, for projects with design systems*
- `patterns.md` — reusable UI component catalog — *optional, for projects with design systems*

You don't need to fill these all at once. They grow as decisions are made.

---

## Starting a Session (Existing Project)

Run the kickoff command with your project name:

```
/kickoff MyProject
```

Claude will read the memory bank (fast, cheap — no need to scan every code file), sync up with your project tracker, and propose the next ticket to work on.

---

## Planning a New Feature

```
/scope MyProject
```

Then describe the feature. Claude will:
1. Draft an implementation plan
2. Have the Staff Engineer review it (G1)
3. Break it into tickets
4. Have the Design Director review UI tickets (G2)
5. Leave you with a clean, reviewed backlog

---

## Working a Ticket

Once you're in an implementation session and have picked a ticket:

### 1. TDD Protocol

Claude drafts a **test plan** listing all scenarios to test — happy path, edge cases, failure modes, and critically: **concurrency scenarios and race conditions**.

Before writing any tests, Claude spawns the Staff Engineer to review the test plan. This catches the race conditions and timing bugs that normal TDD misses.

After the test plan is approved, Claude writes failing tests, then implements.

### 2. Implementation

Claude implements strictly within the ticket scope. No "while I was here" additions.

### 3. G3 — Staff Engineer reviews code

After implementation, Claude spawns the Staff Engineer for a code review. Findings labeled P0 (must fix), P1 (should fix), P2 (consider).

### 4. G4 — Design Director reviews UI (if applicable)

If the ticket changed any UI, Claude spawns the Design Director to review against the design system.

### 5. Completion

Claude automatically commits, pushes, creates a PR, runs a tech debt check, updates the memory bank, and asks what's next.

---

## The 4-Gate Model at a Glance

```
PLANNING                          IMPLEMENTATION

G1: Staff Engineer ──► Plan       G3: Staff Engineer ──► Code
    (architecture,                    (correctness, security,
     concurrency,                      performance, testing)
     testability)
                                  G4: Design Director ──► UI Code
G2: Design Director ──► UI           (design system, platform,
    Tickets (design system,            motion, accessibility)
     platform conventions)
```

**G1 + G2** happen during planning. **G3 + G4** happen after implementation.

---

## Automated Hooks

Three hooks run automatically in the background:

### PreCompact — Context Preservation

Before Claude's context window is auto-compacted, a hook captures a snapshot of critical state (git branch, uncommitted changes, memory bank context). After compaction, the snapshot is re-injected so Claude doesn't lose the thread.

### Stop — Quality Gate

Every time Claude finishes a response where code was modified, the quality gate runs the test suite. If tests fail, Claude keeps working.

### UserPromptSubmit — Correction Detection

Scans your prompts for correction patterns ("no, use X instead", "that's wrong", "you forgot..."). When detected, corrections are silently logged. Use `/reflect` periodically to turn patterns into permanent rules.

---

## Tips

- **Memory bank saves tokens.** Claude reads up to 9 small files instead of scanning your entire codebase.
- **You can skip gates.** For a quick bug fix, use `/quickfix` — it skips G1/G2 but keeps G3.
- **Design Director is optional for non-UI work.** G2 and G4 only fire when tickets involve UI.
- **The Staff Engineer catches race conditions at the test plan stage**, not after you've already written the code.
- **Parallel work with worktrees.** If you have multiple independent tickets, use `git worktree` to run separate Claude sessions on each.
