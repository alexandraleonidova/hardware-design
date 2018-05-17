module alu
        #(parameter WIDTH=16)
         (input logic [WIDTH-1:0] a, b,
          input  logic [2:0]  f,
          output logic [WIDTH-1:0] y,
          output logic zero, carry_out, overflow);
	  logic[WIDTH:0] check_add, check_sub;
			 always_comb
				begin
				 check_sub = a - b;
					case(f)
						3'b000:
							begin
								y = a & b;
								carry_out = 0;
								overflow = 0;
								zero = (y == 0);
							end
						3'b001:
							begin
								y = a | b;
								carry_out = 0;
								overflow = 0;
								zero = (y == 0);
							end
						3'b010: 
							begin
								check_add = a + b;
								y = check_add[WIDTH - 1:0];
								carry_out = check_add[WIDTH];
								overflow = ((a[WIDTH - 1] == b[WIDTH - 1]) & (a[WIDTH - 1] != y[WIDTH - 1]));
								zero = (y == 0);
							end
						3'b011:
							begin
								y = 0;
								carry_out = 0;
								overflow = 0;
								zero = (y == 0);
							end
						3'b100:
							begin
								y = a ^ b;
								carry_out = 0;
								overflow = 0;
								zero = (y == 0);
							end
						3'b101:
							begin
								y = ~(a | b);
								carry_out = 0;
								overflow = 0;
								zero = (y == 0);
							end
						3'b110:
							begin
		                                                overflow = (a[WIDTH - 1] != b[WIDTH - 1]) & (a[WIDTH - 1] != check_sub[WIDTH - 1]);
                                                        	y = check_sub[WIDTH - 1:0];
								carry_out = check_sub[WIDTH];
							        zero = (y == 0);
							end
						default: //111
							begin
                                                                overflow = (a[WIDTH - 1] != b[WIDTH - 1]) & (a[WIDTH - 1] != check_sub[WIDTH - 1]);
								y = check_sub[WIDTH - 1];
								carry_out = check_sub[WIDTH];
								zero = (y == 0);
							end
						endcase
					end
endmodule
			

					
					
