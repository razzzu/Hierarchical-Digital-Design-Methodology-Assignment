// ALU - Raj & Athul
module alu ( input signed[3:0]I0,I1, input [1:0]C, output reg [3:0]alu_out);

always@(*)
begin
	case(C)
	2'b00:
	alu_out = I0+I1;	// Performs Addition
	2'b01:
	alu_out = I0&I1;	// Performs Bit-wise AND
	2'b10:
	alu_out = I0<<1;	// Performs Logical Left Shift
	2'b11:
	alu_out = I0>>1;	// Performs Logical Right Shift
	endcase
end

endmodule
