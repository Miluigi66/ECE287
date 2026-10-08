module seven_segment_negative(i,o);

input i;
output reg [6:0]o; // a, b, c, d, e, f, g

always @(*)
begin
	case (i)	    // abcdefg
	/*
		 4'b0000: HEX0 = 7'b1111111; // 0
		 4'b0001: HEX0 = 7'b0111111; // 1
		 4'b0010: HEX0 = 7'b1111111; // 2
		 4'b0011: HEX0 = 7'b0111111; // 3
		 4'b0100: HEX0 = 7'b1111111; // 4
		 4'b0101: HEX0 = 7'b0111111; // 5
		 4'b0110: HEX0 = 7'b1111111; // 6
		 4'b0111: HEX0 = 7'b0111111; // 7
		 4'b1000: HEX0 = 7'b1111111; // 8
		 4'b1001: HEX0 = 7'b0111111; // 9
		 4'b1010: HEX0 = 7'b1111111; // A
		 4'b1011: HEX0 = 7'b0111111; // b
		 4'b1100: HEX0 = 7'b1111111; // C
		 4'b1101: HEX0 = 7'b0111111; // d
		 4'b1110: HEX0 = 7'b1111111; // E
		 4'b1111: HEX0 = 7'b0111111; // F
		 default: HEX0 = 7'b1111111; // 0
		 */
		 1'b0: o = 7'b1111111; // 0
		 1'b1: o = 7'b0111111; // 1
		 default: o = 7'b1111111; // 0
	 endcase
end

endmodule