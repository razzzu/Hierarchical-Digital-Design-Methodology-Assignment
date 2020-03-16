//Tri-State Buffer - Raj & Athul

module tri_buff(output reg y, input x, en);

	always @ (*) begin
		if (en) 
			y = x;
		else
			y = 1'bz;
	end

endmodule
