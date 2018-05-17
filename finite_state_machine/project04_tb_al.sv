module testbench();
	logic clk, reset, left, right;
	logic s0, l1, l2, l3, r1, r2, r3; 
	logic s0_next, l1_next, l2_next, l3_next, r1_next, r2_next, r3_next;
	logic la, lb, lc, ra, rb, rc;
	
	project04_al dut(.left, .right, .reset, .clk, .la, .lb, .lc, .ra, .rb, .rc);
	
	initial
		forever
			begin
				clk = 0; #50; clk = 1; #50;
			end
	
	initial
		begin
		
			@(negedge clk);  // advance time to first falling edge of clk
			
			// cycle 1: reset to initial state
			reset = 1;
			left = 0;
			right = 0;
			
			@(negedge clk);
			//shoul be at start state: s0
			
			//+++++++++++++++++++++++++++++
			//test self transitions for s0
			//+++++++++++++++++++++++++++++
			
			//cycle 2: don't press anything. 
			reset = 0;
			
			@(negedge clk);
			//Should stay at s0
			
			//cycle 3: press both left and right. 
			
			left = 1;
			right = 1;
			
			@(negedge clk);
			// Should stay at s0
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			// test right turn signal when user pressed right and then released the button
			// right turn signal has to go to completion (cycle 4 - 7)
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			//cycle 4: press right
			left = 0;
			
			@(negedge clk);
			//Should be at r1
			
			//cycle 5: release right button
			right = 0;
			
			@(negedge clk);
			//should be at r2
			
			//cycle 6: right button is still released
			
			@(negedge clk);
			//should be at r3
			
			//cycle 7: everything is off
			
			@(negedge clk);
			//should be at s0
		
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			// test left turn signal when user pressed left and then released the button
			// left turn signal has to go to completion (8-11)
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			//cycle 8: press left
			left = 1;
			
			@(negedge clk);
			//Should be at l1
			
			//cycle 9: release right button
			left = 0;
			
			@(negedge clk);
			//should be at l2
			
			//cycle 10: left button is still released
			
			@(negedge clk);
			//should be at l3
			
			//cycle 11: everything is off
			
			@(negedge clk);
			//should be at s0
			
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			// test right turn signal when user pressed right, then released the right button
			// and presses the left button, then presses both of them
			// right turn signal has to go to completion ignoring the button pressing (cycle 12 - 15)
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			//cycle 12: press right
			right = 1;
			
			@(negedge clk);
			//Should be at r1
			
			//cycle 13: release right button and press left button 
			right = 0;
			left = 1;
			
			@(negedge clk);
			//should be at r2
			
			//cycle 14: right button pressed, left button pressed
			right = 1;
			
			@(negedge clk);
			//should be at r3
			
			//cycle 15: everything is off
			left = 0;
			right = 0;
			
			@(negedge clk);
			//should be at s0
		
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			// test left turn signal when user pressed left and then released the left
			// button and presses the right button, then presses both
			// left turn signal has to go to completion despite buttons being pressed (16-19)
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			//cycle 16: press left
			left = 1;
			
			@(negedge clk);
			//Should be at l1
			
			//cycle 17: release left button and press right
			left = 0;
			right = 1;
			
			@(negedge clk);
			//should be at l2
			
			//cycle 18: left button is pressed and right pressed
			left = 1;
			
			@(negedge clk);
			//should be at l3
			
			//cycle 19: everything is off
			right = 0;
			left = 0;
			
			@(negedge clk);
			//should be at s0
			
			//++++++++++++++++++++++++++++++++++++++++++++++++++++++
			// press right button and keep pressing
			// so that the turn signal will go though 2 repetitions
			// cycle 20 - 27
			//++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			//cycle 20: press right
			right = 1;
			
			@(negedge clk);
			//should be at r1
			
			//cycle 21: keep pressing right button
			
			@(negedge clk);
			//should be at r2
			
			//cycle 22: keep pressing right button
			
			@(negedge clk);
			//should be at r3
			
			//cycle 23: keep pressing right button
			
			@(negedge clk);
			//should return at s0 and go for another cycle
			
			//cycle 24: keep pressing right button
			
			@(negedge clk);
			//should be at r1
			
			//cycle 25: keep pressing right button
			
			@(negedge clk);
			//should be at r2
			
			//cycle 26: keep pressing right button
			
			@(negedge clk);
			//should be at r3
			
			//cycle 27: release  right button
			right = 0;
			
			@(negedge clk);
			//should return at s0 and not go for a second run
			
			//++++++++++++++++++++++++++++++++++++++++++++++++++++++
			// press the left button and keep pressing
			// so that the turn signal will go though 2 repetitions
			// cycle 28 - 35
			//++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			//cycle 28: press left
			left = 1;
			
			@(negedge clk);
			//should be at l1
			
			//cycle 29: keep pressing left button
			
			@(negedge clk);
			//should be at l2
			
			//cycle 30: keep pressing left button
			
			@(negedge clk);
			//should be at l3
			
			//cycle 31: keep pressing left button
			
			@(negedge clk);
			//should return at s0 and go for another cycle
			
			//cycle 32: keep pressing left button
			
			@(negedge clk);
			//should be at l1
			
			//cycle 33: keep pressing left button
			
			@(negedge clk);
			//should be at l2
			
			//cycle 34: keep pressing left button
			
			@(negedge clk);
			//should be at l3
			
			//cycle 35: keep pressing left button
			
			@(negedge clk);
			//should return at s0
			
			//++++++++++++++++++++++++++++++++++++++++++++++
			// test resets from the middle of the pattern
			//+++++++++++++++++++++++++++++++++++++++++++++++
			 
			 //cycle 36: keep pressing left button
			 
			 @(negedge clk);
			 //should be at l1
			 
			 //cycle 37: release left button
			 left = 0;
			 
			 @(negedge clk);
			 //should be at l2
			 
			 //cycle 38: reset 
			 reset = 1;
			 
			 @(negedge clk);
			 //should be at s0
			 
			 //cycle 39: release reset press right
			 reset = 0;
			 right = 1;
			 
			 @(negedge clk);
			 // should be at r1
			 
			 //cycle 40: reset while pressing right
			 reset = 1;
			 
			 @(negedge clk);
			 //should be at s0
			 
			 //cycle 41: keep pressing right while reset
			 
			 @(negedge clk);
			 //should stay  at s0
			 
		end
endmodule