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

	logic mem_to_reg_w, pc_src_d, eq_d, alu_src_x, reg_dest_x, reg_write_w, jump_d;
	logic [2:0] alu_ctrl_x;
	logic [31:0] instr_d;
	logic stall_f, stall_d, flush_x;
	logic fwd_a_d, fwd_b_d;
	logic [1:0] fwd_a_x, fwd_b_x;
	logic fwd_m;
	logic [4:0] write_reg_x, write_reg_m, write_reg_w;
	logic [4:0] rs_d, rt_d, rs_x, rt_x, rt_m;

	core_controller c(.op(instr_d[31:26]),
						.funct(instr_d[5:0]), 
						.eq_d,
						.mem_to_reg_w, 
						.dmem_write_m(dmem_write), 
						.pc_src_d,
						.alu_src_x, 
						.reg_dest_x, 
						.reg_write_w, 
						.jump_d,
						.alu_ctrl_x,
						.stall_f,
						.stall_d,
						.flush_x,
						.fwd_a_d,
						.fwd_b_d,
						.fwd_a_x,
						.fwd_b_x,
						.fwd_m,
						.write_reg_x,
						.write_reg_m,
						.write_reg_w,
						.rs_d,
						.rt_d,
						.rs_x,
						.rt_x,
						.rt_m,
						.clk,
						.reset);

	core_datapath dp(.clk, .reset,
						.mem_to_reg_w, 
						.pc_src_d, 
						.instr_f,
						.alu_src_x, 
						.reg_dest_x, 
						.reg_write_w, 
						.jump_d,
						.alu_ctrl_x, 
						.stall_f,
						.stall_d,
						.flush_x,
						.fwd_a_d,
						.fwd_b_d,
						.fwd_a_x,
						.fwd_b_x,
						.fwd_m,
						.eq_d, 
						.pc, 
						.instr_d,
						.alu_out_m(alu_out), 
						.dmem_write_data_m(dmem_write_data),
						.dmem_read_data_m(dmem_read_data),
						.write_reg_x,
						.write_reg_m,
						.write_reg_w,
						.rs_d,
						.rt_d,
						.rs_x,
						.rt_x,
						.rt_m
						);
endmodule
