This is a new project. Before starting any work, set up the project infrastructure:

1. **Create the memory bank** — Copy templates from `~/.claude/templates/memory-bank/` into `.kilocode/rules/memory-bank/`. The core files are: brief.md, product.md, architecture.md, tech.md, design.md, context.md, tasks.md. Optionally include interaction.md and patterns.md if the project has a UI, and issues.md as a parking lot for observations.

2. **Fill in brief.md through conversation** — Ask me about:
   - What this product is (one sentence)
   - Who it's for (specific roles, not "users")
   - What problems it solves (what was painful before?)
   - Why those problems matter to those people
   - Where it's going (what's next?)
   - What this is NOT (v1 scope boundaries)

3. **Ask about tech stack** — For architecture.md and tech.md:
   - Platform and language preferences
   - Any libraries/frameworks to use or avoid

4. **Create a project CLAUDE.md** at the project root with:
   - A "Memory Bank (READ FIRST)" section listing the read order (include issues.md and reference docs)
   - A "Memory Bank Updates" section with update rules
   - A "Reference Docs" section pointing to `docs/api.md`, `docs/schema.md`, `docs/development.md`
   - Any project-specific overrides or conventions we discuss
   - Reference to the global workflow in `~/.claude/CLAUDE.md`

5. **Set up project management** — If using a project management tool (Plane, Linear, etc.), create the project. Confirm the project name and ticket prefix with me.

6. **Scaffold the reference docs layer** — Create a `docs/` directory at the project root. Copy templates from `~/.claude/templates/docs/`. This is where API specs, data schemas, and implementation specs will live. The memory bank stays concise; `docs/` holds the heavyweight reference.

7. **Ask about design direction** — If this has a UI:
   - Any existing design system or component library?
   - Design inspiration or references?
   - Platform (iOS, Android, web, cross-platform)?
   - Should we capture interaction principles now or wait until we've built some UI?
   If the user says yes to capturing design principles now, run the `/setup-design-system new` flow inline — this populates `interaction.md` and optionally `patterns.md` with the taste layer (behavioral decisions + rationale).

If I provide existing docs (PRD, notes, spec, whatever), use that to fill in as much as possible, then confirm and ask about gaps.

The argument is the project name: **$ARGUMENTS**
