my $filePath = 'advendofcode2023\\day05\\input.txt';
open (my $file, '<', $filePath) or die "not find file";

my $fileContent = do {
    local $/;
    <$file>;
};
close($file);

my ($seeds, $maps) = split(/\n\n/, $fileContent, 2);
$seeds =~ s/^seeds: //;

my @seeds = rangeToSeeds($seeds); #map { int($_) } split /\s+/, $seeds;
my @blocks = split /\n\n/, $maps;
my @maps;

foreach my $block (@blocks) {
    my ($nothing, $rules) = split(/\n/, $block, 2);
    my @map;
    foreach my $line (split /\n/, $rules) {
        my @nums = split /\s+/, $line;
        my $destination = $nums[0];
        my $source = $nums[1];
        my $range = $nums[2];
        push @map, { destination => $destination, source => $source, range => $range };
    }

    push @maps, \@map;  
}
my $min = 999999999;

for my $seed (@seeds) {
    my $curr = $seed;

    for my $map (@maps) {
        foreach $rule (@$map) {
            my $applies = ($curr >= $rule->{source}) && ($curr <= $rule->{source} + $rule->{range});
            
            if ($applies) {
                $curr = $rule->{destination} + $curr - $rule->{source};
                #print"$curr\n";
                last;
            }
        }
    }
    $min = $min < $curr ? $min : $curr;
}

print "Part1: $min\n";

sub rangeToSeeds {
    my ($ranges) = @_;
    my @expandedSeeds;

    while ($ranges =~ /(\d+) (\d+)/g) {
        push @expandedSeeds, $1..$2;
    }

    return @expandedSeeds;
}

        
