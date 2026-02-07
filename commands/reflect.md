Review the corrections log at `~/.claude/corrections-log.jsonl` to identify patterns and propose self-improvement updates.

Steps:

1. **Read the corrections log** — Each entry has a timestamp, project, matched pattern, and the user's prompt. If the log doesn't exist or is empty, tell the user and stop.

2. **Group by pattern** — Look for recurring themes:
   - Same correction appearing multiple times (e.g., user keeps saying "use X instead of Y")
   - Project-specific patterns vs. global patterns
   - Corrections about coding style, tool usage, communication, or workflow

3. **Cross-reference with existing rules** — Read `~/.claude/CLAUDE.md` and the current project's `CLAUDE.md` (if applicable). Check whether the corrections are already covered by existing rules that aren't being followed, or whether new rules are needed.

4. **Propose updates** — For each pattern found, propose a specific rule addition or modification:
   - **Global rules** go in `~/.claude/CLAUDE.md`
   - **Project-specific rules** go in the project's `CLAUDE.md`
   - Follow the meta-rules format from the Self-Improvement section (absolute directives, concise, with examples)

5. **Show me the proposals** — Present each proposed rule with:
   - The correction pattern that triggered it
   - How many times it appeared
   - The proposed rule text
   - Where it should go (global vs. project CLAUDE.md)

6. **Wait for approval** — Don't make any changes until I approve. I may want to modify the wording or skip some proposals.

7. **Apply approved changes** — Update the relevant CLAUDE.md files with the approved rules.

8. **Archive processed corrections** — Move processed entries from `corrections-log.jsonl` to `corrections-log.processed.jsonl` so they don't get re-analyzed next time.

The project context is: **$ARGUMENTS**
