sub testfunction{
    my $temp = $_[0];
    return $temp;
}

$a = "HELLO WORLD";

print &testfunction($a);
