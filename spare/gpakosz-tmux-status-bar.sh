# style-left
  tmux_conf_theme_status_left=${tmux_conf_theme_status_left-' ❐ #S '}
  tmux_conf_theme_status_left_fg=${tmux_conf_theme_status_left_fg:-'#000000,#e4e4e4,#e4e4e4'}  # black, white , white
  tmux_conf_theme_status_left_bg=${tmux_conf_theme_status_left_bg:-'#ffff00,#ff00af,#00afff'}  # yellow, pink, white blue
  tmux_conf_theme_status_left_attr=${tmux_conf_theme_status_left_attr:-'bold,none,none'}

  tmux_conf_theme_status_left=$(echo "$tmux_conf_theme_status_left" | sed \
    -e "s/#{pairing}/#[fg=$tmux_conf_theme_pairing_fg]#[bg=$tmux_conf_theme_pairing_bg]#[$tmux_conf_theme_pairing_attr]#{?session_many_attached,$tmux_conf_theme_pairing,}/g")

  tmux_conf_theme_status_left=$(echo "$tmux_conf_theme_status_left" | sed \
    -e "s/#{prefix}/#[fg=$tmux_conf_theme_prefix_fg]#[bg=$tmux_conf_theme_prefix_bg]#[$tmux_conf_theme_prefix_attr]#{?client_prefix,$tmux_conf_theme_prefix,}/g")

  tmux_conf_theme_status_left=$(echo "$tmux_conf_theme_status_left" | sed \
    -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg]#[bg=$tmux_conf_theme_root_bg]#[$tmux_conf_theme_root_attr]#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _root #{pane_tty} #D)#[inherit]%g")

  tmux_conf_theme_status_left=$(echo "$tmux_conf_theme_status_left" | sed \
    -e "s%#{synchronized}%#[fg=$tmux_conf_theme_synchronized_fg]#[bg=$tmux_conf_theme_synchronized_bg]#[$tmux_conf_theme_synchronized_attr]#{?pane_synchronized,$tmux_conf_theme_synchronized,}%g")

  if [ -n "$tmux_conf_theme_status_left" ]; then
    status_left=$(awk \
                      -v fg_="$tmux_conf_theme_status_left_fg" \
                      -v bg_="$tmux_conf_theme_status_left_bg" \
                      -v attr_="$tmux_conf_theme_status_left_attr" \
                      -v mainsep="$tmux_conf_theme_left_separator_main" \
                      -v subsep="$tmux_conf_theme_left_separator_sub" '
      function subsplit(s,   l, i, a, r)
      {
        l = split(s, a, ",")
        for (i = 1; i <= l; ++i)
        {
          o = split(a[i], _, "(") - 1
          c = split(a[i], _, ")") - 1
          open += o - c
          o_ = split(a[i], _, "{") - 1
          c_ = split(a[i], _, "}") - 1
          open_ += o_ - c_
          o__ = split(a[i], _, "[") - 1
          c__ = split(a[i], _, "]") - 1
          open__ += o__ - c__

          if (i == l)
            r = sprintf("%s%s", r, a[i])
          else if (open || open_ || open__)
            r = sprintf("%s%s,", r, a[i])
          else
            r = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", r, a[i], fg[j], bg[j], attr[j], subsep)
        }

        gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg[j], bg[j], attr[j]), r)
        return r
      }
      BEGIN {
        FS = "|"
        l1 = split(fg_, fg, ",")
        l2 = split(bg_, bg, ",")
        l3 = split(attr_, attr, ",")
        l = l1 < l2 ? (l1 < l3 ? l1 : l3) : (l2 < l3 ? l2 : l3)
      }
      {
        for (i = j = 1; i <= NF; ++i)
        {
          if (open || open_ || open__)
            printf "|%s", subsplit($i)
          else
          {
            if (i > 1)
              printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg[j_], bg[j], mainsep, fg[j], bg[j], attr[j], subsplit($i)
            else
              printf "#[fg=%s,bg=%s,%s]%s", fg[j], bg[j], attr[j], subsplit($i)
          }

          if (!open && !open_ && !open__)
          {
            j_ = j
            j = j % l + 1
          }
        }
        printf "#[fg=%s,bg=%s,none]%s", bg[j_], "default", mainsep
      }' << EOF
$tmux_conf_theme_status_left
EOF
    )
  fi

  status_left="$status_left "

  # style_right

  tmux_conf_theme_status_right=${tmux_conf_theme_status_right-'#{pairing}#{prefix} #{battery_status} #{battery_bar} #{battery_percentage} , %R , %d %b | #{username} | #{hostname} '}
  tmux_conf_theme_status_right_fg=${tmux_conf_theme_status_right_fg:-'#8a8a8a,#e4e4e4,#000000'} # light gray, white, black
  tmux_conf_theme_status_right_bg=${tmux_conf_theme_status_right_bg:-'#080808,#d70000,#e4e4e4'} # dark gray, red, white
  tmux_conf_theme_status_right_attr=${tmux_conf_theme_status_right_attr:-'none,none,bold'}

  tmux_conf_theme_status_right=$(echo "$tmux_conf_theme_status_right" | sed \
    -e "s/#{pairing}/#[fg=$tmux_conf_theme_pairing_fg]#[bg=$tmux_conf_theme_pairing_bg]#[$tmux_conf_theme_pairing_attr]#{?session_many_attached,$tmux_conf_theme_pairing,}/g")

  tmux_conf_theme_status_right=$(echo "$tmux_conf_theme_status_right" | sed \
    -e "s/#{prefix}/#[fg=$tmux_conf_theme_prefix_fg]#[bg=$tmux_conf_theme_prefix_bg]#[$tmux_conf_theme_prefix_attr]#{?client_prefix,$tmux_conf_theme_prefix,}/g")

  tmux_conf_theme_status_right=$(echo "$tmux_conf_theme_status_right" | sed \
    -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg]#[bg=$tmux_conf_theme_root_bg]#[$tmux_conf_theme_root_attr]#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _root #{pane_tty} #D)#[inherit]%g")

  tmux_conf_theme_status_right=$(echo "$tmux_conf_theme_status_right" | sed \
    -e "s%#{synchronized}%#[fg=$tmux_conf_theme_synchronized_fg]#[bg=$tmux_conf_theme_synchronized_bg]#[$tmux_conf_theme_synchronized_attr]#{?pane_synchronized,$tmux_conf_theme_synchronized,}%g")

  if [ -n "$tmux_conf_theme_status_right" ]; then
    status_right=$(awk \
                      -v fg_="$tmux_conf_theme_status_right_fg" \
                      -v bg_="$tmux_conf_theme_status_right_bg" \
                      -v attr_="$tmux_conf_theme_status_right_attr" \
                      -v mainsep="$tmux_conf_theme_right_separator_main" \
                      -v subsep="$tmux_conf_theme_right_separator_sub" '
      function subsplit(s,   l, i, a, r)
      {
        l = split(s, a, ",")
        for (i = 1; i <= l; ++i)
        {
          o = split(a[i], _, "(") - 1
          c = split(a[i], _, ")") - 1
          open += o - c
          o_ = split(a[i], _, "{") - 1
          c_ = split(a[i], _, "}") - 1
          open_ += o_ - c_
          o__ = split(a[i], _, "[") - 1
          c__ = split(a[i], _, "]") - 1
          open__ += o__ - c__

          if (i == l)
            r = sprintf("%s%s", r, a[i])
          else if (open || open_ || open__)
            r = sprintf("%s%s,", r, a[i])
          else
            r = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", r, a[i], fg[j], bg[j], attr[j], subsep)
        }

        gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg[j], bg[j], attr[j]), r)
        return r
      }
      BEGIN {
        FS = "|"
        l1 = split(fg_, fg, ",")
        l2 = split(bg_, bg, ",")
        l3 = split(attr_, attr, ",")
        l = l1 < l2 ? (l1 < l3 ? l1 : l3) : (l2 < l3 ? l2 : l3)
      }
      {
        for (i = j = 1; i <= NF; ++i)
        {
          if (open_ || open || open__)
            printf "|%s", subsplit($i)
          else
            printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg[j], (i == 1) ? "default" : bg[j_], mainsep, fg[j], bg[j], attr[j], subsplit($i)

          if (!open && !open_ && !open__)
          {
            j_ = j
            j = j % l + 1
          }
        }
      }' << EOF
$tmux_conf_theme_status_right
EOF
    )
  fi

    # window-status
      tmux_conf_theme_window_status_fg=${tmux_conf_theme_window_status_fg:-'#8a8a8a'} # white
      tmux_conf_theme_window_status_bg=${tmux_conf_theme_window_status_bg:-'#080808'} # dark gray
      tmux_conf_theme_window_status_attr=${tmux_conf_theme_window_status_attr:-'none'}
      tmux_conf_theme_window_status_format=${tmux_conf_theme_window_status_format:-'#I #W'}

      tmux_conf_theme_window_status_current_fg=${tmux_conf_theme_window_status_current_fg:-'#000000'} # black
      tmux_conf_theme_window_status_current_bg=${tmux_conf_theme_window_status_current_bg:-'#00afff'} # light blue
      tmux_conf_theme_window_status_current_attr=${tmux_conf_theme_window_status_current_attr:-'bold'}
      tmux_conf_theme_window_status_current_format=${tmux_conf_theme_window_status_current_format:-'#I #W'}

      if [ x"$(tmux show -g -v status-justify)" = x"right" ]; then
        tmux_conf_theme_window_status_current_format="#[fg=$tmux_conf_theme_window_status_current_bg,bg=$tmux_conf_theme_window_status_bg]$tmux_conf_theme_right_window_separator_main#[fg=$tmux_conf_theme_window_status_current_fg,bg=$tmux_conf_theme_window_status_current_bg,$tmux_conf_theme_window_status_current_attr] $tmux_conf_theme_window_status_current_format #[fg=$tmux_conf_theme_window_status_bg,bg=$tmux_conf_theme_window_status_current_bg,none]$tmux_conf_theme_right_window_separator_main"
      else
        tmux_conf_theme_window_status_current_format="#[fg=$tmux_conf_theme_window_status_bg,bg=$tmux_conf_theme_window_status_current_bg]$tmux_conf_theme_left_window_separator_main#[fg=$tmux_conf_theme_window_status_current_fg,bg=$tmux_conf_theme_window_status_current_bg,$tmux_conf_theme_window_status_current_attr] $tmux_conf_theme_window_status_current_format #[fg=$tmux_conf_theme_window_status_current_bg,bg=$tmux_conf_theme_status_bg,none]$tmux_conf_theme_left_window_separator_main"
      fi

      tmux_conf_theme_window_status_format=$(echo "$tmux_conf_theme_window_status_format" | sed \
        -e 's%#{circled_window_index}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _circled #I)%g' \
        -e 's%#{circled_session_name}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _circled #S)%g' \
        -e 's%#{username}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _username #{pane_tty} false #D)%g' \
        -e 's%#{hostname}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _hostname #{pane_tty} false #D)%g' \
        -e 's%#{username_ssh}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _username #{pane_tty} true #D)%g' \
        -e 's%#{hostname_ssh}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _hostname #{pane_tty} true #D)%g')
      tmux_conf_theme_window_status_current_format=$(echo "$tmux_conf_theme_window_status_current_format" | sed \
        -e 's%#{circled_window_index}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _circled #I)%g' \
        -e 's%#{circled_session_name}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _circled #S)%g' \
        -e 's%#{username}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _username #{pane_tty} false #D)%g' \
        -e 's%#{hostname}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _hostname #{pane_tty} false #D)%g' \
        -e 's%#{username_ssh}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _username #{pane_tty} true #D)%g' \
        -e 's%#{hostname_ssh}%#(cut -c1- $BLADE_TMUX_CONFIG_FILE_DIR/gpakosz-tmux.sh | sh -s _hostname #{pane_tty} true #D)%g')

      tmux  set -wg window-status-style "fg=$tmux_conf_theme_window_status_fg,bg=$tmux_conf_theme_window_status_bg,$tmux_conf_theme_window_status_attr" \;\
            set -wg window-status-format "$(_decode_unicode_escapes "$tmux_conf_theme_window_status_format")" \;\
            set -wg window-status-current-style "fg=$tmux_conf_theme_window_status_current_fg,bg=$tmux_conf_theme_window_status_current_bg,$tmux_conf_theme_window_status_current_attr" \;\
            set -wg window-status-current-format "$(_decode_unicode_escapes "$tmux_conf_theme_window_status_current_format")"

      tmux_conf_theme_window_status_activity_fg=${tmux_conf_theme_window_status_activity_fg:-'default'}
      tmux_conf_theme_window_status_activity_bg=${tmux_conf_theme_window_status_activity_bg:-'default'}
      tmux_conf_theme_window_status_activity_attr=${tmux_conf_theme_window_status_activity_attr:-'underscore'}
      tmux set -wg window-status-activity-style "fg=$tmux_conf_theme_window_status_activity_fg,bg=$tmux_conf_theme_window_status_activity_bg,$tmux_conf_theme_window_status_activity_attr"

      tmux_conf_theme_window_status_bell_fg=${tmux_conf_theme_window_status_bell_fg:-'#ffff00'} # yellow
      tmux_conf_theme_window_status_bell_bg=${tmux_conf_theme_window_status_bell_bg:-'default'}
      tmux_conf_theme_window_status_bell_attr=${tmux_conf_theme_window_status_bell_attr:-'blink,bold'}
      tmux set -wg window-status-bell-style "fg=$tmux_conf_theme_window_status_bell_fg,bg=$tmux_conf_theme_window_status_bell_bg,$tmux_conf_theme_window_status_bell_attr"

      tmux_conf_theme_window_status_last_fg=${tmux_conf_theme_window_status_last_fg:-'#00afff'} # light blue
      tmux_conf_theme_window_status_last_bg=${tmux_conf_theme_window_status_last_bg:-'default'}
      tmux_conf_theme_window_status_last_attr=${tmux_conf_theme_window_status_last_attr:-'none'}
      tmux set -wg window-status-last-style "fg=$tmux_conf_theme_window_status_last_fg,bg=$tmux_conf_theme_window_status_last_bg,$tmux_conf_theme_window_status_last_attr"

      tmux_conf_theme_window_status_separator=${tmux_conf_theme_window_status_separator:-''}
      tmux set -wg window-status-separator "$tmux_conf_theme_window_status_separator"

