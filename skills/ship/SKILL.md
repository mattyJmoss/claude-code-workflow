---
name: ship
description: >
  Post-completion shipping workflow. Commits, pushes, deploys server if
  needed. Client deployment (OTA/builds) is handled automatically by EAS
  Workflows on push — /ship just gets the code to GitHub. Invoke with /ship.
user-invocable: true
---

# Ship — Post-Completion Deployment Orchestrator

You handle everything after code is written: commit, push, and deploy
the server. Client-side deployment (OTA updates, native builds) is
handled automatically by EAS Workflows when code is pushed to GitHub.

## CI/CD Architecture
- Push to `main` → EAS fingerprints → OTA update (free) or native build
- Push to `release-v*` → production build + TestFlight/Play Store submission
- PR to `main` → PR preview OTA update for testing
- Server changes → you deploy manually via `wrangler deploy` (not in CI)

## Process

### Step 1: Analyze Changes
Run `git status` and `git diff --name-only` to categorize changes:

**Classify each changed file into buckets:**
- **server/** — requires Cloudflare Workers deployment (manual, not in CI)
- **client** — any `app/`, `lib/`, `components/`, `modules/`, `plugins/`,
  `app.config.ts`, `package.json`, asset changes. EAS Workflows handles
  these automatically on push. Fingerprint determines OTA vs native build.
- **workflow** — no deployment needed:
  `CLAUDE.md`, `.claude/`, `.reviews/`, `.gitignore`, `docs/`

### Step 2: Run Review (if not already run)
Check if there are staged or unstaged changes. If so, run `/review`
and wait for approval before proceeding.

If changes are already committed (nothing in `git status`), skip to Step 3.

### Step 3: Commit and Push
- Stage relevant files
- Create commit with conventional commit message
- Include `Reviewed-by:` trailer if review ran
- Push to remote

Pushing to `main` automatically triggers the EAS preview workflow.
Pushing to a `release-v*` branch triggers the production workflow.

### Step 4: Deploy Server (if needed)
**Only if server/ files changed:**
```
cd server && npx wrangler deploy
```
Confirm deployment succeeded. Report the version ID.

Server deployment is NOT in CI because it uses Cloudflare Workers
(separate infra from Expo). This is the only manual deploy step.

### Step 5: Drift Check — Propose Rule Updates
After pushing, analyze the committed changes for drift signals:

**Check for these patterns:**
- `package.json` changed → scan for new/removed/updated dependencies.
  Propose updating `.claude/rules/conventions.md` tech stack section.
- `server/src/` architecture changed (new DOs, new routes, changed data flow)
  → propose updating `.kilocode/rules/memory-bank/architecture.md` or
  flagging it for Alan to update. DO NOT modify `.kilocode/` directly —
  present the diff and say "Alan should update architecture.md with: [change]"
- New crypto patterns or security-relevant changes → propose updating
  `.claude/rules/security.md`
- New conventions established (new directory, new pattern, new test approach)
  → propose updating `.claude/rules/conventions.md`
- `app.config.ts` changed → check if CLAUDE.md commands or pitfalls need updating

**Format:**
```
### Rule Drift Check
- [PROPOSE] conventions.md: Add `expo-haptics` to tech stack (new dependency)
- [FLAG FOR ALAN] architecture.md: UserDO now handles presence tracking
- [OK] security.md: No security-relevant changes
```

Only propose changes that are meaningful and lasting — not one-off implementation
details. If nothing needs updating, report "No rule drift detected."

### Step 6: Report
```
## Ship Report

### Changes
- server/: [N files] → deployed to Cloudflare Workers (version: {id})
- client: [N files] → pushed to main (EAS preview workflow triggered)
- workflow: [N files] → no deployment needed

### Deployments
- Workers: [version ID if server deployed]
- Client: EAS Workflow triggered — check expo.dev dashboard
  - Fingerprint will determine: OTA update (free) or native build

### Rule Drift Check
- [results from Step 5]

### Next Steps
- Monitor EAS Workflow on expo.dev for build/OTA status
- [if server deployed] Verify Workers at https://walkie-talkie-api.matt8066.workers.dev
- [if applicable] Update rules per drift check above
```

## Releasing to Production
When the user says "release" or "ship to production":
1. Confirm main is in a good state (tests pass, no uncommitted changes)
2. Ask for version number (e.g., `v0.3.0`)
3. Create release branch: `git checkout -b release-v{version} && git push -u origin release-v{version}`
4. Report: "Release branch pushed. EAS production workflow triggered — will build and submit to TestFlight + Play Store automatically."

## Rules
- NEVER deploy server changes without confirming the deploy succeeded
- Client deployment is ALWAYS handled by EAS Workflows — never run
  `eas update` or `eas build` manually from /ship
- If review found CRITICAL issues, do NOT proceed until resolved
- If tests fail, do NOT push — report the failures and stop
- For production releases, ALWAYS create a `release-v*` branch
