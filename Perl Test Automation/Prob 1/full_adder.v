// Full Adder - Raj & Athul
`include "half_adder.v"

module full_adder(output sum, cout, input cin, a, b);

	wire s0, c0, c1;
	
	half_adder ha1(.c(c0), .s(s0), .a(a), .b(b));
	half_adder ha2(.c(c1), .s(sum), .a(s0), .b(cin));
	or(cout, c0, c1);

endmodule
