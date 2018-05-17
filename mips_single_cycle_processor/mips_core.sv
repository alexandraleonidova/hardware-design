/*
 * mips_core.sv
 *
 * Authors: David and Sarah Harris
 * Updated By: Sat Garcia
 *
 * Module for a Single-cycle 32-bit MIPS processor core.
 * Recall that a CPU has two main components, the datapath and the control,
 * which we use separate modules for here (core_datapath and core_controller).
 */
module mips_core(input  logic clk, reset,
					output logic [31:0] pc,
					input  logic [31:0] instr,
					output logic dmem_write,
					output logic [31:0] alu_out, dmem_write_data,
					input  logic [31:0] dmem_read_data);

	logic mem_to_reg, branch, pc_src, zero, alu_src, reg_dest, reg_write, jump;
	logic [2:0] alu_ctrl;


	core_controller c(.op(instr[31:26]), .funct(instr[5:0]), .zero,
						.mem_to_reg, .dmem_write, .pc_src,
						.alu_src, .reg_dest, .reg_write, .jump,
						.alu_ctrl);
	core_datapath dp(.clk, .reset, .mem_to_reg, .pc_src,
						.alu_src, .reg_dest, .reg_write, .jump,
						.alu_ctrl, .zero, .pc, .instr,
						.alu_out, .dmem_write_data, .dmem_read_data);
endmodule
