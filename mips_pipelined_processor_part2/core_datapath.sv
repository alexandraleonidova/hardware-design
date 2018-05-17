/*
 * core_datapath.sv
 *
 * Authors: David and Sarah Harris
 * Updated By: Sat Garcia
 *
 * Module that implements datapath component of MIPS core.
 */

module core_datapath(input  logic   clk, reset,
                input  logic        mem_to_reg_w, pc_src_d,
                input  logic        alu_src_x, reg_dest_x,
                input  logic        reg_write_w, jump_d,
                input  logic [2:0]  alu_ctrl_x,
                output logic        eq_d,
                output logic [31:0] pc,
                input  logic [31:0] instr_f,
                output logic [31:0] instr_d,
                output logic [31:0] alu_out_m, dmem_write_data_m,
                input  logic [31:0] dmem_read_data_m,
		output logic [4:0] rs_d, rt_d, rs_x, rt_x, rt_m, rt_w,
		output logic [4:0] write_reg_x, write_reg_m, write_reg_w,
		input logic dmem_write_m,
		input logic stall_f, stall_d, flush_x,
		input logic fwd_a_d, fwd_b_d, 
		input logic [1:0] fwd_a_x, fwd_b_x,
		input logic forward_w_m); //added what is after dmem_read_data_mem

	// enable and reset signals
	//ADDED
	logic pc_reg_en_f;
	logic reg_f_d_en, reg_f_d_reset;
	logic reg_d_x_reset;
	// Fetch (F) stage signals
	logic [31:0] pc_plus_4_f, pc_next_br_f, pc_next_f;

	// Decode (D) stage signals
	logic [31:0] sign_imm_d;
	logic [31:0] sign_imm_shifted_d;
	logic [31:0] pc_plus_4_d;
	logic [31:0] dmem_write_data_d;
	logic [31:0] pc_branch_d;
	logic [4:0] rd_d;
	// Execute (X) stage signals
	logic [31:0] sign_imm_x, srca_x, srcb_x;
	logic [31:0] alu_out_x, dmem_write_data_x;
	logic zero_x, carry_x, overflow_x;
	logic [4:0] rd_x;
	logic [31:0] rd1_out_d, rd2_out_d, to_srca_d, to_srcb_d, to_srca_x, to_srcb_x;
	
	// Memory (M) stage signals
	logic [31:0] dmem_write_data_orig_m;
	// Writeback (W) stage signals
	logic [31:0] alu_out_w, dmem_read_data_w, result_w;

	

	// Fetch (F) stage datapath components
	//flopr #(32) pcreg(.clk, .reset, .d(pc_next_f), .q(pc));

	assign pc_reg_en_f = ~stall_f;
	flopenr #(32) pcreg(.clk, .reset, .en(pc_reg_en_f), .d(pc_next_f), .q(pc));

	adder #(32) pcadd1(.a(pc), .b(32'b100), .y(pc_plus_4_f));

	mux2 #(32) pcbrmux(.d0(pc_plus_4_f), .d1(pc_branch_d), .sel(pc_src_d),
						  .y(pc_next_br_f));

	mux2 #(32) pcmux(.d0(pc_next_br_f), 
					  .d1({pc_plus_4_d[31:28], instr_d[25:0], 2'b00}), 
					  .sel(jump_d), .y(pc_next_f));


	// ADDED The F/D registers need to be switched to use the flopenr module.
	// Fetch-to-Decode Inter-stage Registers
	//flopr #(32) pc_plus_4_reg_f_d(.clk, .reset, .d(pc_plus_4_f), .q(pc_plus_4_d));
	//flopr #(32) instr_reg_f_d(.clk, .reset, .d(instr_f), .q(instr_d));

	assign reg_f_d_en = ~stall_d;
	assign reg_f_d_reset = reset | jump_d | pc_src_d;

	flopenr #(32) pc_plus_4_reg_f_d(.clk, .reset(reg_f_d_reset), .en(reg_f_d_en), .d(pc_plus_4_f), .q(pc_plus_4_d));
	flopenr #(32) instr_reg_f_d(.clk, .reset(reg_f_d_reset), .en(reg_f_d_en), .d(instr_f), .q(instr_d));

	// Decode (D) stage datapath components 
	
	// Note: reg file also used WB
	regfile #(32,32) rf(.clk(~clk), .we3(reg_write_w & ~reset), 
						.ra1(instr_d[25:21]), .ra2(instr_d[20:16]),
						.rd1(rd1_out_d), .rd2(rd2_out_d),
						.wa3(write_reg_w), .wd3(result_w)
					);
	//ADDED MUXES
	mux2 #(32) fromregrd1(.d0(rd1_out_d), .d1(alu_out_m), .sel(fwd_a_d), .y(to_srca_d));
	mux2 #(32) fromregrd2(.d0(rd2_out_d), .d1(alu_out_m), .sel(fwd_b_d), .y(to_srcb_d));

	signext se(.a(instr_d[15:0]), .y(sign_imm_d));

	eq #(32) equals(.a(to_srca_d), .b(to_srcb_d), .equal(eq_d));

	shiftleft2 #(32) immsh(.a(sign_imm_d), .y(sign_imm_shifted_d));

	adder #(32) pcadd2(.a(pc_plus_4_d), .b(sign_imm_shifted_d), .y(pc_branch_d));
	
	assign rs_d = instr_d[25:21];
	assign rt_d = instr_d[20:16];
	assign rd_d = instr_d[15:11];
	// Decode-to-Execute Inter-stage Registers

	//ADD NEW RESET
	assign reg_d_x_reset = reset | flush_x;

	//flopr #(32) srca_reg_d_x(.clk, .reset, .d(to_srca_d), .q(srca_x));
	//flopr #(32) dmem_write_data__regd_x(.clk, .reset, .d(dmem_write_data_d), .q(dmem_write_data_x));
	//flopr #(5) rt_reg_d_x(.clk, .reset, .d(instr_d[20:16]), .q(rt_x));
	//flopr #(5) rd_reg_d_x(.clk, .reset, .d(instr_d[15:11]), .q(rd_x));
	//flopr #(32) sign_imm_reg_d_x(.clk, .reset, .d(sign_imm_d), .q(sign_imm_x));

	flopr #(32) srca_reg_d_x(.clk, .reset(reg_d_x_reset), .d(to_srca_d), .q(to_srca_x));
	flopr #(32) srcb_reg_d_x(.clk, .reset(reg_d_x_reset), .d(to_srcb_d), .q(to_srcb_x));
	flopr #(5) rs_reg_d_x(.clk, .reset(reg_d_x_reset), .d(rs_d), .q(rs_x));
	flopr #(5) rt_reg_d_x(.clk, .reset(reg_d_x_reset), .d(rt_d), .q(rt_x));
	flopr #(5) rd_reg_d_x(.clk, .reset(reg_d_x_reset), .d(rd_d), .q(rd_x));
	flopr #(32) sign_imm_reg_d_x(.clk, .reset(reg_d_x_reset), .d(sign_imm_d), .q(sign_imm_x));

	// Execute (X) stage datapath components
	mux2 #(5) wrmux(.d0(rt_x), .d1(rd_x), .sel(reg_dest_x), .y(write_reg_x));

	//ADDED new forwarding multiplexers

	mux3 #(32) forwardsrcamux(.d0(to_srca_x), .d1(result_w), .d2(alu_out_m), .sel(fwd_a_x), .y(srca_x)); 
	mux3 #(32) forwardsrcbmux(.d0(to_srcb_x), .d1(result_w), .d2(alu_out_m), .sel(fwd_b_x), .y(dmem_write_data_x)); 
	
	// selects if alu's 2nd input is immediate or register

	mux2 #(32) srcbmux(.d0(dmem_write_data_x), .d1(sign_imm_x),.sel(alu_src_x), .y(srcb_x));


	alu #(32) alu(.a(srca_x), .b(srcb_x), .f(alu_ctrl_x), .y(alu_out_x),
					.zero(zero), .carry(carry_x), .overflow(overflow_x));

	// Execute-to-Memory Inter-stage Registers
	flopr #(32) alu_out_reg_x_m(.clk, .reset, .d(alu_out_x), .q(alu_out_m));
	flopr #(32) dmem_write_data_reg_x_m(.clk, .reset, .d(dmem_write_data_x),.q(dmem_write_data_orig_m));

	// "A foolish consistency is the hobgoblin of small minds..."
	flopr #(5) write_reg_reg_x_m(.clk, .reset, .d(write_reg_x), .q(write_reg_m));
	//ADD registers to deliver rt to m stage
	flopr #(5) rt_reg_x_m(.clk, .reset, .d(rt_x), .q(rt_m));
	
	mux2 #(32) forwardmemwritedatawtom(.d0(dmem_write_data_orig_m), .d1(result_w), .sel(forward_w_m), .y(dmem_write_data_m));
	// Memory (M) stage datapath components
	
	// Wait, where are they?!?! 
	// Oh, that's right. Data memory is its own module that we hook up to via
	// inputs and outputs of this module.


	// Memory-to-Writeback Inter-stage Registers
	flopr #(32) alu_out_reg_m_w(.clk, .reset, .d(alu_out_m), .q(alu_out_w));
	flopr #(32) dmem_read_data_reg_m_w(.clk, .reset, .d(dmem_read_data_m), .q(dmem_read_data_w));
	flopr #(5) write_reg_reg_m_w(.clk, .reset, .d(write_reg_m), .q(write_reg_w));
	//ADD registers to deliver rt to w stage
	flopr #(5) rt_reg_m_w(.clk, .reset, .d(rt_m), .q(rt_w));

	// Writeback (W) stage datapath components
	
	mux2 #(32) resmux(.d0(alu_out_w), .d1(dmem_read_data_w),
						 .sel(mem_to_reg_w), .y(result_w));

endmodule
