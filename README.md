# Claude Code Engineering Workflow

A structured engineering workflow for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that adds review gates, TDD protocol, persistent memory, and self-improvement to your AI-assisted development.

## What This Is

An opinionated workflow system that makes Claude Code work like a disciplined engineering team:

- **4 review gates** — Claude reviews its own plans and code using Staff Engineer and Design Director personas before calling anything done
- **TDD protocol** — Test plans are reviewed for race conditions and edge cases *before* tests are written
- **Memory bank** — Up to 9 small files per project that let Claude pick up where it left off without re-reading the entire codebase
- **7 slash commands** — `/new-project`, `/scope`, `/kickoff`, `/quickfix`, `/techdebt`, `/reflect`, `/sync-workflow`
- **Automated hooks** — Quality gate (test verification), context preservation (survives autocompact), correction detection (organic self-improvement)
- **Git workflow** — Automatic branching per ticket, PRs created when done

## Quick Start

### 1. Clone this repo

```bash
git clone https://github.com/mattyJmoss/claude-code-workflow.git
```

### 2. Run the install prompt

Open Claude Code and paste:

```
I want to install an engineering workflow from a folder. The source is at [PATH]/claude-code-workflow/. Here's what to do:

1. Create directories: ~/.claude/prompts/, ~/.claude/commands/, ~/.claude/templates/memory-bank/, ~/.claude/hooks/

2. Copy files:
   - CLAUDE.md → ~/.claude/CLAUDE.md
   - prompts/staff-engineer.md → ~/.claude/prompts/staff-engineer.md
   - prompts/design-director.md → ~/.claude/prompts/design-director.md
   - commands/*.md → ~/.claude/commands/ (all 7 files)
   - templates/memory-bank/*.md → ~/.claude/templates/memory-bank/ (all 9 files)
   - hooks/preserve-context.sh → ~/.claude/hooks/preserve-context.sh
   - hooks/detect-corrections.sh → ~/.claude/hooks/detect-corrections.sh
   - hooks/settings.json → merge into ~/.claude/settings.json (hooks section only)

3. Make hook scripts executable:
   chmod +x ~/.claude/hooks/preserve-context.sh ~/.claude/hooks/detect-corrections.sh

4. Confirm everything looks correct and show me what was installed.
```

### 3. Set up `/sync-workflow` (optional)

If you want to be able to publish workflow changes back to a shared repo, paste this into Claude Code:

```
I want to set up /sync-workflow so I can publish changes to my workflow files. Here's what to do:

1. Read the template config at [PATH]/claude-code-workflow/sync-rules-template.json

2. Scan my ~/.claude/ directory (not the projects/ subdirectory) and identify:
   - Any personal names, usernames, or collaborator names in CLAUDE.md or command files
   - Any project-specific ticket prefixes (like PROJ-123 patterns) used as examples
   - Any workspace or organization names
   - Any files that contain secrets, API keys, or bearer tokens
   - Any hook scripts that reference personal services or bots

3. Ask me:
   - What GitHub repo should changes be published to? (e.g., myuser/claude-code-workflow)
   - Where is my local clone of that repo? (or should we clone it now?)
   - Do I use Obsidian? If so, where's my vault path for syncing templates?

4. Generate a ~/.claude/sync-workflow-rules.json config that:
   - Maps every file from step 2's scan to the correct repo destination
   - Adds sanitize_rules for every personal/project-specific reference found
   - Excludes any files with secrets
   - Sets the Obsidian paths (or null if not using Obsidian)

5. Show me the generated config and explain what each sanitization rule does before saving.
```

### 4. Start using it

```bash
# New project
/new-project MyApp

# Planning session
/scope MyApp

# Daily work session
/kickoff MyApp

# Quick bug fix
/quickfix MyApp
```

## How It Works

### The 4-Gate Model

```
PLANNING                          IMPLEMENTATION

G1: Staff Engineer ──► Plan       G3: Staff Engineer ──► Code
    (architecture,                    (correctness, security,
     concurrency,                      performance, testing)
     testability)
                                  G4: Design Director ──► UI Code
G2: Design Director ──► UI           (design system, platform,
    Tickets                            motion, accessibility)
```

### The Lifecycle

```
/new-project  →  /scope  →  /kickoff  →  /kickoff  →  /techdebt
    (once)      (per feature)  (daily driver)        (close out)
                                    ↘
                                /quickfix          /reflect
                              (for one-off fixes)  (periodically)
```

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
├── CLAUDE.md                       # The master workflow file
├── sync-rules-template.json        # Template for /sync-workflow config
├── prompts/
│   ├── staff-engineer.md           # 3-mode review persona (plan, test plan, code)
│   └── design-director.md          # Design review persona (global)
├── commands/
│   ├── kickoff.md                  # Daily work session
│   ├── quickfix.md                 # Quick bug fix
│   ├── scope.md                    # Planning session
│   ├── new-project.md              # Project bootstrapping
│   ├── techdebt.md                 # Debt review
│   ├── reflect.md                  # Self-improvement
│   └── sync-workflow.md            # Publish workflow changes to public repo
├── templates/
│   └── memory-bank/                # Blank templates for new projects
│       ├── brief.md, product.md, architecture.md, tech.md
│       ├── design.md, interaction.md, patterns.md
│       └── context.md, tasks.md
├── hooks/
│   ├── preserve-context.sh         # PreCompact context snapshot
│   ├── detect-corrections.sh       # Correction pattern detection
│   └── settings.json               # Hook configuration
└── docs/
    ├── how-to-use.md               # Detailed usage guide
    ├── slash-commands.md            # When to use each command
    └── design-system-guide.md      # How to fill out design system files
```

## Documentation

- **[How to Use](docs/how-to-use.md)** — Full workflow walkthrough
- **[Slash Commands](docs/slash-commands.md)** — When to use each command
- **[Design System Guide](docs/design-system-guide.md)** — How to fill out design.md, interaction.md, and patterns.md
- **[Setup Guide](docs/setup-guide.md)** — Quick 2-minute install

## Customizing

| What | Where |
|------|-------|
| Global workflow rules | `~/.claude/CLAUDE.md` |
| Staff Engineer review criteria | `~/.claude/prompts/staff-engineer.md` |
| Design Director review criteria | `~/.claude/prompts/design-director.md` |
| Slash command behavior | `~/.claude/commands/[command].md` |
| Sync-to-repo config | `~/.claude/sync-workflow-rules.json` (copy from `sync-rules-template.json`) |
| Project-specific overrides | `[project]/CLAUDE.md` |
| Hook scripts | `~/.claude/hooks/` |
| Hook configuration | `~/.claude/settings.json` |

The workflow is self-improving — Claude updates CLAUDE.md when it learns from mistakes. Use `/reflect` periodically to turn accumulated corrections into permanent rules.

## Requirements

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed
- `jq` (for hook scripts) — `brew install jq` on macOS
- Git (for branching workflow)

## License

MIT
