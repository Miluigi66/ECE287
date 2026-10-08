module register(
input clk, 
input rst, 
input [7:0]in, 
input en, 
output reg [7:0]out);

/* enable (en) based register */

always @(posedge clk or negedge rst) begin
	
	if(rst==0) begin
		out = 8'h00;
	end else if (en) begin
		out = in;
end


endmodule
