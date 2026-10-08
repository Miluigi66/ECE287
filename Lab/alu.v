module alu(
input [7:0]input_a,
input [7:0]input_b,
input [2:0]alu_control,
output reg[7:0]result);

/* build the alu */
always @(*) begin
	case(~KEY)
		3'b000: result = input_a + input_b;
		3'b001: result = input_a - input_b;
		3'b010: result = ((input_a[7] == input_b[7]) ?
			((input_a > input_b) ? 1 : 0):
			((input_a > input_b) ? 0 : 1));
		3'b011: result = ((input_a == input_b) ? 1 : 0);
		3'b100: result = input_a ^ input_b;
		3'b101: result = input_a & input_b;
		3'b110: result = input_a | input_b;
		3'b111: result = ~input_a;
		default: result = 6;
	endcase
		
end

endmodule
