#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

get_option() {
  local option=$(tmux show-option -gqv "$1")
  [ -z $option ] && echo $2 || echo $option
}

set_option() {
  tmux set-option -g "$1" "$2"
}

main() {
    set -g status-style 'bg=white,fg=black'
}

main
