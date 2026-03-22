#!/bin/bash
# ccyolo.sh - wrapper for claude --dangerously-skip-permissions
# Guards against running without sandbox config in the current repo.
set -euo pipefail

# Find git root (or fall back to cwd)
GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")
SETTINGS_FILE="$GIT_ROOT/.claude/settings.json"

# Check for sandbox config
if [ -f "$SETTINGS_FILE" ]; then
  SANDBOX_ENABLED=$(jq -r '.sandbox.autoAllowBashIfSandboxed // false' "$SETTINGS_FILE" 2>/dev/null || echo "false")
  if [ "$SANDBOX_ENABLED" = "true" ]; then
    exec claude --dangerously-skip-permissions "$@"
  fi
fi

echo "⚠️  Sandbox is not configured for this repo."
echo "    Run /sandbox-setup first, then re-run ccyolo."
exit 1
