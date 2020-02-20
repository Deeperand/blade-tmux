# this file just support a public variable defienation both .tmux file and .sh file, so never add any statment except assignment in this file.

# window-style
    theme_window_fg='default'
    theme_window_bg='default'

# window-active-style
    theme_focused_pane_fg=default
    theme_focused_pane_bg=default

# pane border style, possible values are:
    # pane border style, possible values are:
    #   - thin (default)
    #   - fat
        theme_pane_border_style=thin

    # pane borders colours:
        theme_pane_border_colour='#444444'
        theme_pane_active_border_colour='#00afff'

    # fg and bg colour
        theme_pane_border_fg='#444444'
        theme_pane_active_border_fg='#00afff'

    # pane indicator colours
        theme_display_panes_colour='#00afff'
        theme_display_panes_active_colour='#00afff'

# set-titles-string (if use term, this information will be displayed at the tab)
    theme_terminal_title='❐ #S ● #I ○ #P'

# clock-mode-style, clock-mode-colour (when you hit <prefix> + t)
    theme_clock_colour='#00afff'
    theme_clock_style='24' # 24 or 12

# status bar
    # pairing indicator
        plug_pairing='👓 '          # U+1F453
        plug_pairing_fg='none'
        plug_pairing_bg='none'
        plug_pairing_attr='none'

    # prefix indicator
        plug_prefix='⌨ '            # U+2328
        plug_prefix_fg='none'
        plug_prefix_fg='none'
        plug_prefix_bg='none'
        plug_prefix_attr='none'

    # root indicator
        plug_root='!'
        plug_root_fg='none'
        plug_root_bg='none'
        plug_root_attr='bold,blink'

    # synchronized indicator
        plug_synchronized='🔒'     # U+1F512
        plug_synchronized_fg='none'
        plug_synchronized_bg='none'
        plug_synchronized_attr='none'

    # status left/right sections separators
        theme_left_sep_main="\ue0b4"
        theme_left_sep_sub="\ue0b5"
        theme_right_sep_main="\ue0be"
        theme_right_sep_sub="\ue0bf"

    # status line message
        theme_message_fg='#39393a'
        theme_message_bg='#ffff00'
        theme_message_attr='bold'

    # message-command-style (<prefix> : Escape)
        theme_message_command_fg='#ffff00'
        theme_message_command_bg='#39393a'
        theme_message_command_attr='bold'

    # modes-style
        theme_mode_fg='#39393a'
        theme_mode_bg='#ffff00'
        theme_mode_attr='bold'

    # status-line-style
        theme_status_fg='#8a8a8a'
        theme_status_bg='#39393a'
        theme_status_attr='none' # to get more details, see `man tmux` ---> `STYLE`

    # window-status-style (non-current windows)
        # separators used in winow status display
            theme_left_window_sep_main="\ue0cc"
            theme_left_window_sep_sub="|"

            theme_right_window_sep_main="\ue0be"
            theme_right_window_sep_sub="\ue0bf"

        # window-status-style, window-status-format
            theme_window_status_fg='#efffff'
            # theme_window_status_bg='#39393a'
            theme_window_status_bg='#8d8d91'
            theme_window_status_attr='none'
            theme_window_status_format="#{?#{==:#{window_start_flag},1},#[fg=$theme_status_bg]$theme_left_window_sep_main,}#[fg=$theme_window_status_fg] #I #W#{?window_bell_flag, 🔔,}#{?window_zoomed_flag, 🔍,} #{?#{==:#{window_end_flag},1},#[fg=$theme_window_status_bg#,bg=$theme_status_bg]$theme_left_window_sep_main,$theme_left_window_sep_sub}"

        # window-status-current-style, window-status-current-format
            theme_window_status_current_fg='#39393a'
            theme_window_status_current_bg='#00afff'
            # theme_window_status_current_bg='#00af00'
            theme_window_status_current_attr='bold'
            theme_window_status_current_format="#{?#{==:#{window_start_flag},1},#[fg=$theme_status_bg]$theme_left_window_sep_main,}#[fg=$theme_window_status_curreng_fg] #I #W#{?window_zoomed_flag, 🔍,} #{?#{==:#{window_end_flag},1},#[fg=$theme_window_status_current_bg#,bg=$theme_status_bg]$theme_left_window_sep_main,#[fg=$theme_window_status_fg,bg=$theme_window_status_bg]$theme_left_window_sep_sub}"

        # window-status-last-style
            theme_window_status_last_fg="#00afff"
            theme_window_status_last_bg=$theme_window_status_bg
            theme_window_status_last_attr="bold"

        # window-status-activity-style
            theme_window_status_activity_fg="default"
            theme_window_status_activity_bg="default"
            theme_window_status_activity_attr="underscore"

        # window-status-bell-style
            theme_window_status_bell_fg="#ffff00"
            theme_window_status_bell_bg="default"
            theme_window_status_bell_attr="blink,bold"

        # window-status-separator
            theme_window_status_separator=""

# left and right ststus
    # status left/right content:
    #     - separate main sections with '|'
    #     - separate subsections with ','
    #     - some useful Tmux built-in variable:
    #         - #{cursor_x}: cursor X position in pane
    #         - #{cursor_y}: cursor Y position in pane
    #         - #{pane_current_path}: current path of current pane
    #         - #{pane_height}: height of pane
    #         - #{pane_in_mode}: 1 if in copy mode
    #         - #{pane_mode}: name of pane mode, if any
    #         - #{pane_synchronized}: 1 if pane is synchronized
    #         - #{version}: server version (which means version of Tmux used)
    #     - additional variables provided by Blade-Tmux are:
    #         - #{plug_pairing}
    #         - #{plug_prefix}
    #         - #{plug_synchronized}
    #         - #{plug_username}
    #         - #{plug_hostname}
    # status-left
        theme_status_left=' #{?pane_mode,COPY,NORM} | ❐ #S , ● #I ○ #P | PID: #{client_pid} '
        theme_status_left_fg='#efffff,#efffff,#47474a' # 对于较亮的背景色, 为了维持主管上的亮度一致, 应适当降低文字与背景的对比度, 故这里采用了比 #39393a 更浅一点的颜色
        theme_status_left_bg='#ff00af,#6bd16e,#ffff00'
        theme_status_left_attr='bold,bold,bold'

    # status-right
        theme_status_right='#{plug_prefix}#{plug_pairing}#{plug_synchronized} #{pane_current_path} | %R , %a %b %d | #{plug_username} | #{plug_hostname} '
        theme_status_right_fg='#efffff,#efffff,#efffff,#39393a'
        theme_status_right_bg='#B38249,#49769e,#d70000,#e4e4e4'
        theme_status_right_attr='none,none,none,bold'

