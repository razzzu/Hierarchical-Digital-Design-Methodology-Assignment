// 4bit adder testbench - Raj & Athul
`include "adder_4bit.v"

module adder_4bit_testbench();
	reg [3:0] a,b;
	reg carry_in;
	reg [13:0] mem [0:511];
	
	wire [3:0] sum;
	wire carry_out;
	
	integer k;
	integer fail=0;

	adder_4bit(.sum(sum[3:0]), 
				.carry_out(carry_out),
				.a(a[3:0]),
				.b(b[3:0]),
				.carry_in(carry_in));
			
	initial begin
		$readmemb("adder_4bit_test.txt", mem);

		for(k=0; k<512; k=k+1) begin
			{a,b,carry_in} = mem[k][13:5];
			#10;
			if ({carry_out,sum} === mem[k][4:0]) begin
				$display("%b %b %b %b %b 0", a, b, carry_in, carry_out, sum);
			end
			else begin
				$display("%b %b %b %b %b 1", a, b, carry_in, carry_out, sum);
				fail = 1;
			end
		end
		
		$display("fail: %d", fail);
		$finish;
	end
endmodule
