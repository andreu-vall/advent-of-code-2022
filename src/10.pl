$register = 1;
$cycle = 1;
$answer = 0;
@check = (20, 60, 100, 140, 180, 220);

sub do_check {
    $cycle = $_[0];
    $register = $_[1];
    $answer = $_[2];
    if ($cycle ~~ @check) {
        $answer = $answer + $cycle * $register;
    }
    return $answer;
}

sub part2 {
    $crt_pos = ($_[0] - 1) % 40;
    $sprite_mid = $_[1];
    print abs($crt_pos - $sprite_mid) <= 1? "#" : ".";
    if ($crt_pos == 39) {
        print "\n";
    }
}

while ($line = <>) {
    part2($cycle, $register);
    $cycle++;
    $answer = do_check($cycle, $register, $answer);
    if (index($line, "noop") == -1) {
        part2($cycle, $register);
        $cycle++; # Ok I hate Perl why doesn't it crask if variable 'cicle' doesn't exist?????????????
        $numb = int(substr($line, 5));
        $register = $register + $numb;
        $answer = do_check($cycle, $register, $answer);
    }
}

print $answer, "\n";
