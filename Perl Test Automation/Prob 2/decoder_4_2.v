// Decoder 4 to 2 -  Raj & Athul

module decoder_4_2(output [3:0] r, input [1:0] a);
	
	wire [1:0] not_a;
	
	not n [1:0](not_a[1:0], a[1:0]);
	
	and(r[3], not_a[1], not_a[0]);
	and(r[2], not_a[1],     a[0]);
	and(r[1],     a[1], not_a[0]);
	and(r[0],     a[1],     a[0]);
endmodule
