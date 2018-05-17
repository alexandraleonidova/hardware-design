/*
 * COMP300 @ USD
 *
 * Self-checking testbench for the 32 bit ALU.
 */
module alu32_tb();

        logic [31:0] a, b;
        logic [2:0]  f;
        logic [31:0] y;
        logic zero, carry_out, overflow;

	// array of 34 test vectors, each containing 32 bits.
	logic [116:0] test_vectors [33:0];

	integer test_num, num_errors;
	integer print_loop;

	alu #(32) alu32(.a, .b, .f, .y, .zero, .carry_out, .overflow);

	initial
	begin
		/* 
		 * TODO: Read in test vectors using $readmemb.
		 *
		 * readmemb takes in two params, the first being a string with the
		 * name of the test vector file and the second being the array where
		 * you will store the test vectors.
		 */
		
		$readmemh("alu32.tv", test_vectors);
		
		// TODO: set num_errors to 0
		num_errors = 0;

		for (test_num = 0; test_num < 34; test_num++)
		begin
			//$display("+++++++++++++++++++++++++++++++++");
			//$display("line %d", test_num);
			//for (print_loop = 0; print_loop < 116; print_loop++)
			//	begin
			//		$display("%d index %d", print_loop, test_vectors[test_num][print_loop]);
			//	end
			//$display("+++++++++++++++++++++++++++++++++");

			/*
			 * TODO: Use "assert/else" to check that soda and change match what we
			 * expected.
			 * You should print an error message if there is a discrepancy and
			 * increment the num_errors variable.
			 * Note: You should use "===" to check for a match (not "=="), as
			 * "===" * takes into account X (uninitialized) and Z (high impedance)
			 * values.
			 */
			 
			//USE THIS FOR REAL TB

			f = test_vectors[test_num][110:108];
			a = test_vectors[test_num][107:76];
			b = test_vectors[test_num][75:44];
			//a = 123;
			//b = 321;
			#50;
			assert ((y === test_vectors[test_num][43:12]) & (zero === test_vectors[test_num][8]) & (carry_out === test_vectors[test_num][4]) & (overflow === test_vectors[test_num][0])) 
			else 
				begin
					$error("Test %d failed. Operation number %d. Expected %d for y, %d for zero, %d for carry_out and %d for overflow. Recieved %d for y, %d for zero, %d for carry_out and %d for overflow", test_num, test_vectors[test_num][110:108], test_vectors[test_num][43:12], test_vectors[test_num][8], test_vectors[test_num][4], test_vectors[test_num][0], y, zero, carry_out, overflow);
			
					num_errors = num_errors + 1;
				end

		end

		// TODO: print a summary of your test results here.
		$display("%d tests completed with %d errors", test_num, num_errors); 
	end

endmodule
