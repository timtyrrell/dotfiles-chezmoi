#!/bin/bash
# Sends an OSC 9 desktop notification to Ghostty. Wired to two Claude Code
# hooks (see ~/.claude/settings.json):
#   - Notification: permission prompts etc. (idle waits are filtered out)
#   - Stop:         fires when Claude finishes a turn ("task done running")
# Ghostty only shows the banner when its window is unfocused, so these are
# silent while you're watching and only alert once you've stepped away.
INPUT=$(cat)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // ""' 2>/dev/null || echo "")
MSG=$(echo "$INPUT" | jq -r '.message // ""' 2>/dev/null || echo "")
TYPE=$(echo "$INPUT" | jq -r '.notification_type // ""' 2>/dev/null || echo "")

case "$EVENT" in
  Stop)
    MSG="Claude finished responding"
    ;;
  *)
    # Notification event: skip idle prompts and empty messages
    if [ "$TYPE" = "idle_prompt" ] || [ -z "$MSG" ] || [ "$MSG" = "Claude is waiting for your input" ]; then
      exit 0
    fi
    ;;
esac

# Emit OSC 9. Inside tmux the inner OSC 9 is BEL-terminated (\a) so there is no
# bare ESC that tmux would mistake for the end of its own passthrough wrapper;
# the opening ESC of OSC 9 is doubled (\e\e) as tmux passthrough requires.
if [ -n "$TMUX" ]; then
  SEQ=$(printf '\ePtmux;\e\e]9;%s\a\e\\' "$MSG")
else
  SEQ=$(printf '\e]9;%s\e\\' "$MSG")
fi

# Claude Code captures this hook's stdout/stderr (they are pipes), and /dev/tty
# is not attached, so escape sequences written there never reach the terminal.
# Instead walk up the process tree to find the nearest ancestor with a real
# controlling tty (the tmux pane's pty) and write to that device directly.
find_tty() {
  local pid=$PPID i tty ppid
  for i in 1 2 3 4 5 6; do
    [ -n "$pid" ] && [ "$pid" != "0" ] && [ "$pid" != "1" ] || return 1
    tty=$(ps -o tty= -p "$pid" 2>/dev/null | tr -d ' ')
    if [ -n "$tty" ] && [ "$tty" != "??" ] && [ -w "/dev/$tty" ]; then
      printf '/dev/%s' "$tty"
      return 0
    fi
    pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
  done
  return 1
}

TTY_DEV=$(find_tty)
if [ -n "$TTY_DEV" ]; then
  printf '%s' "$SEQ" > "$TTY_DEV"
fi
