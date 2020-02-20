#!usr/bin/perl
use Encode;

=head1 stucture of the string
the out put should be:
the structure of the output:
    - [style] <---> [fg-colour, bg-colour, attr]
    - format <---> [style_1][content_1][style_2][main_sep_1][style_3][content_2]...
=cut

# variable
$theme_status_bg='#39393a';

$theme_right_sep_main='\ue0be';
$theme_right_sep_sub='\ue0bf';

$theme_status_right='#{plug_prefix}#{plug_pairing}#{plug_synchronized} , %R , %a %b %d | #{username}#{root} | #{hostname} ';
$theme_status_right_fg='#e4e4e4,#e4e4e4,#39393a';
$theme_status_right_bg='#49769e,#d70000,#e4e4e4';
$theme_status_right_attr='none,none,bold';

# process
## tranfer string into array
@right_content = split('\|', $theme_status_right);
@right_fg = split(',', $theme_status_right_fg);
@right_bg = split(',', $theme_status_right_bg);
@right_attr_oringe = split(',', $theme_status_right_attr);

## get srting of style
### get list of sep's color
#### add the background colour of status bar in the end
@right_sep_pallet = @right_bg;
unshift(@right_sep_pallet, $theme_status_bg);

#### generate the list
for ($i = 0; $i <= $#right_sep_pallet; $i++){
    $right_sep_colour[$i] = 'bg='.$right_sep_pallet[$i].',fg='.$right_sep_pallet[$i+1].',';
}

### get the list of content's colour
for ($i = 0; $i <= $#right_fg; $i++){
    $right_colour[$i] = "fg=".@right_fg[$i].",bg=".@right_bg[$i].",";
}

### get string of attr
for ($i = 0; $i < (2 * $#right_attr_oringe + 1); $i = $i + 2){
    $right_attr[$i] = 'none';
    $right_attr[$i + 1] = $right_attr_oringe[i];
}

### get list of style
for ($i = 0; $i <= (2 * ($#right_fg + 1) - 1); $i = $i + 2){
    $right_style[$i] = "#[".$right_sep_colour[$i/2].$right_attr[$i]."]";
    $right_style[$i + 1] = "#[".$right_colour[$i/2].$right_attr[$i + 1]."]";
}

## get list of content
### insert the sub seperator in the position of ','
for ($i = 0; $i <= $#right_content; $i++){
    if ($right_content[$i] =~ /,(?![^{}]*+\})/){
        $right_content[$i] =~ s/,(?![^{}]*+\})/$theme_right_sep_sub/g;
    }
}

### the the full string of format
$right_format = '';
for ($i = 0; $i <= (2*($#right_content+1) - 1); $i = $i + 2){
    $right_format = $right_format . $right_style[$i + 1] . $theme_right_sep_main . $right_style[$i] . $right_content[$i/2];
}

print $right_format."\n";
