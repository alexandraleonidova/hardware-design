/*
 * maindec.sv
 *
 * Authors: David and Sarah Harris
 * Updated By: Sat Garcia
 *
 * Module that computes all non-ALU control signals.
 */
module maindec(input  logic [5:0] op,
               output logic       mem_to_reg, dmem_write,
               output logic       branch, alu_src,
               output logic       reg_dest, reg_write,
               output logic       jump,
               output logic [1:0] alu_op,
	       output logic branch_equality);
	
	// was [8:0]
	logic [9:0] controls;

	//branch equality was added: ASC IF ORDER MATTERS
	assign {reg_write, reg_dest, alu_src,
			  branch, dmem_write,
			  mem_to_reg, jump, alu_op, branch_equality} = controls;

	always_comb
	begin
		case(op)
			//was 9'b, now 10'b
			6'b000000: controls = 10'b1100000100; // Rtype
			6'b100011: controls = 10'b1010010000; // LW
			6'b101011: controls = 10'b0010100000; // SW
			6'b000100: controls = 10'b0001000011; // BEQ
			6'b001000: controls = 10'b1010000000; // ADDI
			6'b000010: controls = 10'b0000001000; // J
			//NEW
			6'b001101: controls = 10'b1010000110;//ORI
			6'b000101: controls = 10'b0001000100;//BNE
			default:   controls = 10'bxxxxxxxxxx; // ???
		endcase
	end
endmodule
