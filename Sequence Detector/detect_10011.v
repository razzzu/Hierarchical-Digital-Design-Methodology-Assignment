//10011 detector - Raj Patel

module detect_10011(output reg z, input x, clk, rst);

	reg [2:0] state, next_state;

	parameter [2:0] s0 = 3'b000, s1 = 3'b001, s2 = 3'b011, s3 = 3'b010,
				s4 = 3'b110, s5 = 3'b100;

	always @ (posedge clk, negedge rst) begin
		if (!rst) 
			state <= s0;
		else
			state <= next_state;
	end

	always @ (*) begin
		next_state = 3'bxxx;
		z = 1'b0;
		case(state)
			s0: if(x)	next_state = s1; 
				else	next_state = s0; 

			s1: if(x)	next_state = s1; 
				else	next_state = s2; 

			s2: if(x)	next_state = s1; 
				else	next_state = s3; 

			s3: if(x)	next_state = s4; 
				else	next_state = s0; 

			s4: if(x)	next_state = s5; 
				else	next_state = s2; 

			s5: begin
				z = 1'b1;
				if(x)	next_state = s1; 
				else	next_state = s2; 
			end
		endcase
	end
endmodule
