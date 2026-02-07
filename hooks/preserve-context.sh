#!/bin/bash
# preserve-context.sh — Saves critical project context before autocompact
# Fired by PreCompact hook so context survives compaction

set -euo pipefail

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null)
CWD=$(echo "$INPUT" | jq -r '.cwd // "."' 2>/dev/null)

# Determine context save location
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

    # Uncommitted changes summary
    CHANGES=$(git -C "$CWD" status --short 2>/dev/null || echo "")
    if [ -n "$CHANGES" ]; then
      echo "### Uncommitted Changes"
      echo '```'
      echo "$CHANGES"
      echo '```'
      echo ""
    fi
  fi

  # Memory bank context (if exists)
  CONTEXT_MD="$CWD/.kilocode/rules/memory-bank/context.md"
  if [ -f "$CONTEXT_MD" ]; then
    echo "## Current Context (from memory bank)"
    echo ""
    cat "$CONTEXT_MD"
    echo ""
  fi

  # Tasks (if exists)
  TASKS_MD="$CWD/.kilocode/rules/memory-bank/tasks.md"
  if [ -f "$TASKS_MD" ]; then
    echo "## Current Tasks (from memory bank)"
    echo ""
    cat "$TASKS_MD"
    echo ""
  fi

} > "$SNAPSHOT_FILE"

echo "Context snapshot saved for session $SESSION_ID" >&2
exit 0
