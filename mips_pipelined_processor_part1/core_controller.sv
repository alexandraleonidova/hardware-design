/*
 * core_controller.sv
 *
 * Authors: David and Sarah Harris
 * Updated By: Sat Garcia
 *
 * Module that implements control component of processor.
 */

module core_controller(input  logic [5:0] op, funct,
						input  logic       equal_d,
						output logic       mem_to_reg_w, dmem_write_m,
						output logic       pc_src_d, alu_src_x,
						output logic       reg_dest_x, reg_write_w,
						output logic       jump_d,
						output logic [2:0] alu_ctrl_x,
						input logic	clk, reset); //order important??? added new
						
	// changed pc_src_m to pc_src_d above
	logic [1:0] alu_op_d;

	logic reg_write_d, reg_write_x, reg_write_m;
	logic mem_to_reg_d, mem_to_reg_x, mem_to_reg_m;
	logic dmem_write_d, dmem_write_x;
	logic branch_d, branch_x, branch_m;
	logic [2:0] alu_ctrl_d; //removed alu_ctrl_x (outut)
	logic alu_src_d;
	logic reg_dest_d;
	//logic jump_d; removed Jump_d (input)

	// Note: Controller is active in Decode (D) stage so we need to make sure we
	// wire the maindec and aludec inputs/outputs up to our "_d" signals (e.g.
	// reg_write_d).
	maindec md(.op, .mem_to_reg(mem_to_reg_d), .dmem_write(dmem_write_d), 
				.branch(branch_d), .alu_src(alu_src_d), .reg_dest(reg_dest_d), 
				.reg_write(reg_write_d), .jump(jump_d),
				.alu_op(alu_op_d));
	aludec  ad(.funct, .alu_op(alu_op_d), .alu_ctrl(alu_ctrl_d));
	
	//changed pc_src_d equation
	assign pc_src_d = branch_d & equal_d;

	// D-X Inter-stage registers
	flopr #(1) reg_write_reg_d_x(.clk, .reset, .d(reg_write_d), .q(reg_write_x));
	flopr #(1) mem_to_reg_reg_d_x(.clk, .reset, .d(mem_to_reg_d), .q(mem_to_reg_x));
	flopr #(1) dmem_write_reg_d_x(.clk, .reset, .d(dmem_write_d), .q(dmem_write_x));
	// branch moved to decode
	//flopr #(1) branch_reg_d_x(.clk, .reset, .d(branch_d), .q(branch_x));
	flopr #(3) alu_ctrl_reg_d_x(.clk, .reset, .d(alu_ctrl_d), .q(alu_ctrl_x));
	flopr #(1) alu_src_reg_d_x(.clk, .reset, .d(alu_src_d), .q(alu_src_x));
	flopr #(1) reg_dest_reg_d_x(.clk, .reset, .d(reg_dest_d), .q(reg_dest_x));

	// X-M Inter-stage registers
	flopr #(1) reg_write_reg_x_m(.clk, .reset, .d(reg_write_x), .q(reg_write_m));
	flopr #(1) mem_to_reg_reg_x_m(.clk, .reset, .d(mem_to_reg_x), .q(mem_to_reg_m));
	flopr #(1) dmem_write_reg_x_m(.clk, .reset, .d(dmem_write_x), .q(dmem_write_m));
	//branch moved to decode
	//flopr #(1) branch_reg_x_m(.clk, .reset, .d(branch_x), .q(branch_m));

	// M-W Inter-stage registers
	flopr #(1) reg_write_reg_m_w(.clk, .reset, .d(reg_write_m), .q(reg_write_w));
	flopr #(1) mem_to_reg_reg_m_w(.clk, .reset, .d(mem_to_reg_m), .q(mem_to_reg_w));
	
endmodule
