module project04_al(input logic clk,
                    input logic reset,
                    input logic left, right,
                    output logic la, lb, lc, ra, rb, rc);

	logic s0, l1, l2, l3, r1, r2, r3; 
	logic s0_next, l1_next, l2_next, l3_next, r1_next, r2_next, r3_next;

	// next state equations
	assign s0_next = reset | (s0 & ((left & right) | (~left & ~right))) | l3 | r3;
	assign l1_next = ~reset & left & ~right & s0;
	assign l2_next = ~reset & l1;
	assign l3_next = ~reset & l2;
	assign r1_next = ~reset & ~left & right & s0;
	assign r2_next = ~reset & r1;
	assign r3_next = ~reset & r2;
	
	// state update
	always_ff@(posedge clk)
	  begin
		s0 <= s0_next;
		l1 <= l1_next;
		l2 <= l2_next;
		l3 <= l3_next;
		r1 <= r1_next;
		r2 <= r2_next;
		r3 <= r3_next;
	  end
	
	assign la = l1 | l2 | l3;
	assign lb = l2 | l3;
	assign lc = l3;
	assign ra = r1 | r2 | r3;
	assign rb = r2 | r3;
	assign rc = r3;

endmodule