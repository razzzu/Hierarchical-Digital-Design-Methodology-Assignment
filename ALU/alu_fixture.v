// ALU Fixture -  Raj Patel
`include "alu.v"

module alu_fixture();
	parameter w = 32;
	parameter d = 10;
	reg signed [(w-1):0] a, b;
	reg [1:0] ctrl;
	
	wire [(w-1):0] r;
	wire o, n, z;

	alu #(.W(w)) dut (.R(r), .O(o), .N(n), .Z(z), .A(a), .B(b), .CTRL(ctrl));
	
	initial
		$vcdpluson;

	initial begin
		$display("       A        B CTRL        R O N Z");
		$display("-------------------------------------");
		$monitor("%h %h   %b %h %b %b %b", a, b, ctrl, r, o, n, z);
	end

	initial begin


		$display("----------------Addition-------------");
		ctrl=2'b00;
		arithmetic_vector();

		$display("----------------Subtraction----------");
		ctrl=2'b01;
		arithmetic_vector();

		$display("----------------Bitwise AND----------");
		ctrl=2'b10;
		bitwise_vector();   
		
		$display("----------------Bitwise OR-----------");
		ctrl=2'b11;
		bitwise_vector();   
	
		$finish;
	end

	task arithmetic_vector;
	begin
		a=32'hfffff021; b=32'hffffffff;	#d;
		a=32'hffffffff; b=32'h000f00ab;	#d;
		a=32'h76767676; b=32'h23144321;	#d;
		a=32'habbbbbbb; b=32'hefabcd78;	#d;
		a=32'hffffffff; b=32'h00000001;	#d;
		a=32'hffffffff; b=32'hffffffff;	#d;
		a=32'hfffffffc; b=32'hffffffcc;	#d;
		a=32'hffff0000; b=32'h00005688;	#d;
		a=32'h06781234; b=32'h00076998;	#d;		
	end
	endtask

	task bitwise_vector;
	begin	
		a=32'hffffffff; b=32'h0a0ab0b0;	#d;
		a=32'habcd4545; b=32'h12383588;	#d;
		a=32'hf0f0ffff; b=32'hcfcfcfcf;	#d;
		a=32'h00000002; b=32'h22233444;	#d;
	end
	endtask

endmodule
