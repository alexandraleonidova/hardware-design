/*
 * core_controller.sv
 *
 * Authors: David and Sarah Harris
 * Updated By: Sat Garcia
 *
 * Module that implements control component of processor.
 */

module core_controller(input  logic [5:0] op, funct,
		input  logic       zero,
		output logic       mem_to_reg, dmem_write,
		output logic       pc_src, alu_src,
		output logic       reg_dest, reg_write,
		output logic       jump, 
		output logic [2:0] alu_ctrl);

	logic [1:0] alu_op;
	logic       branch;
	logic branch_equality;
	logic not_zero;
	logic to_pc_src;

	maindec md(.op, .mem_to_reg, .dmem_write, .branch,
				.alu_src, .reg_dest, .reg_write, .jump, .alu_op, .branch_equality);
	aludec  ad(.funct, .alu_op, .alu_ctrl);
	
	assign not_zero = ~zero;

	// add a mux here : parameter is 1 for width
	mux2 #(1) branchingmux(.d0(not_zero), .d1(zero), .sel(branch_equality),
						  .y(to_pc_src));

	assign pc_src = branch & to_pc_src;
	
endmodule
