#!/bin/bash
# preserve-context.sh — Saves critical project context before compaction
# Note: CLAUDE.md now survives compaction natively. This hook captures
# ephemeral context that CLAUDE.md doesn't cover: git state, GSD phase,
# and active work summary.

set -euo pipefail

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null)
CWD=$(echo "$INPUT" | jq -r '.cwd // "."' 2>/dev/null)

CONTEXT_DIR="$HOME/.claude/compaction-context"
mkdir -p "$CONTEXT_DIR"
SNAPSHOT_FILE="$CONTEXT_DIR/snapshot.md"

{
  echo "# Context Snapshot (Pre-Compaction)"
  echo ""
  echo "**Session:** $SESSION_ID"
  echo "**Timestamp:** $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo "**Working Directory:** $CWD"
  echo ""

  # Git state
  if [ -d "$CWD/.git" ] || git -C "$CWD" rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git -C "$CWD" branch --show-current 2>/dev/null || echo "unknown")
    echo "## Git State"
    echo "**Branch:** $BRANCH"
    echo ""
    echo "### Recent Commits"
    echo '```'
    git -C "$CWD" log --oneline -5 2>/dev/null || echo "(no commits)"
    echo '```'
    echo ""

    CHANGES=$(git -C "$CWD" status --short 2>/dev/null || echo "")
    if [ -n "$CHANGES" ]; then
      echo "### Uncommitted Changes"
      echo '```'
      echo "$CHANGES"
      echo '```'
      echo ""
    fi
  fi

  # GSD state (if active)
  if [ -f "$CWD/.planning/STATE.md" ]; then
    echo "## GSD State"
    echo ""
    head -30 "$CWD/.planning/STATE.md"
    echo ""
    echo "(truncated — read full STATE.md if needed)"
    echo ""
  fi

  # GSD current phase progress
  if [ -d "$CWD/.planning" ]; then
    LATEST_PHASE=$(ls "$CWD"/.planning/*-PLAN.md 2>/dev/null | sort -V | tail -1)
    if [ -n "${LATEST_PHASE:-}" ]; then
      echo "## Latest Plan"
      echo "**File:** $(basename "$LATEST_PHASE")"
      echo ""
    fi
  fi

} > "$SNAPSHOT_FILE"

echo "Context snapshot saved for session $SESSION_ID" >&2
exit 0
