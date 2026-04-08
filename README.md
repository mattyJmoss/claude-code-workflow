# Claude Code Engineering Workflow

A lightweight engineering workflow for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) built around collaborative decision-making, review personas, persistent memory, and self-improving hooks.

## What This Is

An opinionated workflow system that replaces heavyweight planning pipelines with focused, token-efficient tools:

- **`/collab`** — Two-agent debate for architectural decisions. Product Architect and Staff Engineer argue approaches, you arbitrate. Decisions saved to Open Brain + DECISIONS.md.
- **`/review`** — Single-pass code review before committing. One focused agent, not three parallel reviewers.
- **`/ship`** — Commit, push, deploy. Drift-checks rules after pushing.
- **Review personas** — Staff Engineer, Product Thinker, Design Thinker available for ad-hoc reviews
- **Automated hooks** — Quality gate (test verification), context preservation (survives autocompact), correction detection (organic self-improvement)
- **Memory bank** — Up to 9 small files per project that let Claude pick up where it left off

## Quick Start

### 1. Clone this repo

```bash
git clone https://github.com/mattyJmoss/claude-code-workflow.git
```

### 2. Install skills and hooks

Open Claude Code and paste:

```
I want to install an engineering workflow from a folder. The source is at [PATH]/claude-code-workflow/. Here's what to do:

1. Create directories: ~/.claude/skills/, ~/.claude/hooks/, ~/.claude/templates/memory-bank/

2. Copy files:
   - skills/*/ → ~/.claude/skills/ (all skill directories with SKILL.md files)
   - hooks/preserve-context.sh → ~/.claude/hooks/preserve-context.sh
   - hooks/detect-corrections.sh → ~/.claude/hooks/detect-corrections.sh
   - hooks/settings.json → merge into ~/.claude/settings.json (hooks section only)
   - templates/memory-bank/*.md → ~/.claude/templates/memory-bank/ (all 9 files)

3. Make hook scripts executable:
   chmod +x ~/.claude/hooks/preserve-context.sh ~/.claude/hooks/detect-corrections.sh

4. Confirm everything looks correct and show me what was installed.
```

### 3. Start using it

```bash
# Decision with multiple defensible paths
/collab Should we use a queue or event emitter for playback?

# Code review before committing
/review

# Ship it
/ship
```

## How It Works

### The `/collab` Workflow

```
Phase 0: Frame          Phase 1: Debate           Phase 2: Synthesize
─────────────           ───────────────           ──────────────────

You describe the     →  Product Architect     →  Opus reads transcript
decision + constraints   and Staff Engineer       and produces:
                         debate for 2 rounds      - Recommendation
Claude asks              (300 words each,         - Key agreements
clarifying questions     AGREE/DISAGREE tokens)   - Open disagreements
                                                  - Decision needed
Produces a              Autonomous — no          
decision brief          human in the loop        You confirm → saved to
                                                 Open Brain + DECISIONS.md
```

### When to Use What

| Situation | Tool |
|-----------|------|
| "Should we use X or Y?" | `/collab` |
| "What's the best approach for..." | `/collab` |
| "Fix the crash in..." | Just do it |
| "Add a button that..." | Just do it |
| Review code before committing | `/review` |
| Commit, push, deploy | `/ship` |

**Rule of thumb:** Use `/collab` when there's more than one defensible implementation path. Otherwise, just execute.

### Review Personas

Three review personas available for ad-hoc use:

- **`/product-thinker`** — Scope discipline, user impact, problem validity
- **`/staff-engineer`** — Architecture coherence, state management, failure modes
- **`/design-thinker`** — Platform compliance, interaction quality, accessibility

These are also used internally by `/collab` (merged into Product Architect and Staff Engineer debate personas).

### Memory Bank

Instead of re-reading your entire codebase every session, Claude reads up to 9 small files:

```
.kilocode/rules/memory-bank/
├── brief.md          # Vision, target users, scope boundaries
├── product.md        # Requirements, user stories, core flows
├── architecture.md   # System design, layers, tech stack
├── tech.md           # Libraries, dev environment, build commands
├── design.md         # UI/UX specs, design tokens, visual specs
├── interaction.md    # OPTIONAL: behavioral principles
├── patterns.md       # OPTIONAL: reusable UI component catalog
├── context.md        # LIVING: current status, recent work
└── tasks.md          # LIVING: ticket backlog
```

## Repo Structure

```
claude-code-workflow/
├── README.md
├── LICENSE
├── skills/
│   ├── collab/SKILL.md                    # Two-agent decision debate
│   ├── collab-product-architect/SKILL.md  # Debate persona (product + design)
│   ├── collab-staff-engineer/SKILL.md     # Debate persona (systems)
│   ├── review/SKILL.md                    # Single-pass code review
│   ├── ship/SKILL.md                      # Commit, push, deploy
│   ├── product-thinker/SKILL.md           # Review persona (product)
│   ├── staff-engineer/SKILL.md            # Review persona (engineering)
│   ├── design-thinker/SKILL.md            # Review persona (design)
│   └── reflect/SKILL.md                   # Self-improvement from corrections
├── hooks/
│   ├── preserve-context.sh                # PreCompact context snapshot
│   ├── detect-corrections.sh              # Correction pattern detection
│   └── settings.json                      # Hook configuration
├── templates/
│   └── memory-bank/                       # Blank templates for new projects
├── commands/                              # Legacy commands (kept for reference)
├── prompts/                               # Legacy prompts (superseded by skills/)
└── docs/
    ├── how-to-use.md
    ├── slash-commands.md
    └── design-system-guide.md
```

## Token Efficiency

This workflow was designed to replace heavyweight planning pipelines (like GSD) that burn 25-40+ LLM calls per decision:

| Component | Old (4-gate/GSD) | New (/collab) |
|-----------|------------------|---------------|
| Planning | 4+ researcher agents, planner, checker | 2-agent debate (2 rounds) |
| Review gates | 3 parallel reviewers | 1 focused reviewer |
| State management | STATE.md, phases, milestones | DECISIONS.md + Open Brain |
| Total LLM calls per decision | ~25-40 | ~9-13 |

## Philosophy

Two layers working together:

1. **Decision quality** — `/collab` ensures multiple perspectives before committing to an approach. Not a rubber stamp — genuine debate between a product lens and an engineering lens.
2. **The taste layer** — Review personas don't just check correctness. They check whether things *feel right*. Platform conventions, interaction quality, progressive disclosure. Components encode WHAT. The taste layer encodes WHY.

## Requirements

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed
- `jq` (for hook scripts) — `brew install jq` on macOS
- Git (for branching workflow)
- Open Brain MCP server (optional, for cross-session decision memory)

## License

MIT
