Sync the local Claude Code workflow files to the public `claude-code-workflow` GitHub repo.

## Steps

1. **Read the sync config** — Read `~/.claude/sync-workflow-rules.json` for file mappings, sanitization rules, exclusions, and paths.

2. **Ensure the local repo clone exists** — Check if the repo exists at the path in `repo_local_path`. If not, clone it:
   ```
   gh repo clone <repo> <repo_local_path>
   ```

3. **Pull latest** — `cd <repo_local_path> && git pull origin main`

4. **For each file in `file_mappings`**:
   a. Read the source file (expand `~` to `$HOME`)
   b. Apply all matching `sanitize_rules` (find/replace or remove_line)
   c. Write the sanitized content to the destination path in the repo
   d. Track which files were changed

5. **Diff and report** — Run `git diff --stat` in the repo directory. Show me:
   - Which files changed
   - A summary of what was sanitized
   - Any new files in `~/.claude/` that aren't in the mappings (potential additions)

6. **Wait for approval** — Ask me to confirm before committing. Show the full diff if I want to review.

7. **On approval** — Commit with message: `chore: sync workflow files from local` and push.

8. **Sync to Obsidian** — Using the `obsidian_sync_targets` config:
   - Copy updated templates to the Obsidian templates directory
   - Copy updated prompts/docs to the Obsidian Claude Code directory
   - Report what was synced

## Important Rules

- **NEVER copy files listed in `exclude_files`** — these contain secrets or personal data
- **ALWAYS apply ALL sanitize_rules** — even if the pattern doesn't match (it may have already been sanitized)
- **Files in `manually_maintained`** are in the public repo but NOT auto-synced from a source file. Don't overwrite them. But DO flag if they reference content that changed (e.g., if a command name changed, the docs may need a manual update).
- **If a source file has content that looks like it should be sanitized but isn't covered by a rule**, flag it and ask me before proceeding. Better to pause than to leak personal content.
- **Show me any new files in `~/.claude/commands/`, `~/.claude/prompts/`, or `~/.claude/templates/`** that aren't in the mappings — I may want to add them.

The argument (optional) can be "dry-run" to show what would change without committing: **$ARGUMENTS**
