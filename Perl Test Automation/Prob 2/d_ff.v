// D-Flip Flop - Raj & Athul

module d_ff(output reg q, input d, ck);

	always @ (posedge ck)
		q<=d;

endmodule

//Test Module - Pass
/*
module d_ff_test();

	reg ck, d;
	wire q;
	
	integer k;

	d_ff myff(.q(q), .d(d), .ck(ck));

	initial
		$monitor("ck:%b d:%b q:%b", ck, d, q);

	initial begin
		ck = 0;
		d = 0;
		for (k=0; k<10; k=k+1) begin
			d = ~d;
			#1;
			ck = 1;
			#1;
			ck = 0;
		end
	end

endmodule
*/
