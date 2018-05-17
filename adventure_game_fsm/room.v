// Copyright (C) 2016  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Intel and sold by Intel or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 16.1.1 Build 200 11/30/2016 SJ Lite Edition"
// CREATED		"Thu Feb 23 13:22:55 2017"

module room(
	n,
	s,
	e,
	w,
	v,
	reset,
	clk,
	s6,
	win,
	s5,
	d,
	s4,
	s3,
	sw,
	s2,
	s1,
	s0
);


input wire	n;
input wire	s;
input wire	e;
input wire	w;
input wire	v;
input wire	reset;
input wire	clk;
output wire	s6;
output wire	win;
output wire	s5;
output wire	d;
output wire	s4;
output wire	s3;
output wire	sw;
output wire	s2;
output wire	s1;
output wire	s0;

wire	e_input;
wire	n_input;
wire	not_reset_input;
reg	S0_flop_out;
wire	S1_and_to_flop;
wire	S1_and_to_or_bottom;
wire	S1_and_to_or_top;
reg	S1_flop_out;
wire	S1_or_to_and;
reg	S2_flop_out;
wire	S3_and_to_flop;
reg	S3_flop_output;
wire	w_input;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
reg	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_23;
reg	DFF_inst22;
reg	DFF_inst21;

assign	s6 = DFF_inst22;
assign	win = DFF_inst22;
assign	s5 = DFF_inst21;
assign	d = DFF_inst21;
assign	s4 = SYNTHESIZED_WIRE_24;
assign	SYNTHESIZED_WIRE_4 = 1;
assign	SYNTHESIZED_WIRE_6 = 1;
assign	SYNTHESIZED_WIRE_7 = 1;
assign	SYNTHESIZED_WIRE_8 = 1;
assign	SYNTHESIZED_WIRE_9 = 1;
assign	SYNTHESIZED_WIRE_11 = 1;
assign	SYNTHESIZED_WIRE_12 = 1;
assign	SYNTHESIZED_WIRE_13 = 1;
assign	SYNTHESIZED_WIRE_14 = 1;
assign	SYNTHESIZED_WIRE_16 = 1;
assign	SYNTHESIZED_WIRE_17 = 1;
assign	SYNTHESIZED_WIRE_19 = 1;
assign	SYNTHESIZED_WIRE_20 = 1;
assign	SYNTHESIZED_WIRE_22 = 1;



assign	SYNTHESIZED_WIRE_23 = S1_flop_out & w_input;

assign	S3_and_to_flop = S2_flop_out & w_input & not_reset_input;

assign	not_reset_input =  ~reset;

assign	SYNTHESIZED_WIRE_3 =  ~v;

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1;

assign	SYNTHESIZED_WIRE_10 = SYNTHESIZED_WIRE_2 & not_reset_input;

assign	SYNTHESIZED_WIRE_15 = S2_flop_out & e_input & not_reset_input;

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_24 & SYNTHESIZED_WIRE_3 & not_reset_input;

assign	SYNTHESIZED_WIRE_21 = SYNTHESIZED_WIRE_24 & v & not_reset_input;


always@(posedge clk or negedge SYNTHESIZED_WIRE_4 or negedge SYNTHESIZED_WIRE_6)
begin
if (!SYNTHESIZED_WIRE_4)
	begin
	S0_flop_out <= 0;
	end
else
if (!SYNTHESIZED_WIRE_6)
	begin
	S0_flop_out <= 1;
	end
else
	begin
	S0_flop_out <= SYNTHESIZED_WIRE_5;
	end
end


always@(posedge clk or negedge SYNTHESIZED_WIRE_7 or negedge SYNTHESIZED_WIRE_8)
begin
if (!SYNTHESIZED_WIRE_7)
	begin
	S1_flop_out <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	S1_flop_out <= 1;
	end
else
	begin
	S1_flop_out <= S1_and_to_flop;
	end
end


always@(posedge clk or negedge SYNTHESIZED_WIRE_9 or negedge SYNTHESIZED_WIRE_11)
begin
if (!SYNTHESIZED_WIRE_9)
	begin
	S2_flop_out <= 0;
	end
else
if (!SYNTHESIZED_WIRE_11)
	begin
	S2_flop_out <= 1;
	end
else
	begin
	S2_flop_out <= SYNTHESIZED_WIRE_10;
	end
end


always@(posedge clk or negedge SYNTHESIZED_WIRE_12 or negedge SYNTHESIZED_WIRE_13)
begin
if (!SYNTHESIZED_WIRE_12)
	begin
	S3_flop_output <= 0;
	end
else
if (!SYNTHESIZED_WIRE_13)
	begin
	S3_flop_output <= 1;
	end
else
	begin
	S3_flop_output <= S3_and_to_flop;
	end
end


always@(posedge clk or negedge SYNTHESIZED_WIRE_14 or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_14)
	begin
	SYNTHESIZED_WIRE_24 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_16)
	begin
	SYNTHESIZED_WIRE_24 <= 1;
	end
else
	begin
	SYNTHESIZED_WIRE_24 <= SYNTHESIZED_WIRE_15;
	end
end


always@(posedge clk or negedge SYNTHESIZED_WIRE_17 or negedge SYNTHESIZED_WIRE_19)
begin
if (!SYNTHESIZED_WIRE_17)
	begin
	DFF_inst21 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_19)
	begin
	DFF_inst21 <= 1;
	end
else
	begin
	DFF_inst21 <= SYNTHESIZED_WIRE_18;
	end
end


always@(posedge clk or negedge SYNTHESIZED_WIRE_20 or negedge SYNTHESIZED_WIRE_22)
begin
if (!SYNTHESIZED_WIRE_20)
	begin
	DFF_inst22 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_22)
	begin
	DFF_inst22 <= 1;
	end
else
	begin
	DFF_inst22 <= SYNTHESIZED_WIRE_21;
	end
end







assign	SYNTHESIZED_WIRE_5 = reset | SYNTHESIZED_WIRE_23;









assign	S1_and_to_or_top = S0_flop_out & e_input;

assign	S1_and_to_or_bottom = S2_flop_out & n_input;

assign	S1_or_to_and = S1_and_to_or_bottom | S1_and_to_or_top;

assign	S1_and_to_flop = S1_or_to_and & not_reset_input;

assign	SYNTHESIZED_WIRE_1 = S1_flop_out & s;

assign	SYNTHESIZED_WIRE_0 = S3_flop_output & e_input;

assign	w_input = w;
assign	e_input = e;
assign	n_input = n;
assign	s3 = S3_flop_output;
assign	sw = S3_flop_output;
assign	s2 = S2_flop_out;
assign	s1 = S1_flop_out;
assign	s0 = S0_flop_out;

endmodule
