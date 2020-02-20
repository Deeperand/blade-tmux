# -- basic knowledge ---------------------------------------------------
# alias of default variable
# #H #{host}
# #h #{host_short}
# #D #{pane_id}
# #P #{pane_index}
# #T #{pane_title}
# #S #{session_name}
# #F #{window_flags}
# #I #{window_index}
# #W #{window_name}

# symbol might be used: ⦿ ⬥ ⭘  ○ 🔋  ↯ ❐ ↑

# -- windows & pane creation ---------------------------------------------------
set -ga terminal-overrides "*:kUP3=\e[1;9A,*:kDN3=\e[1;9B,*:kRIT3=\e[1;9C,*:kLFT3=\e[1;9D"

# new window retains current path, possible values are:
#   - true
#   - false (default)
tmux_conf_new_window_retain_current_path=false

# new pane retains current path, possible values are:
#   - true (default)
#   - false
tmux_conf_new_pane_retain_current_path=true

# new pane tries to reconnect ssh sessions (experimental), possible values are:
#   - true
#   - false (default)
tmux_conf_new_pane_reconnect_ssh=false

# prompt for session name when creating a new session, possible values are:
#   - true
#   - false (default)
tmux_conf_new_session_prompt=false


# -- display -------------------------------------------------------------------

# RGB 24-bit colour support (tmux >= 2.2), possible values are:
#  - true
#  - false (default)
tmux_conf_theme_24b_colour=false

# window style
tmux_conf_theme_window_fg='default'
tmux_conf_theme_window_bg='default'

# hightlight focused pane
    # enable/disable highlight focused pane (tmux >= 2.1), possible values are:
    #   - true
    #   - false (default)
        tmux_conf_theme_highlight_focused_pane=false

    # focused pane colours:
        tmux_conf_theme_focused_pane_fg='default'
        tmux_conf_theme_focused_pane_bg='#0087d7'               # light blue

# pane border
    # pane border style, possible values are:
    #   - thin (default)
    #   - fat
        tmux_conf_theme_pane_border_style=thin

    # pane borders colours:
        tmux_conf_theme_pane_border='#444444'                   # gray
        tmux_conf_theme_pane_active_border='#00afff'            # light blue

    # pane indicator colours
        tmux_conf_theme_pane_indicator='#00afff'                # light blue
        tmux_conf_theme_pane_active_indicator='#00afff'         # light blue

# terminal title (if use term, this information will be displayed at the tab)
#   - built-in variables are:
#     - #{circled_window_index}
#     - #{circled_session_name}
#     - #{hostname}
#     - #{hostname_ssh}
#     - #{username}
#     - #{username_ssh}
# default: '#h ❐ #S ● #I #W'
tmux_conf_theme_terminal_title='❐ #S ● #I ○ #P'


# clock style (when you hit <prefix> + t)
# you may want to use %I:%M %p in place of %R in tmux_conf_theme_status_right
    tmux_conf_theme_clock_colour='#00afff'  # light blue
    tmux_conf_theme_clock_style='24'

# status bar
    # status left/right sections separators
        tmux_conf_theme_left_separator_main='\ue0b4'
        tmux_conf_theme_left_separator_sub='\ue0b5'
        tmux_conf_theme_right_separator_main='\ue0be'
        tmux_conf_theme_right_separator_sub='\ue0bf'

        tmux_conf_theme_left_window_separator_main='\ue0b4'
        tmux_conf_theme_left_window_separator_sub='\ue0b5'
        tmux_conf_theme_right_window_separator_main='\ue0be'
        tmux_conf_theme_right_window_separator_sub='\ue0bf'

    # status line message
        tmux_conf_theme_message_fg='#39393a'
        tmux_conf_theme_message_bg='#ffff00'
        tmux_conf_theme_message_attr='bold'

    # status line command style (<prefix> : Escape)
        tmux_conf_theme_message_command_fg='#ffff00'
        tmux_conf_theme_message_command_bg='#39393a'
        tmux_conf_theme_message_command_attr='bold'

    # window modes style
        tmux_conf_theme_mode_fg='#39393a'
        tmux_conf_theme_mode_bg='#ffff00'
        tmux_conf_theme_mode_attr='bold'

    # status line style
        tmux_conf_theme_status_fg='#8a8a8a'
        tmux_conf_theme_status_bg='#39393a'
        tmux_conf_theme_status_attr='none' # to get more details, see `man tmux` ---> `STYLE`

    # window-status-current-style
        #   - built-in variables are:
        #     - #{circled_window_index}
        #     - #{circled_session_name}
        #     - #{hostname}
        #     - #{hostname_ssh}
        #     - #{username}
        #     - #{username_ssh}
        tmux_conf_theme_window_status_current_fg='#39393a'
        tmux_conf_theme_window_status_current_bg='#00afff'
        # tmux_conf_theme_window_status_current_bg='#00af00'
        tmux_conf_theme_window_status_current_attr='bold'
        tmux_conf_theme_window_status_current_format='#I #W#{?window_zoomed_flag,🔍,}'

    # window-status-style (non-current windows)
        #   - built-in variables are:
        #     - #{circled_window_index}
        #     - #{circled_session_name}
        #     - #{hostname}
        #     - #{hostname_ssh}
        #     - #{username}
        #     - #{username_ssh}
        tmux_conf_theme_window_status_fg='#298e1b'
        # tmux_conf_theme_window_status_bg='#39393a'
        tmux_conf_theme_window_status_bg='#8d8d91'
        tmux_conf_theme_window_status_attr='none'
        tmux_conf_theme_window_status_format=' #I #W#{?window_bell_flag,🔔,}#{?window_zoomed_flag,🔍,} \ue0b5'

        # window-status-last-style
            tmux_conf_theme_window_status_last_fg='#00afff'
            # tmux_conf_theme_window_status_last_bg='default'
            tmux_conf_theme_window_status_last_bg='#0f7ab7'
            tmux_conf_theme_window_status_last_attr='none'

        # window-status-activity-style
            tmux_conf_theme_window_status_activity_fg='default'
            tmux_conf_theme_window_status_activity_bg='default'
            tmux_conf_theme_window_status_activity_attr='underscore'

        # window-status-bell-style
            tmux_conf_theme_window_status_bell_fg='#ffff00'
            tmux_conf_theme_window_status_bell_bg='default'
            tmux_conf_theme_window_status_bell_attr='blink,bold'


        # window-status-separator
            tmux_conf_theme_window_status_separator=''

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
    #     - additional variables vase standard Tmux are:
    #         - some variables might lead to cursor flicker with a fix frequency in NeoVim, so would better don't use it:
    #             - #{battery_bar}
    #             - #{battery_hbar}
    #             - #{battery_percentage}
    #             - #{battery_status}
    #             - #{battery_vbar}
    #             - #{uptime_y} (displaying uptime status for your workstation)
    #             - #{uptime_d} (modulo 365 when #{uptime_y} is used)
    #             - #{uptime_h}
    #             - #{uptime_m}
    #             - #{uptime_s}
    #         - those variables are safe:
    #             - #{circled_session_name}
    #             - #{hostname_ssh}
    #             - #{hostname}
    #             - #{loadavg}
    #             - #{pairing}
    #             - #{prefix}
    #             - #{root}
    #             - #{synchronized}
    #             - #{username}
    #             - #{username_ssh}
    # status left style
        tmux_conf_theme_status_left=' #{?pane_mode,COPY,NORM} | ❐ #S , ● #I ○ #P | #{pane_current_path} '
        tmux_conf_theme_status_left_fg='#e4e4e4,#e4e4e4,#47474a' # 对于较亮的背景色, 为了维持主管上的亮度一致, 应适当降低文字与背景的对比度, 故这里采用了比 #39393a 更浅一点的颜色
        tmux_conf_theme_status_left_bg='#ff00af,#6bd16e,#ffff00'
        tmux_conf_theme_status_left_attr='bold,bold,bold'

    # status right style
        tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} , %R , %a %b %d | #{username}#{root} | #{hostname} '
        tmux_conf_theme_status_right_fg='#e4e4e4,#e4e4e4,#39393a'
        tmux_conf_theme_status_right_bg='#49769e,#d70000,#e4e4e4'
        tmux_conf_theme_status_right_attr='none,none,bold'

    # variable setting
        # pairing indicator
            tmux_conf_theme_pairing='👓 '          # U+1F453
            tmux_conf_theme_pairing_fg='none'
            tmux_conf_theme_pairing_bg='none'
            tmux_conf_theme_pairing_attr='none'

        # prefix indicator
            tmux_conf_theme_prefix='⌨ '            # U+2328
            tmux_conf_theme_prefix_fg='none'
            tmux_conf_theme_prefix_fg='none'
            tmux_conf_theme_prefix_bg='none'
            tmux_conf_theme_prefix_attr='none'

        # root indicator
            tmux_conf_theme_root='!'
            tmux_conf_theme_root_fg='none'
            tmux_conf_theme_root_bg='none'
            tmux_conf_theme_root_attr='bold,blink'

        # synchronized indicator
            tmux_conf_theme_synchronized='🔒'     # U+1F512
            tmux_conf_theme_synchronized_fg='none'
            tmux_conf_theme_synchronized_bg='none'
            tmux_conf_theme_synchronized_attr='none'

        # battery bar
            # battery bar symbols
                tmux_conf_battery_bar_symbol_full='◼'
                tmux_conf_battery_bar_symbol_empty='◻'

            # battery bar length (in number of symbols), possible values are:
            #   - auto
            #   - a number, e.g. 5
                tmux_conf_battery_bar_length='auto'

            # battery bar palette, possible values are:
            #   - gradient (default)
            #   - heat
            #   - 'colour_full_fg,colour_empty_fg,colour_bg', e.g., '#d70000,#e4e4e4,#000000'
                tmux_conf_battery_bar_palette='gradient'   # red, white, black

            # battery hbar palette, possible values are:
            #   - gradient (default)
            #   - heat
            #   - 'colour_low,colour_half,colour_full'
                tmux_conf_battery_hbar_palette='gradient'
            #tmux_conf_battery_hbar_palette='#d70000,#ff5f00,#5fff00'  # red, orange, green

            # battery vbar palette, possible values are:
            #   - gradient (default)
            #   - heat
            #   - 'colour_low,colour_half,colour_full'
                tmux_conf_battery_vbar_palette='gradient'
            #tmux_conf_battery_vbar_palette='#d70000,#ff5f00,#5fff00'  # red, orange, green

            # symbols used to indicate whether battery is charging or discharging
            tmux_conf_battery_status_charging=''    #  U+1F50C
            tmux_conf_battery_status_discharging='↯' #  U+1F50B
