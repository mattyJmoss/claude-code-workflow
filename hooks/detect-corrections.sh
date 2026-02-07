#!/bin/bash
# detect-corrections.sh — Detects user correction patterns for self-improvement
# Fired by UserPromptSubmit hook. Logs corrections for /reflect review.
# Does NOT block the prompt — observation only.

set -euo pipefail

INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // ""' 2>/dev/null)

# Exit early if prompt is empty or very short
if [ ${#PROMPT} -lt 5 ]; then
  exit 0
fi

# Correction patterns (case-insensitive grep)
# These indicate the user is correcting Claude's behavior
PATTERNS=(
  "^no[,. ]"
  "^actually[,. ]"
  "^don't do that"
  "^stop doing"
  "^that's wrong"
  "^that's not"
  "^that is wrong"
  "^that is not"
  "use .* instead"
  "^instead of"
  "^I said"
  "^I told you"
  "^I meant"
  "^not like that"
  "^wrong[,. ]"
  "^revert"
  "^undo"
  "^go back"
  "never do"
  "always do"
  "^please don't"
  "^stop "
  "I already told you"
  "^fix that"
  "that's not what I"
  "^you should have"
  "^you forgot"
  "^you missed"
  "^you didn't"
)

CORRECTION_DETECTED=false
MATCHED_PATTERN=""

for pattern in "${PATTERNS[@]}"; do
  if echo "$PROMPT" | grep -qi "$pattern" 2>/dev/null; then
    CORRECTION_DETECTED=true
    MATCHED_PATTERN="$pattern"
    break
  fi
done

if [ "$CORRECTION_DETECTED" = true ]; then
  # Log the correction
  TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  LOG_FILE="$HOME/.claude/corrections-log.jsonl"
  CWD=$(echo "$INPUT" | jq -r '.cwd // "unknown"' 2>/dev/null)
  PROJECT=$(basename "$CWD")

  # Truncate prompt to 500 chars for logging
  TRUNCATED_PROMPT=$(echo "$PROMPT" | head -c 500)

  echo "{\"timestamp\": \"$TIMESTAMP\", \"project\": \"$PROJECT\", \"pattern\": \"$MATCHED_PATTERN\", \"prompt\": $(echo "$TRUNCATED_PROMPT" | jq -Rs .)}" >> "$LOG_FILE"

  # Output context that Claude will see — gentle reminder
  echo "Self-improvement note: A correction pattern was detected in this prompt. After addressing the user's request, consider whether this represents a recurring pattern that should be captured in CLAUDE.md or the project's memory bank. Use /reflect periodically to review accumulated corrections."
fi

exit 0
