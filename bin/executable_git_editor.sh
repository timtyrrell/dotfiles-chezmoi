#!/usr/bin/env bash

if [[ -n "$TMUX" ]]; then
  tmux display-popup -E -w 90% -h 80% -b rounded -T 'COMMIT' nvim +startinsert "$@"
else
  nvim +startinsert "$@"
fi
