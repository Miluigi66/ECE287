module gte_4bits(input [3:0]a, input[3:0]b, output reg c);
	always@(*) begin
	
	c = a[3] | !b[3]&a[2] | !b[3]&!b[2]&a[1] | !b[3]&!b[2]&!b[1]&a[0]; //| !b[3]&!b[2]&!b[1]!b[0]&a;
	
	end
endmodule