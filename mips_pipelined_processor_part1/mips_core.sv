/*
 * mips_core.sv
 *
 * Authors: David and Sarah Harris
 * Updated By: Sat Garcia
 *
 * Module for a 32-bit MIPS pipelined processor core.
 *
 * Recall that a CPU has two main components, the datapath and the control,
 * which we use separate modules for here (core_datapath and core_controller).
 */

module mips_core(input  logic clk, reset,
					output logic [31:0] pc,
					input  logic [31:0] instr_f,
					output logic dmem_write,
					output logic [31:0] alu_out, dmem_write_data,
					input  logic [31:0] dmem_read_data);

	//removed zero_m, added equal_d
	logic mem_to_reg_w, pc_src_d, equal_d, alu_src_x, reg_dest_x, reg_write_w, jump_d;
	logic [2:0] alu_ctrl_x;
	logic [31:0] instr_d;

	//removed input zero, added branch_d instead
	core_controller c(.op(instr_d[31:26]),
						.funct(instr_d[5:0]), 
						.equal_d,
						.mem_to_reg_w, 
						.dmem_write_m(dmem_write), 
						.pc_src_d,
						.alu_src_x, 
						.reg_dest_x, 
						.reg_write_w, 
						.jump_d,
						.alu_ctrl_x, .clk, .reset); //added clk and .reset

	//removed output zero, added branch_d instead
	core_datapath dp(.clk, .reset,
						.mem_to_reg_w, 
						.pc_src_d, 
						.instr_f,
						.alu_src_x, 
						.reg_dest_x, 
						.reg_write_w, 
						.jump_d,
						.alu_ctrl_x, 
						.equal_d, 
						.pc, 
						.instr_d,
						.alu_out_m(alu_out), 
						.dmem_write_data_m(dmem_write_data),
						.dmem_read_data_m(dmem_read_data));
endmodule
