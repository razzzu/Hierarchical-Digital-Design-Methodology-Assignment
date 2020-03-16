// Half Adder - Raj & Athul

module half_adder(output c, output s, input a, input b);
	
	xor(s, a, b);
	and(c, a, b);

endmodule
