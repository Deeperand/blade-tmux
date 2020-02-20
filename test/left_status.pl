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

$theme_left_sep_main='\ue0b4';
$theme_left_sep_sub='\ue0b5';
$theme_right_sep_main='\ue0be';
$theme_right_sep_sub='\ue0bf';

$theme_status_left=' #{?pane_mode,COPY,NORM} | ❐ #S , ● #I ○ #P | #{pane_current_path} ';
$theme_status_left_fg='#e4e4e4,#e4e4e4,#47474a'; # 对于较亮的背景色, 为了维持主管上的亮度一致, 应适当降低文字与背景的对比度, 故这里采用了比 #39393a 更浅一点的颜色
$theme_status_left_bg='#ff00af,#6bd16e,#ffff00';
$theme_status_left_attr='bold,bold,bold';

# process
## tranfer string into array
@left_content = split('\|', $theme_status_left);
@left_fg = split(',', $theme_status_left_fg);
@left_bg = split(',', $theme_status_left_bg);
@left_attr_oringe = split(',', $theme_status_left_attr);

## get srting of style
### get list of sep's color
#### add the background colour of status bar in the end
@left_sep_pallet = @left_bg;
push(@left_sep_pallet, $theme_status_bg);

#### generate the list
for ($i = 0; $i <= $#left_sep_pallet; $i++){
    $left_sep_colour[$i] = 'fg='.$left_sep_pallet[$i].',bg='.$left_sep_pallet[$i+1].',';
}

### get the list of content's colour
for ($i = 0; $i <= $#left_fg; $i++){
    $left_colour[$i] = "fg=".@left_fg[$i].",bg=".@left_bg[$i].",";
}

### get string of attr
for ($i = 0; $i < (2 * $#left_attr_oringe + 1); $i = $i + 2){
    $left_attr[$i] = $left_attr_oringe[i];
    $left_attr[$i + 1] = 'none';
}

### get list of style
for ($i = 0; $i <= (2 * ($#left_fg + 1) - 1); $i = $i + 2){
    $left_style[$i] = "#[".$left_colour[$i/2].$left_attr[$i]."]";
    $left_style[$i + 1] = "#[".$left_sep_colour[$i/2].$left_attr[$i + 1]."]";
}

## get list of content
### insert the sub seperator in the position of ','
for ($i = 0; $i <= $#left_content; $i++){
    if ($left_content[$i] =~ /,(?![^{}]*+\})/){
        $left_content[$i] =~ s/,(?![^{}]*+\})/$theme_left_sep_sub/g;
    }
}

### the the full string of format
$left_format = '';
for ($i = 0; $i <= (2*($#left_content+1) - 1); $i = $i + 2){
    $left_format = $left_format . $left_style[$i] . $left_content[$i/2] . $left_style[$i + 1] . $theme_left_sep_main;
}

##

print $left_format."\n";
