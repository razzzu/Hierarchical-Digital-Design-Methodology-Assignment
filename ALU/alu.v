//ALU - N-bit, Raj Patel

module alu #(parameter W = 16) (	output reg signed [(W-1):0] R, 
									output reg O, N, Z, 
									input signed [(W-1):0] A, B,
									input [1:0] CTRL );
	always@(*) begin
		case(CTRL)
			2'b00: begin
				//Addition
				R = A + B;

				//Default value of Overflow And Sign bit
				O=0;
				N=R[W-1];

				// If the oprand have the same sign bit but the result has
				// a different sign bit then overflow occurs and the sign of
				// the result is the same as oprands
				if((A[W-1] == B[W-1]) && (B[W-1] != R[W-1])) begin
					O=1;
					N=A[W-1];
				end

			end
			2'b01: begin
				//Subtract
				R = A - B;

				O=0;
				N=R[W-1];

				// If the sign of oprands are different overflow occurs when
				// the sign of result is same as sign of subtrahend (B)
				if((A[W-1] != B[W-1]) && (B[W-1] == R[W-1])) begin
					O=1;
					N=A[W-1];
				end
			end
			2'b10: begin
				//Bitwise AND
				R = A & B;
				N = R[W-1];
				O = 0;
			end
			2'b11: begin
				//Bitwise OR
				R = A | B;
				N = R[W-1];
			 	O = 0;
			end
		endcase
	
		Z = ~|R; //Z = 1 when R=0
	end

endmodule
