/*
 * mips_testbench.sv
 *
 * Author: David Harris
 *
 * Testbench for MIPS processor.
 */

module testbench();

	logic        clk;
	logic        reset;

	logic [31:0] write_data, data_addr;
	logic        mem_write;

	// instantiate device to be tested
	top dut(.clk, .reset, .dmem_write_data(write_data), 
			.dmem_addr(data_addr), .dmem_write(mem_write));
	  
	// initialize test
	initial
	begin
		reset = 1; 
		#7; 
		reset = 0;
	end

	// generate clock to sequence tests
	initial
		forever
		begin
			clk = 0; #5; clk = 1; #5;
		end

	// check that 1 gets written to address 0xffff8053
	always@(negedge clk)
	begin
		if(mem_write) begin
			if(data_addr === 83 & write_data === 32514)
			 begin
				$display("Simulation succeeded!");
				$stop;
			 end
			else if (data_addr !== 32510)
			 begin
				$display("Simulation failed! Incorrect result: %d (should be 83) or incorrect address: %d (should be 32510)", write_data, data_addr);
				$stop;
			 end
		end
	end
endmodule
