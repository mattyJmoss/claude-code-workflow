This is a new project. Before starting any work, set up the project infrastructure:

1. **Create the memory bank** — Copy templates from `~/.claude/templates/memory-bank/` into `.kilocode/rules/memory-bank/`. The core files are: brief.md, product.md, architecture.md, tech.md, design.md, context.md, tasks.md. Optionally include interaction.md and patterns.md if the project has a UI with a design system.

2. **Fill in brief.md** — I'll describe what this project is. Capture the vision, target users, core concept, and what this is NOT (v1 scope boundaries).

3. **Create a project CLAUDE.md** at the project root with:
   - A "Memory Bank (READ FIRST)" section listing the read order
   - A "Memory Bank Updates" section with update rules
   - Any project-specific overrides or conventions we discuss
   - Reference to the global workflow in `~/.claude/CLAUDE.md`

4. **Start the conversation** — Ask me about:
   - What this project does and who it's for (for brief.md)
   - Tech stack preferences (for architecture.md and tech.md)
   - Any design direction or inspiration (for design.md)
   - Whether there's an existing PRD or if we need to develop one

If I provide a PRD or detailed description with my command, use that to fill in as much of the memory bank as possible, then confirm what you captured and ask about anything unclear.

The argument is the project name: **$ARGUMENTS**
