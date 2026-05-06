#!/usr/bin/env bash

NVIM_ARGS=(-u "$HOME/.config/nvim/init-quick.lua" "$@")

if [[ -n "$TMUX" ]]; then
  tmux display-popup -E -w 90% -h 80% -b rounded -T 'EDIT' nvim "${NVIM_ARGS[@]}"
else
  nvim "${NVIM_ARGS[@]}"
fi
