// Memory 4 row 3 bit - Raj & Athul
`include "row.v"
`include "decoder_4_2.v"
`include "tri_buff.v"

module mem_4_3(output [2:0] o, input [2:0] i, input [1:0] a, input cs, rd, oe);
	wire cs_rd, not_rd, o_en;
	wire [2:0] d;
	wire [3:0] r;
	wire [2:0] q [3:0];
	
	not(not_rd, rd);
	and(cs_rd, cs, not_rd);
	and(o_en, oe, rd, cs);

	decoder_4_2 a_to_r(.r(r[3:0]), .a(a[1:0]));
	
	row row_4_3 (.q(q[3][2:0]), .d(i[2:0]), .rs(r[3]), .wr(cs_rd));
	row row_4_2 (.q(q[2][2:0]), .d(i[2:0]), .rs(r[2]), .wr(cs_rd));
	row row_4_1 (.q(q[1][2:0]), .d(i[2:0]), .rs(r[1]), .wr(cs_rd));
	row row_4_0 (.q(q[0][2:0]), .d(i[2:0]), .rs(r[0]), .wr(cs_rd));
	
	or q_to_d [2:0] (d[2:0], q[3][2:0], q[2][2:0], q[1][2:0], q[0][2:0]);

	tri_buff d_to_o [2:0] (.y(o[2:0]),.x(d[2:0]),.en(o_en)); 

endmodule 
