//ALU Testbench - Raj & Athul
`include "alu.v"

module alu_fixture;
reg signed [3:0] I0;
reg signed [3:0] I1;
reg [1:0] C;
wire signed [3:0] alu_out;
reg [16:0] expected_out;     // vector to check for the generated output is same as expected output.
reg [13:0] array [0:255];   // array with 26 rows and 256 columns representing the entire combination.
reg [25:0] temp;
reg pass;
integer i;
alu dut(.I0(I0),.I1(I1),.C(C),.alu_out(alu_out));
integer fail = 0;
initial
	begin
		$display(" Read the input file::");
		$readmemb("alu_test_vector.txt",array);
		$display("Data::");
		for( i=0;i<256;i=i+1)
		begin
			{I0,I1,C} = array[i][13:4];
			#1;

			if (alu_out === array[i][3:0])
				$display("%b %b %b %b 0", I0, I1, C, alu_out);
			else
				$display("%b %b %b %b 1", I0, I1, C, alu_out);

		end
		$display("Fail = %d",fail);
		$finish;
	end
endmodule
