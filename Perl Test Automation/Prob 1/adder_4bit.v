// 4-bit Adder - Raj & Athul
`include "full_adder.v"
module adder_4bit(output [3:0] sum, 
                  output carry_out, 
                  input [3:0] a, b, 
                  input carry_in);
	
	wire [4:0] c;
	assign c[0] = carry_in;
	assign carry_out = c[4];

	full_adder fa [3:0](.cout(c[4:1]), 
						.sum(sum[3:0]), 
						.a(a[3:0]), 
						.b(b[3:0]), 
						.cin(c[3:0])); 

endmodule
