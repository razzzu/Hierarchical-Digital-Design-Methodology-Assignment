// 10011 Detector Testbench - Raj Patel

`include "detect_10011.v"

module detect_10011_fixture;

	reg x, clk, rst;
	reg [9:0] in_hist, in_seq;
	wire z;
	
	integer fail = 0;
	detect_10011 dut(.z(z), .x(x), .clk(clk), .rst(rst));

	initial 
		$vcdpluson;

	initial begin
		//Generate Clock
		clk = 1'b1;
		#5;
		forever #5 clk = ~clk;
	end

	initial begin
		//Generate reset
		rst = 1'b0;
		#2;
		rst = 1'b1;
	end

	always @ (posedge clk, negedge rst) begin
		//Check output at every clk edge
		if(!rst) begin
			#1 check_reset();
		end
		else
			#1 check_output();
	end
		
	
	initial begin
		//Testing DUT 
		random_test();
		overlapping_sequence_test();
		reset_test();
		
		if(fail) 
			$display("\n**DUT Failed %d test cases**\n", fail);
		else
			$display("\n**DUT Passed all test cases**\n");
	 	$finish;
	end
	
	task check_output(); begin
		//Compare output to the exptected output to detect False positive or False negative
		case(z)
			1'b1:
				if(in_hist[4:0] !== 5'b10011) begin
					fail = fail + 1;
					$display("Failed Test: %b z = %b should be 0", in_hist, z);
				end
			1'b0:
				if(in_hist[4:0] === 5'b10011) begin
					fail = fail + 1;
					$display("Failed Test: %b z = %b should be 1", in_hist, z);
				end
		endcase
		$display("Input History: %b, z=%b, state=%b", in_hist, z, dut.state);
	end
	endtask
	
	task check_reset(); begin
		//When reset is asserted check if it actually worked.
		if(dut.state !== 3'b000) begin
			$display("Failed reset: state=%b" , dut.state);
			fail = fail + 1;
		end	
		$display("Reset asserted: state=%b", dut.state);
	end
	endtask
	
	task random_test (); begin
		$display("-------------Random Test-----------------");
		repeat(1000)@(negedge clk) begin
			in_seq = in_seq >> 1;
			in_seq[9] = $random % 2;
			drive_x();
		end
		$display("-------------Random Test Finished--------");
	end
	endtask
	
	task overlapping_sequence_test(); begin
		$display("-------------Overlapping test------------");
		in_seq = 10'b1001100110;
		repeat(10)@(negedge clk) begin
			drive_x();
			in_seq = in_seq << 1;
			in_seq[0] = $random % 2;
 		end
		$display("-----------Overlapping test Finished-----");
	end
	endtask
	
	task reset_test(); begin
		$display("-------------Reset test------------------");
		repeat(100)@(negedge clk) begin
			if ($random % 2) begin
				rst=1'b0;
				#2 rst = 1'b1;
				in_hist = 10'bxxxxxxxxxx;
			end
			else begin
				in_seq = in_seq >> 1;
				in_seq[9] = $random % 2;
				drive_x();
			end 
		end
		$display("-------------Reset test Finished---------");
	end
	endtask
	
	task drive_x(); begin
		x = in_seq[9];
		in_hist = in_hist << 1;
		in_hist[0] = x;
	end
	endtask
	
endmodule
