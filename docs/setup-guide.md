# Setup Guide

This guide gets you the Claude Code engineering workflow. It takes about 2 minutes.

---

## What You're Getting

- **4-gate review model** — Claude reviews its own plans and code before calling anything done, using a Staff Engineer and Design Director persona
- **TDD protocol** — Test plans get reviewed for race conditions and edge cases *before* tests are written
- **Memory bank** — Up to 9 small files per project that let Claude pick up where it left off without re-reading the entire codebase
- **Git workflow** — Automatic branching per ticket, PRs created when done
- **6 slash commands** — `/new-project`, `/scope`, `/kickoff`, `/quickfix`, `/techdebt`, `/reflect`
- **Automated hooks** — Quality gate (test verification), context preservation (survives autocompact), correction detection (organic self-improvement)

---

## Step 1: Clone the Repo

```bash
git clone https://github.com/mattyJmoss/claude-code-workflow.git
```

---

## Step 2: Paste This Prompt into Claude Code

Open a terminal, run `claude`, and paste the following prompt. Replace `[PATH]` with wherever you cloned the repo.

```
I want to set up an engineering workflow. I have a folder of config files at [PATH]/claude-code-workflow/ that need to be installed into my ~/.claude/ directory. Here's what to do:

1. Create the directory structure:
   - ~/.claude/prompts/
   - ~/.claude/commands/
   - ~/.claude/templates/memory-bank/
   - ~/.claude/hooks/

2. Copy these files from the source folder to ~/.claude/:
   - CLAUDE.md → ~/.claude/CLAUDE.md
   - prompts/staff-engineer.md → ~/.claude/prompts/staff-engineer.md
   - prompts/design-director.md → ~/.claude/prompts/design-director.md
   - commands/kickoff.md → ~/.claude/commands/kickoff.md
   - commands/scope.md → ~/.claude/commands/scope.md
   - commands/new-project.md → ~/.claude/commands/new-project.md
   - commands/quickfix.md → ~/.claude/commands/quickfix.md
   - commands/techdebt.md → ~/.claude/commands/techdebt.md
   - commands/reflect.md → ~/.claude/commands/reflect.md
   - All files from templates/memory-bank/ → ~/.claude/templates/memory-bank/
   - hooks/preserve-context.sh → ~/.claude/hooks/preserve-context.sh
   - hooks/detect-corrections.sh → ~/.claude/hooks/detect-corrections.sh
   - hooks/settings.json → merge into ~/.claude/settings.json (hooks section only)

3. Make hook scripts executable:
   chmod +x ~/.claude/hooks/preserve-context.sh ~/.claude/hooks/detect-corrections.sh

4. After copying, read the installed ~/.claude/CLAUDE.md and confirm everything looks correct.

5. Show me a summary of what was installed, the 6 slash commands, and the 3 automated hooks.
```

---

## Step 3: Verify It Worked

After the setup, try:

```
/kickoff MyProject
```

If the project doesn't have a memory bank yet, Claude will tell you. Use `/new-project MyProject` to set one up.

---

## How It Works (Quick Version)

### The Slash Commands

| Command | When to Use | What Happens |
|---------|-------------|-------------|
| `/new-project [name]` | Starting a brand new project | Scaffolds memory bank, project CLAUDE.md |
| `/scope [project]` | Planning a new feature | Drafts plan → Staff Engineer reviews → creates tickets → Design Director reviews UI |
| `/kickoff [project]` | Daily work sessions | Reads memory bank → picks next ticket → TDD → code review → PR |
| `/quickfix [project]` | Small bug fixes | Light setup → fix → code review → PR |
| `/techdebt [project]` | End of session | Reviews changes, flags debt, creates backlog tickets |
| `/reflect [project]` | Periodically | Reviews correction log, proposes CLAUDE.md rule updates |

### The 4 Review Gates

| Gate | Who | Reviews What | When |
|------|-----|-------------|------|
| G1 | Staff Engineer | Implementation plan | During `/scope` |
| G2 | Design Director | UI ticket acceptance criteria | During `/scope` |
| G3 | Staff Engineer | Code diff + tests | After implementation |
| G4 | Design Director | UI code | After implementation (only if UI changed) |

### Automated Hooks (Invisible)

| Hook | What It Does |
|------|-------------|
| **PreCompact** | Saves context snapshot before autocompact; re-injects after |
| **Stop (Quality Gate)** | Runs tests after code changes; blocks Claude if tests fail |
| **UserPromptSubmit** | Detects correction patterns; logs for `/reflect` review |

---

## Customizing

The workflow is designed to be self-improving. After Claude makes a mistake, it updates CLAUDE.md so it doesn't repeat it.

| What | Where |
|------|-------|
| Global workflow rules | `~/.claude/CLAUDE.md` |
| Staff Engineer review criteria | `~/.claude/prompts/staff-engineer.md` |
| Design Director review criteria | `~/.claude/prompts/design-director.md` |
| Slash command behavior | `~/.claude/commands/[command].md` |
| Project-specific overrides | `[project]/CLAUDE.md` |
| Project-specific design reviews | Create a project-specific Design Director prompt |
| Hook configuration | `~/.claude/settings.json` |
| Hook scripts | `~/.claude/hooks/` |
