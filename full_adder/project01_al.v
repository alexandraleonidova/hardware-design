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
// CREATED		"Mon Feb  6 15:34:52 2017"

module project01_al(
	A,
	B,
	Cin,
	S,
	Cout
);


input wire	A;
input wire	B;
input wire	Cin;
output wire	S;
output wire	Cout;

wire	a_wire;
wire	b_wire;
wire	Cin_wire;
wire	n4;
wire	n5;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;




assign	n4 = a_wire ^ b_wire;

assign	n5 = n4 ^ Cin_wire;

assign	SYNTHESIZED_WIRE_2 = a_wire & b_wire;

assign	SYNTHESIZED_WIRE_0 = a_wire & Cin_wire;

assign	SYNTHESIZED_WIRE_1 = b_wire & Cin_wire;

assign	Cout = SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2;

assign	S = n5;
assign	a_wire = A;
assign	b_wire = B;
assign	Cin_wire = Cin;

endmodule
