use 5.010;
use strict;
use warnings;

use Bio::SeqIO;

my $fcds=$ARGV[0];
my $step=$ARGV[1];
my $outfile=$ARGV[2];
my $offset=$ARGV[3];
print "open $fcds\n";

my $in  = Bio::SeqIO-> new ( -file   => $fcds,
                              -format => 'fasta' );

if(open(my $out, '>', $outfile)){
   while (my $record = $in->next_seq()) {
      my $id2 = $record->id();
      my $seq=$record->seq;
      print "found ".length($seq)."\n";
      my $begin=$offset;
      if(length($seq)>$step){
         my $cpt=1;
         while (($begin+$step) <= length($seq)){
            my $temp=substr($seq, $begin, $step);
            $begin=$begin+$step;
            print ">".$id2."_$cpt\n";
            print "$temp\n";
            print $out ">".$id2."_$cpt\n";
            print $out "$temp\n";
            $cpt++;
            }
       }
}
}else{die "outfile not found";}
	
