$test_string = '#[fg=#e4e4e4,bg=#49769e,none]\ue0be#[fg=#39393a,bg=#49769e,none]#{plug_prefix}#{plug_pairing}#{plug_synchronized} \ue0bf %R \ue0bf %a %b %d #[fg=#e4e4e4,bg=#d70000,none]\ue0be#[fg=#49769e,bg=#d70000,none] #{plug_username}#{root} #[fg=#39393a,bg=#e4e4e4,none]\ue0be#[fg=#d70000,bg=#e4e4e4,none] #{hostname}';

    # pairing indicator
        $plug_pairing='👓 ';          # U+1F453
        $plug_pairing_fg='none';
        $plug_pairing_bg='none';
        $plug_pairing_attr='none';

    # prefix indicator;
        $plug_prefix='⌨ ';            # U+2328
        $plug_prefix_fg='none';
        $plug_prefix_fg='none';
        $plug_prefix_bg='none';
        $plug_prefix_attr='none';

    # root indicator;
        $plug_root='!';
        $plug_root_fg='none';
        $plug_root_bg='none';
        $plug_root_attr='bold,blink';

    # synchronized indicator;
        $plug_synchronized='🔒';     # U+1F512
        $plug_synchronized_fg='none';
        $plug_synchronized_bg='none';
        $plug_synchronized_attr='none';

        $plug_username = 'he';
        $plug_hostname = 'daomeixiongdeMacBook';

sub subs_plugs{
    my $inputString = @_[0];
    if ($inputString =~ /#\{plug_pairing\}/){
        $inputString =~ s/#\{plug_pairing\}/[fg=$plug_pairing_fg,bg=$plug_pairing_bg,$plug_pairing_attr]#{?session_many_attached,$plug_pairing,}/g;
    }

    if ($inputString =~ /#\{plug_prefix\}/){
        $inputString =~ s/#\{plug_prefix\}/[fg=$plug_prefix_fg,bg=$plug_prefix_bg,$plug_prefix_attr]#{?client_prefix,$plug_prefix,}/g;
    }

    if ($inputString =~ /#\{plug_synchronized\}/){
        $inputString =~ s/#\{plug_synchronized\}/[fg=$plug_synchronized_fg,bg=$plug_synchronized_bg,$plug_synchronized_attr]{?pane_synchronized,$plug_synchronized,}/g;
    }

    if ($inputString =~ /#\{plug_root\}/){
        $inputString =~ s/#\{plug_root\}/[fg=$plug_root_fg,bg=$plug_root_bg,$plug_root_attr]$plug_root/g;
    }

    if ($inputString =~ /#\{plug_hostname\}/){
        $inputString =~ s/#\{plug_hostname\}/$plug_hostname/g;
    }

    if ($inputString =~ /#\{plug_username\}/){
        $inputString =~ s/#\{plug_username\}/$plug_username/g;
    }
    return $inputString;
}

print subs_plugs($test_string)
