module Lab2 (input [3:0]SW, output [1:0]LEDR);
	assign LEDR[0] = (SW[0] + SW[1] + SW[2] + SW[3] == 1) | (SW[0] + SW[1] + SW[2] + SW[3] == 3);
	
	assign LEDR[1] = (LEDR[0] + SW[0] + SW[1] + SW[2] + SW[3] >= 3);
	
	//(SW[0] & ~SW[1])|(~SW[0] & SW[1]);
endmodule
