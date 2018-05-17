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
// CREATED		"Wed Feb 22 16:43:17 2017"

module project03_al(
	n,
	s,
	e,
	w,
	reset,
	clk,
	s0,
	s1,
	s2,
	s3,
	s4,
	d,
	s5,
	win,
	s6
);


input wire	n;
input wire	s;
input wire	e;
input wire	w;
input wire	reset;
input wire	clk;
output wire	s0;
output wire	s1;
output wire	s2;
output wire	s3;
output wire	s4;
output wire	d;
output wire	s5;
output wire	win;
output wire	s6;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;





sword	b2v_inst1(
	.clk(clk),
	.reset(reset),
	.sw(SYNTHESIZED_WIRE_0),
	.v(SYNTHESIZED_WIRE_1));


room	b2v_inst2(
	.n(n),
	.s(s),
	.e(e),
	.w(w),
	.v(SYNTHESIZED_WIRE_1),
	.reset(reset),
	.clk(clk),
	.s0(s0),
	.s1(s1),
	.s2(s2),
	.sw(SYNTHESIZED_WIRE_0),
	.s3(s3),
	.s4(s4),
	.d(d),
	.s5(s5),
	.win(win),
	.s6(s6));


endmodule
