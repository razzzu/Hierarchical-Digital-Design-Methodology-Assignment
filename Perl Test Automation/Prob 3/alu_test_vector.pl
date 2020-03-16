#! /usr/bin/perl
#ALU Test Generator - Raj & Athul

$file = 'alu_test_vector.txt';		# creating a file with ALU test data and expected output
open(alu_fp, ">$file");				# opening the file for output
print "I0 \t I1 \t C \t ADD \t AND \t SLL \t SRL \n ";
for ($i=0;$i<16;$i=$i+1)			# controls I0 iteration
{
	for($j=0;$j<16;$j=$j+1)			#controls I1 iteration
	{
     $o=0;
     for($c=0;$c<4;$c++){
       if ($c==0){
         #add
         $o=$i+$j;
       }elsif($c==1){
         #and
         $o=$i&$j;
       }elsif($c==2){
         #sll
         $o=$i<<1;
       }elsif($c==3){
         #srl
         $o=$i>>1;
       }

       if($o>=16){
         $o=$o%16;
       }

       printf alu_fp "%04b%04b%02b%04b\n", $i, $j, $c, $o;

     }

	}
}
@lines = <alu_fp>;
close(alu_fp);
print @lines;
