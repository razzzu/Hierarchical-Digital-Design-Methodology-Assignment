#Memory Test Vector Generator - Raj & Athul
#!/usr/bin/perl
# Output Format
#("%03b%02b%01b%01b%01b%03b\n",$i, $a, $cs, $rd, $oe, $o);
sub write{
	#Set the Data Input and Row without cs
	$i = $_[0];
	$a = $_[1];
	$bin = sprintf("%03b%02b000ZZZ\n",$i, $a);	
	#Set CS to 1 to perform the write
	$bin2 = sprintf("%03b%02b100ZZZ\n",$i, $a);	
	return ($bin,$bin2);
}

sub read{
	$a = $_[0];
	$o = $_[1];
	#Since i is a dont care, i=101
	$bin = sprintf("101%02b111%03b\n",$a,$o);	
	return $bin;
}


#Initialize all the inputs and outputs
@mem = (1,2,3,4);
@bin = ();
$file = 'mem_4_3_testvector.txt';

for($a=0;$a<4;$a++){
	push(@bin, &write($mem[$a],$a)); #2 Line
	push(@bin, &read($a,$mem[$a]));	 #1 Line
}

for($k=0;$k<2;$k++){
	for($a=0;$a<4;$a++){	
		push(@bin, &read($a,$mem[$a])); #1 Line
		$mem[$a] = 7 - $mem[$a]; #Inverting the bit pattern i.e. 101 -> 010	
		push(@bin, &write($mem[$a],$a)); #2 Line
		push(@bin, &read($a,$mem[$a]));	#1 Line
	}
}

open(FILE, ">$file");
print FILE @bin;
$bin_len = @bin;
close(FILE);
print "$bin_len test vector written to $file \nformat: i, a, cs, rd, oe, o\n";

