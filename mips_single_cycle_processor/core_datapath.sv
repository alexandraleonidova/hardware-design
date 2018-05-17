/*
 * core_datapath.sv
 *
 * Authors: David and Sarah Harris
 * Updated By: Sat Garcia
 *
 * Module that implements datapath component of MIPS core.
 */

module core_datapath(input  logic   clk, reset,
                input  logic        mem_to_reg, pc_src,
                input  logic        alu_src, reg_dest,
                input  logic        reg_write, jump,
                input  logic [2:0]  alu_ctrl,
                output logic        zero,
                output logic [31:0] pc,
                input  logic [31:0] instr,
                output logic [31:0] alu_out, dmem_write_data,
                input  logic [31:0] dmem_read_data);

	logic [4:0]  write_reg;
	logic [31:0] pc_next, pc_next_br, pc_plus_4, pc_branch;
	logic [31:0] sign_imm, sign_imm_shifted;
	logic [31:0] srca, srcb;
	logic [31:0] result;
	logic carry, overflow;

	// logic for determining next PC
	flopr #(32) pcreg(.clk, .reset, .d(pc_next), .q(pc));

	adder #(32) pcadd1(.a(pc), .b(32'b100), .y(pc_plus_4));

	shiftleft2 #(32) immsh(.a(sign_imm), .y(sign_imm_shifted));

	adder #(32) pcadd2(.a(pc_plus_4), .b(sign_imm_shifted), .y(pc_branch));

	mux2 #(32) pcbrmux(.d0(pc_plus_4), .d1(pc_branch), .sel(pc_src),
						  .y(pc_next_br));
	mux2 #(32) pcmux(.d0(pc_next_br), 
					  .d1({pc_plus_4[31:28], instr[25:0], 2'b00}), 
					  .sel(jump), .y(pc_next));

	// logic associated with register file
	regfile #(32,32) rf(.clk, .we3(reg_write & ~reset), .ra1(instr[25:21]),
						.ra2(instr[20:16]), .wa3(write_reg), 
						.wd3(result), .rd1(srca), .rd2(dmem_write_data));

	mux2 #(5) wrmux(.d0(instr[20:16]), .d1(instr[15:11]),
						.sel(reg_dest), .y(write_reg));
	mux2 #(32) resmux(.d0(alu_out), .d1(dmem_read_data),
						 .sel(mem_to_reg), .y(result));
	signext se(instr[15:0], sign_imm);

	// logic associated with the ALU
	mux2 #(32) srcbmux(.d0(dmem_write_data), .d1(sign_imm),
						.sel(alu_src), .y(srcb));

	alu #(32) alu(.a(srca), .b(srcb), .f(alu_ctrl), .y(alu_out),
					.zero(zero), .carry, .overflow);
endmodule
