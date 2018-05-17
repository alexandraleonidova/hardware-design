/* 
 * File: project04_wrapper.sv
 *
 * This file makes it easier to match your FSM inputs/outputs to the DE0-Nano
 * inputs/outputs.
 */

module project04_wrapper(input  logic [2:0] SW,
                    input  logic [0:0] KEY,
                    output logic [7:0] LED);
          
  // Use Key0 for clk
  // switches for inputs
  // red and green LEDs for output
          
  // Replace "xx" with your initials on the following line. Don't change
  // anything else.
  project04_al project04_al(.clk(KEY[0]), .reset(SW[0]), .left(SW[2]), .right(SW[1]),
							.la(LED[5]), .lb(LED[6]), .lc(LED[7]), 
							.ra(LED[2]), .rb(LED[1]), .rc(LED[0]));
endmodule
