#!/bin/bash
source "$BLADE_TMUX_CONFIG_FILE_DIR/theme.conf.tmux.sh"

# ================================================================================

# function provided by 'gpakosz-tmux.sh'
_decode_unicode_escapes() {
  printf '%s' "$*" | perl -CS -pe 's/(\\u([0-9A-Fa-f]{1,4})|\\U([0-9A-Fa-f]{1,8}))/chr(hex($2.$3))/eg' 2>/dev/null
}

_is_enabled() {
  ( ([ x"$1" = x"enabled" ] || [ x"$1" = x"true" ] || [ x"$1" = x"yes" ] || [ x"$1" = x"1" ]) && return 0 ) || return 1
}

_tty_info() {
  tty="${1##/dev/}"
  uname -s | grep -q "CYGWIN" && cygwin=true

  if [ x"$cygwin" = x"true" ]; then
    ps -af | tail -n +2 | awk -v tty="$tty" '
      ((/ssh/ && !/-W/) || !/ssh/) && $4 == tty {
        user[$2] = $1; parent[$2] = $3; child[$3] = $2
      }
      END {
        for (i in user)
        {
          if (!(i in child) && parent[i] != 1)
          {
            file = "/proc/" i "/cmdline"; getline command < file; close(file)
            gsub(/\0/, " ", command)
            print i, user[i], command
            exit
          }
        }
      }
    '
  else
    ps -t "$tty" -o user=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -o pid= -o ppid= -o command= | awk '
      NR > 1 && ((/ssh/ && !/-W/) || !/ssh/) {
        user[$2] = $1; parent[$2] = $3; child[$3] = $2; for (i = 4 ; i <= NF; ++i) command[$2] = i > 4 ? command[$2] FS $i : $i
      }
      END {
        for (i in parent)
        {
          if (!(i in child) && parent[i] != 1)
          {
            print i, user[i], command[i]
            exit
          }
        }
      }
    '
  fi
}

_ssh_or_mosh_args() {
  args=$(printf '%s' "$1" | awk '/ssh/ && !/vagrant ssh/ && !/autossh/ && !/-W/ { $1=""; print $0; exit }')
  if [ -z "$args" ]; then
    args=$(printf '%s' "$1" | grep 'mosh-client' | sed -E -e 's/.*mosh-client -# (.*)\|.*$/\1/' -e 's/-[^ ]*//g' -e 's/\d:\d//g')
  fi

 printf '%s' "$args"
}

_username() {
  tty=${1:-$(tmux display -p '#{pane_tty}')}
  ssh_only=$2

  tty_info=$(_tty_info "$tty")
  command=$(printf '%s' "$tty_info" | cut -d' ' -f3-)

  ssh_or_mosh_args=$(_ssh_or_mosh_args "$command")
  if [ -n "$ssh_or_mosh_args" ]; then
    # shellcheck disable=SC2086
    username=$(ssh -G $ssh_or_mosh_args 2>/dev/null | awk 'NR > 2 { exit } ; /^user / { print $2 }')
    # shellcheck disable=SC2086
    [ -z "$username" ] && username=$(ssh -T -o ControlPath=none -o ProxyCommand="sh -c 'echo %%username%% %r >&2'" $ssh_or_mosh_args 2>&1 | awk '/^%username% / { print $2; exit }')
  else
    if ! _is_enabled "$ssh_only"; then
      username=$(printf '%s' "$tty_info" | cut -d' ' -f2)
    fi
  fi

  printf '%s' "$username"
}

_hostname() {
  tty=${1:-$(tmux display -p '#{pane_tty}')}
  ssh_only=$2

  tty_info=$(_tty_info "$tty")
  command=$(printf '%s' "$tty_info" | cut -d' ' -f3-)

  ssh_or_mosh_args=$(_ssh_or_mosh_args "$command")
  if [ -n "$ssh_or_mosh_args" ]; then
    # shellcheck disable=SC2086
    hostname=$(ssh -G $ssh_or_mosh_args 2>/dev/null | awk 'NR > 2 { exit } ; /^hostname / { print $2 }')
    # shellcheck disable=SC2086
    [ -z "$hostname" ] && hostname=$(ssh -T -o ControlPath=none -o ProxyCommand="sh -c 'echo %%hostname%% %h >&2'" $ssh_or_mosh_args 2>&1 | awk '/^%hostname% / { print $2; exit }')
    #shellcheck disable=SC1004
    hostname=$(echo "$hostname" | awk '\
    { \
      if ($1~/^[0-9.:]+$/) \
        print $1; \
      else \
        split($1, a, ".") ; print a[1] \
    }')
  else
    if ! _is_enabled "$ssh_only"; then
      hostname=$(command hostname -s)
    fi
  fi

  printf '%s' "$hostname"
}

_root() {
  tty=${1:-$(tmux display -p '#{pane_tty}')}
  username=$(_username "$tty" false)

  if [ x"$username" = x"root" ]; then
    tmux show -gqv '@root'
  else
    echo ""
  fi
}


# ================================================================================

plug_username=$(_username)
plug_hostname=$(_hostname)

# decode character
theme_left_sep_main=$(_decode_unicode_escapes "$theme_left_sep_main")
theme_left_sep_sub=$(_decode_unicode_escapes "$theme_left_sep_sub")
theme_right_sep_main=$(_decode_unicode_escapes "$theme_right_sep_main")
theme_right_sep_sub=$(_decode_unicode_escapes "$theme_right_sep_sub")

# function provided by Blade-Tmux

set_status_bar() {

perl << EOF

# PART I: VARABL DEFINE
# general
    \$theme_status_bg='$theme_status_bg';

# left related
    \$theme_left_sep_main='$theme_left_sep_main';
    \$theme_left_sep_sub='$theme_left_sep_sub';

    \$theme_status_left='$theme_status_left';
    \$theme_status_left_fg='$theme_status_left_fg';
    \$theme_status_left_bg='$theme_status_left_bg';
    \$theme_status_left_attr='$theme_status_left_attr';

# right related
    \$theme_status_bg='$theme_status_bg';

    \$theme_right_sep_main='$theme_right_sep_main';
    \$theme_right_sep_sub='$theme_right_sep_sub';

    \$theme_status_right='$theme_status_right';
    \$theme_status_right_fg='$theme_status_right_fg';
    \$theme_status_right_bg='$theme_status_right_bg';
    \$theme_status_right_attr='$theme_status_right_attr';
# plugs related
    # username
        \$plug_username='$plug_username';

    # host name
        \$plug_hostname='$plug_hostname';

    # pairing indicator
        \$plug_pairing='$plug_pairing';
        \$plug_pairing_fg='$plug_pairing_fg';
        \$plug_pairing_bg='$plug_pairing_bg';
        \$plug_pairing_attr='$plug_pairing_attr';

    # prefix indicator
        \$plug_prefix='$plug_prefix';
        \$plug_prefix_fg='$plug_prefix_fg';
        \$plug_prefix_fg='$plug_prefix_fg';
        \$plug_prefix_bg='$plug_prefix_bg';
        \$plug_prefix_attr='$plug_prefix_attr';

    # root indicator
        \$plug_root='$plug_root';
        \$plug_root_fg='$plug_root_fg';
        \$plug_root_bg='$plug_root_bg';
        \$plug_root_attr='$plug_root_attr';

    # synchronized indicator
        \$plug_synchronized='$plug_synchronized';
        \$plug_synchronized_fg='$plug_synchronized_fg';
        \$plug_synchronized_bg='$plug_synchronized_bg';
        \$plug_synchronized_attr='$plug_synchronized_attr';

# PART II: LEFT
# process
## tranfer string into array
@left_content = split('\|', \$theme_status_left);
@left_fg = split(',', \$theme_status_left_fg);
@left_bg = split(',', \$theme_status_left_bg);
@left_attr_oringe = split(',', \$theme_status_left_attr);

## get srting of style
### get list of sep's color
#### add the background colour of status bar in the end
@left_sep_pallet = @left_bg;
push(@left_sep_pallet, \$theme_status_bg);

#### generate the list
for (\$i = 0; \$i <= \$#left_sep_pallet; \$i++){
    \$left_sep_colour[\$i] = 'fg='.\$left_sep_pallet[\$i].',bg='.\$left_sep_pallet[\$i+1].',';
}


### get the list of content's colour
for (\$i = 0; \$i <= \$#left_fg; \$i++){
    \$left_colour[\$i] = "fg=".@left_fg[\$i].",bg=".@left_bg[\$i].",";
}

### get string of attr
for (\$i = 0; \$i < (2 * \$#left_attr_oringe + 1); \$i = \$i + 2){
    \$left_attr[\$i] = \$left_attr_oringe[i];
    \$left_attr[\$i + 1] = 'none';
}

### get list of style
for (\$i = 0; \$i <= (2 * (\$#left_fg + 1) - 1); \$i = \$i + 2){
    \$left_style[\$i] = "#[".\$left_colour[\$i/2].\$left_attr[\$i]."]";
    \$left_style[\$i + 1] = "#[".\$left_sep_colour[\$i/2].\$left_attr[\$i + 1]."]";
}

## get list of content
### insert the sub seperator in the position of ','
for (\$i = 0; \$i <= \$#left_content; \$i++){
    if (\$left_content[\$i] =~ /,(?![^{}]*+\})/){
        \$left_content[\$i] =~ s/,(?![^{}]*+\})/\$theme_left_sep_sub/g;
    }
}

### the the full string of format
\$left_format = '';
for (\$i = 0; \$i <= (2*(\$#left_content+1) - 1); \$i = \$i + 2){
    \$left_format = \$left_format . \$left_style[\$i] . \$left_content[\$i/2] . \$left_style[\$i + 1] . \$theme_left_sep_main;
}

### add some interval between left status and window status
\$left_format = \$left_format . "   ";

# PART III: RIGHT

# process
## tranfer string into array
@right_content = split('\|', \$theme_status_right);
@right_fg = split(',', \$theme_status_right_fg);
@right_bg = split(',', \$theme_status_right_bg);
@right_attr_oringe = split(',', \$theme_status_right_attr);

## get srting of style
### get list of sep's color
#### add the background colour of status bar in the end
@right_sep_pallet = @right_bg;
unshift(@right_sep_pallet, \$theme_status_bg);

#### generate the list
for (\$i = 0; \$i <= \$#right_sep_pallet; \$i++){
    \$right_sep_colour[\$i] = 'fg='.\$right_sep_pallet[\$i + 1].',bg='.\$right_sep_pallet[\$i].',';
}


### get the list of content's colour
for (\$i = 0; \$i <= \$#right_fg; \$i++){
    \$right_colour[\$i] = "fg=".@right_fg[\$i].",bg=".@right_bg[\$i].",";
}

### get string of attr
for (\$i = 0; \$i < (2 * \$#right_attr_oringe + 1); \$i = \$i + 2){
    \$right_attr[\$i] = 'none';
    \$right_attr[\$i + 1] = \$right_attr_oringe[\$i/2];
}

### get list of style
for (\$i = 0; \$i <= (2 * (\$#right_fg + 1) - 1); \$i = \$i + 2){
    \$right_style[\$i] = "#[".\$right_sep_colour[\$i/2].\$right_attr[\$i]."]";
    \$right_style[\$i + 1] = "#[".\$right_colour[\$i/2].\$right_attr[\$i + 1]."]";
}

## get list of content
### insert the sub seperator in the position of ','
for (\$i = 0; \$i <= \$#right_content; \$i++){
    if (\$right_content[\$i] =~ /,(?![^{}]*+\})/){
        \$right_content[\$i] =~ s/,(?![^{}]*+\})/\$theme_right_sep_sub/g;
    }
}

### the the full string of format
\$right_format = '';
for (\$i = 0; \$i <= (2*(\$#right_content+1) - 1); \$i = \$i + 2){
    \$right_format = \$right_format . \$right_style[\$i] . \$theme_right_sep_main . \$right_style[\$i + 1] . \$right_content[\$i/2];
};

# PART IV: transfer plugs
# transfer plugs
sub substitute_plug{
    my \$inString = \$_[0];

    \$inString =~ s/#\{plug_pairing\}/#[fg=\$plug_pairing_fg,bg=\$plug_pairing_bg,\$plug_pairing_attr]#{?session_many_attached,\$plug_pairing,}/g;

    # prefix
        \$inString =~ s/#\{plug_prefix\}/#[fg=\$plug_prefix_fg,bg=\$plug_prefix_bg,\$plug_prefix_attr]#{?client_prefix,\$plug_prefix,}/g;

    # synchronized
        \$inString =~ s/#\{plug_synchronized\}/#[fg=\$plug_synchronized_fg,bg=\$plug_synchronized_bg,\$plug_synchronized_attr]#{?pane_synchronized,\$plug_synchronized,}/g;

    # root
        \$inString =~ s/#\{plug_root\}/#[fg=\$plug_root_fg,bg=\$plug_root_bg,\$plug_root_attr]\$plug_root/g;

    # hostname
        \$inString =~ s/#\{plug_hostname\}/\$plug_hostname/g;

    # username
        \$inString =~ s/#\{plug_username\}/\$plug_username/g;

    return \$inString;
}

# PART V: set status
\$left_format = "'".&substitute_plug(\$left_format)."'";
system("tmux set -g status-left \$left_format");

\$right_format = "'".&substitute_plug(\$right_format)."'";
system("tmux set -g status-right \$right_format");
EOF
}

