/**
 *
 * SystemVerilog module for a branch target buffer (BTB).
 * This BTB will contain 4 entries and implement a 2-bit dynamic branch
 * predictor.
 *
 * @author Partner 1's name
 * @author Partner 2's name
 */
module branch_target_buffer(input logic clk, clear,
							input logic [31:0] pc,
							input logic update_en, update_outcome,
							input logic [31:0] update_pc, update_target,
							output logic [31:0] target,
							output logic pred);

	typedef struct packed {
		logic        valid;
		logic [31:0] pc;
		logic [31:0] target;
		logic [1:0]  state;
	} btb_entry;

	btb_entry entries [3:0]; // create 4 btb_entry structs

	logic [1:0] next_state;
	logic hit;
	always_ff @(posedge clk)
	  begin
		if (clear)
		  begin
			entries[0].valid <= 0;
			entries[1].valid <= 0;
			entries[2].valid <= 0;
			entries[3].valid <= 0;
		  end
		else if (update_en)
		  begin
		  	// TODO: update the entry selected by update_pc
			//$display("updatin buffer entry");
                        //$display("buffer contains %h pc, %h target, %h state", entries[update_pc[3:2]].pc, entries[update_pc[3:2]].target, entries[update_pc[3:2]].state);
			//$display("new values:  %h pc, %h target, %h state", update_pc, update_target, next_state);
			entries[update_pc[3:2]].valid <= 1;
			entries[update_pc[3:2]].pc <= update_pc;
			entries[update_pc[3:2]].target <= update_target;
			entries[update_pc[3:2]].state <= next_state;
		  end
	  end

	// Compute next_state for the selected BTB entry.
	// This will be used when update_en is asserted.
	always_comb
	  begin
	  	// TODO: implement logic for calculating next_state
		//$display("updating state");
		if (((update_pc != entries[update_pc[3:2]].pc) | ~entries[update_pc[3:2]].valid) & update_outcome)
			begin
			//	$display("default to 10");
				next_state = 2'b10;
			end
		else if(((update_pc != entries[update_pc[3:2]].pc) | ~entries[update_pc[3:2]].valid) & ~update_outcome) 
			begin
			//	$display("default to 01");
				next_state = 2'b01;
			end
		else if (entries[update_pc[3:2]].state == 2'b00 & ~update_outcome) next_state = 2'b00;
		else if (entries[update_pc[3:2]].state == 2'b00 & update_outcome) next_state = 2'b01;
		else if (entries[update_pc[3:2]].state == 2'b01 & ~update_outcome) next_state = 2'b00;
		else if (entries[update_pc[3:2]].state == 2'b01 & update_outcome) next_state = 2'b10;
		else if (entries[update_pc[3:2]].state == 2'b10 & ~update_outcome) next_state = 2'b01;
		else if (entries[update_pc[3:2]].state == 2'b10 & update_outcome) next_state = 2'b11;
		else if (entries[update_pc[3:2]].state == 2'b11 & ~update_outcome) next_state = 2'b10;
		else if (entries[update_pc[3:2]].state == 2'b11 & update_outcome) next_state = 2'b11;
		else 
			begin
				$display("Default else, Only gets here in the very beginning");
			end
		//$display("The state was changed to %h : ", next_state);

	    end

	// Compute the outputs (target and pred) of the circuit.
	always_comb
	  begin
		// TODO: implement logic for calculating outputs
		//$display("&&&&&&&&& entries[pc[3:2]].valid &&&&&& pc &&&&&& entries[pc[3:2]].pc &&&& %b, %h, %h, ", entries[pc[3:2]].valid, pc, entries[pc[3:2]].pc);
		hit = entries[pc[3:2]].valid & (pc == entries[pc[3:2]].pc);
		if (hit) target = entries[pc[3:2]].target;
		else target = pc;
		//mux2 #(32) target_mux(.d0(pc), .d1(entries[update_pc[3:2]].target), .sel(hit), .y(target));
		pred = hit & entries[pc[3:2]].state[1]; //works when I change it to 0
		//$display("************** %2b entries[pc[3:2]].state , at 0, at 1, hit***********", entries[pc[3:2]].state, entries[pc[3:2]].state[0], entries[pc[3:2]].state[1], hit);		
	  end


endmodule
