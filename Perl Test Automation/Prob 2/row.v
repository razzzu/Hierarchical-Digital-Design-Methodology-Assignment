// Memeory Row - Raj & Athul
`include "d_ff.v"

module row(output [2:0] q, input [2:0] d, input rs, wr);
	wire ck;
	wire [2:0] r;

	and(ck,rs,wr);	
	d_ff dr [2:0] (.q(r[2:0]),.d(d[2:0]),.ck(ck));
	and out[2:0] (q[2:0], r[2:0], rs);

endmodule

//Test Module - 
/*
module row_test();
	reg [2:0] d;
	reg rs, oe;
	wire [2:0] q;

	integer k;

	row row1 (.q(q), .d(d), .rs(rs), .oe(oe));

	initial 
		$monitor("q:%b d:%b rs:%b oe:%b", q, d, rs, oe);

	initial begin
		d=3'b101;
		for (k=0; k=10; k=k+1) begin
			d = ~d;
			#1;
			rs = 1;
			oe = 1;
			#1;
			rs = 0;
			oe =
		end
	end
module
*/
