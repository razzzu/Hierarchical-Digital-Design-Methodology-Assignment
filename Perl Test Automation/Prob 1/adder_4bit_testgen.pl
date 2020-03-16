#!/usr/bin/perl


$test_file = "adder_4bit_test.txt";

$a = 0;
$b = 0;
$c_in = 0;

open(TEST, ">$test_file");

for ($a = 0; $a < 16; $a++){
	for ($b = 0; $b < 16; $b++){
		for ($c_in = 0; $c_in < 2; $c_in++){
			$sum = $a + $b + $c_in;
			printf TEST "%04b%04b%01b%05b\n",$a, $b, $c_in, $sum;
		}
	}
}

close(TEST);

