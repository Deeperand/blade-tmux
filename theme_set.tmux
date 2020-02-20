source "$BLADE_TMUX_CONFIG_FILE_DIR/theme.conf.tmux.sh"

# window-style
setw -g window-style "fg=$theme_window_fg,bg=$theme_window_bg"

# window-active-style
setw -g window-active-style "fg=$theme_focused_pane_fg,bg=$theme_focused_pane_bg"



# pane border style, possible values are:
    # pane border style, possible values are:
        %if "#{==:$theme_pane_border_style,fat}"
            theme_pane_border_bg=$theme_pane_border_fg
            theme_pane_active_border_bg=$theme_pane_active_border_fg
        %else
            theme_pane_border_bg=default
            theme_pane_active_border_bg=default
        %endif

        setw -g pane-border-style "fg=$theme_pane_border_fg,bg=$theme_pane_border_bg"
        set -g pane-active-border-style "fg=$theme_pane_active_border_fg,bg=$theme_pane_active_border_bg"

    # pane indicator colours
        set -g display-panes-colour "$theme_display_panes_colour"
        set -g display-panes-active-colour "$theme_display_panes_active_colour"

# set-titles-string (if use term, this information will be displayed at the tab)
    set -g set-titles-string "$theme_terminal_title"

# clock-mode-style, clock-mode-colour (when you hit <prefix> + t)
    setw -g clock-mode-colour "$theme_clock_colour"
    setw -g clock-mode-style "$theme_clock_style"

# status bar
    # message-style
        set -g message-style "fg=$theme_message_fg,bg=$theme_message_bg,$theme_message_attr"

    # message-command-style (<prefix> : Escape)
        set -g message-command-style "fg=$theme_message_command_fg,bg=$theme_message_command_bg,$theme_message_command_attr"

    # modes-style
        setw -g mode-style "fg=$theme_mode_fg,bg=$theme_mode_bg,$theme_mode_attr"

    # status line style
        set -g status-style "fg=$theme_status_fg,bg=$theme_status_bg,$theme_status_attr"
        set -g status-left-style "fg=$theme_status_fg,bg=$theme_status_bg,$theme_status_attr"
        set -g status-right-style "fg=$theme_status_fg,bg=$theme_status_bg,$theme_status_attr"

    # window-status-style (non-current windows)
        # since Tmux was already support utf-8 escape character, the function `_decode_unicode_escape` support by `gpakosz-tmux` wasn't needed anymore
        setw -g window-status-style "fg=$theme_window_status_fg,bg=$theme_window_status_bg,$theme_window_status_attr"
        setw -g window-status-format $theme_window_status_format

    # window-status-current-style
        setw -g window-status-current-style "fg=$theme_window_status_current_fg,bg=$theme_window_status_current_bg,$theme_window_status_current_attr"
        setw -g window-status-current-format "$theme_window_status_current_format"


        # window-status-last-style
            setw -g window-status-last-style "fg=$theme_window_status_last_fg,bg=$theme_window_status_last_bg,$theme_window_status_last_attr"

        # window-status-activity-style
            setw -g window-status-activity-style "fg=$theme_window_status_activity_fg,bg=$theme_window_status_activity_bg,$theme_window_status_activity_attr"

        # window-status-bell-style
            setw -g window-status-bell-style "fg=$theme_window_status_bell_fg,bg=$theme_window_status_bell_bg,$theme_window_status_bell_attr"


        # window-status-separator
            setw -g window-status-separator "$theme_window_status_separator"

    # status left style
        # status_left="#(source $BLADE_TMUX_CONFIG_FILE_DIR/theme_extension.sh; get_left_status)"
        set -g status-left-length 1000
        set -g status-right-length 1000

        run -b "source $BLADE_TMUX_CONFIG_FILE_DIR/theme_extension.sh; set_status_bar"
