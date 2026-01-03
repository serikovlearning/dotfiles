#!/usr/bin/env bash
pane="$1"

# Get current command
cmd=$(tmux display-message -p -t "$pane" "#{pane_current_command}")

# Get last folder of current path
dir=$(tmux display-message -p -t "$pane" "#{pane_current_path:t}")

# Build window name (safe fallback)
if [ -n "$cmd" ]; then
    name="$cmd / $dir"
else
    name="$dir"
fi

# Optional: nvim icon (requires Nerd Fonts)
#if [ "$cmd" = "nvim" ]; then
#    name=" $cmd / $dir"
#fi

# Rename window
tmux rename-window -t "$pane" "$name"
