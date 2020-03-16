// Memory 4 row of 3bit Test bench - Raj & Athul
`include "mem_4_3.v"

module mem_4_3_testbench();

	reg [2:0] i;
	reg [1:0] a;
	reg cs, rd, oe;
	reg [10:0] test_vect [0:43];

	wire [2:0] o;

	integer k;
	integer fail = 0;

	mem_4_3 mem (.o(o), .i(i), .a(a), .rd(rd), .cs(cs), .oe(oe));	
	
	initial 
		$vcdpluson;

	initial begin
		$readmemb("mem_4_3_testvector.txt",test_vect);

		for(k=0; k<44; k=k+1) begin
			{i,a,cs,rd,oe} = test_vect[k][10:3];
			#10;
			if ( o === test_vect[k][2:0])
				$display("%b %b %b %b %b %b %b 0", i, a, cs, rd, oe, o, test_vect[k]);
			else begin
				$display("%b %b %b %b %b %b %b 1", i, a, cs, rd, oe, o, test_vect[k]);
				fail = 1;
			end
		end

		$display("Fail = %d", fail);
		$finish;
	end

endmodule
