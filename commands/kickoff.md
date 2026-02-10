Read the memory bank at `.kilocode/rules/memory-bank/` in order: brief → product → architecture → tech → design → context → tasks. Also scan `issues.md` if it exists — note any open items relevant to today's work. Then read the project CLAUDE.md for any project-specific overrides or domain-specific guidance files.

Fetch Plane tickets via MCP for the **$ARGUMENTS** project. Focus on tickets in TODO status (not Backlog) unless I say otherwise. Note which tickets have been completed since the last session by comparing tasks.md to Plane.

Show me:
1. A brief summary of where we left off (from context.md)
2. Tickets completed since last session
3. The next unblocked ticket in TODO status (priority order)
4. Any open questions from the memory bank

Then follow the standard workflow from the global CLAUDE.md:
- Pull the latest from main before starting work (`git pull` if on main, or `git fetch origin && git merge origin/main` if on a feature branch) so we're never working on stale code.
- Check the current git branch. If on main, you'll create a feature branch when starting work. If on an existing feature/fix branch, let me know so I can decide whether to continue or switch.
- Propose your implementation approach for the next ticket
- Wait for my approval before starting
- Create the feature branch from main (e.g., `feature/PROJ-12-note-editor`) before writing any code
- Use the TDD protocol (draft test plan → Staff Engineer reviews test plan → failing tests → implement → pass)
- Run review gates after implementation (G3 Staff Engineer, G4 Design Director if UI changed)
- When done: commit with ticket ID, push branch, create PR, comment on ticket with PR link, update status, update memory bank, ask if I should clear context or bring in the next ticket

When it comes to UI work, shop the approach and layouts with me before diving in. Follow the project's design system and platform conventions.

Use subagents for research to save context window.
