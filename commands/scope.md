Read the memory bank at `.kilocode/rules/memory-bank/` in order: brief → product → architecture → tech → design → context → tasks. Then read the project CLAUDE.md.

Fetch Plane tickets via MCP for the **$ARGUMENTS** project to understand what already exists.

This is a **planning session** — no implementation today. Enter plan mode.

I'll describe the feature or work I want to plan. Then follow this process:

1. **Draft the implementation plan** — Explore the codebase, understand the current architecture, and propose how to build what I'm describing. Include architecture decisions, data flows, and a suggested ticket breakdown. Structure each phase with:
   - A clear **Goal** statement
   - A **Deliverables table** listing each file to create/modify: `| File | Action (New/Modify) | Purpose |`
   - A **Review checkpoint** — verification checklist for the phase (specific testable criteria, build/type check passes, tests pass)
   Save the full plan to `docs/specs/` if the project has a reference docs layer.

2. **G1 — Staff Engineer reviews the plan** — Spawn a Staff Level Engineer subagent (read `~/.claude/prompts/staff-engineer.md`, use Plan Review mode). Pass the plan, memory bank context, and any acceptance criteria. Incorporate their feedback and update the plan.

3. **Break into Plane tickets** — After the plan passes G1, create tickets in Plane with clear acceptance criteria (refined by reviewer feedback), correct dependencies, and appropriate priority.

4. **G2 — Design Director reviews UI tickets** — For any tickets involving UI/UX work, spawn a Design Director subagent (read `~/.claude/prompts/design-director.md`; use project-specific prompt if one exists). Pass UI ticket AC + design system docs. Update ticket AC with design feedback.

5. **Update the memory bank** — Update context.md with planning decisions, tasks.md with the new ticket list, and architecture.md/design.md if relevant decisions were made.

At the end, show me the final reviewed ticket list so I know what's ready for implementation sessions.
