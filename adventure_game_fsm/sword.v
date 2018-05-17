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
// CREATED		"Thu Feb 23 13:23:03 2017"

module sword(
	clk,
	reset,
	sw,
	v
);


input wire	clk;
input wire	reset;
input wire	sw;
output wire	v;

wire	sword_and_to_flipflop;
wire	swordandbottom;
wire	swordandtop;
wire	Swordorbottom;
reg	Swordortop;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;

assign	SYNTHESIZED_WIRE_0 = 1;
assign	SYNTHESIZED_WIRE_1 = 1;



assign	swordandtop = Swordorbottom | Swordortop;


always@(posedge clk or negedge SYNTHESIZED_WIRE_0 or negedge SYNTHESIZED_WIRE_1)
begin
if (!SYNTHESIZED_WIRE_0)
	begin
	Swordortop <= 0;
	end
else
if (!SYNTHESIZED_WIRE_1)
	begin
	Swordortop <= 1;
	end
else
	begin
	Swordortop <= sword_and_to_flipflop;
	end
end

assign	swordandbottom =  ~reset;



assign	sword_and_to_flipflop = swordandtop & swordandbottom;

assign	v = Swordortop;
assign	Swordorbottom = sw;

endmodule
