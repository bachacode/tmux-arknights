#!/usr/bin/env bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

get_option() {
  local option=$(tmux show-option -gqv "$1")
  [ -z "$option" ] && echo "$2" || echo "$option"
}

set() {
  tmux set-option -gq "$1" "$2"
}

setw() {
  tmux set-window-option -gq "$1" "$2"
}

main() {
    local thm_bg="#0B0C0B"     # regular0
    local thm_fg="#D8D8D8"     # regular7
    local thm_gray="#3A4041"   # regular1
    local thm_accent="#FAC060" # regular2
    local thm_alt="#9C8B72"    # regular6
    local thm_alt2="#876436"   # regular4
    local thm_alt3="#887665"   # regular5

    # --- Aggregate commands ---
    local tmux_commands=()

    # --- Status bar ---
    set status "on"
    set status-bg "${thm_bg}"
    set status-justify "left"
    set status-left-length "100"
    set status-right-length "100"

    # --- Messages ---
    set message-style "fg=${thm_accent},bg=${thm_gray},align=centre"
    set message-command-style "fg=${thm_alt2},bg=${thm_gray},align=centre"

    # --- Panes ---
    set pane-border-style "fg=${thm_gray}"
    set pane-active-border-style "fg=${thm_accent}"

    # --- Windows ---
    setw window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
    setw window-status-separator ""
    setw window-status-style "fg=${thm_fg},bg=${thm_bg},none"

    # --- Window status formats ---
    local window_status_format="#[fg=${thm_fg},bg=${thm_bg}] #I #W "
    local window_status_current_format="#[fg=${thm_bg},bg=${thm_accent},bold] #I #W "

    setw window-status-format "${window_status_format}"
    setw window-status-current-format "${window_status_current_format}"

    # --- Statusline content ---
    local right_column1="#[fg=${thm_accent},bg=${thm_bg}] #W "
    local right_column2="#[fg=${thm_alt},bg=${thm_bg}] %Y-%m-%d %H:%M "

    set status-left "#[fg=${thm_accent},bg=${thm_bg}] #S "
    set status-right "${right_column1}${right_column2}"

    # --- Modes ---
    setw clock-mode-colour "${thm_accent}"
    setw mode-style "fg=${thm_accent},bg=${thm_gray},bold"

    # --- Apply everything ---
    tmux "${tmux_commands[@]}"
}
main "$@"
