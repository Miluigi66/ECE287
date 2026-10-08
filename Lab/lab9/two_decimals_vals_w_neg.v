module two_decimals_vals_w_neg (
	input [7:0]val, output [6:0]seg7_neg_signn, output [6:0]seg7_lsb, output[6:0]seg7_msb , output[6:0]seg7_hmb
);

//assign LEDR[9:0] = 10'hFFF;


reg [3:0] result_one_digit;
reg [3:0] result_ten_digit;
reg [3:0] result_hund_digit;
reg result_is_negative;


    wire [7:0] absval;

    assign absval = (result_is_negative) ? (-val) : val;


/* convert the binary value into 3 signals of negative, one and ten digit */
always @(*)
begin

	  result_one_digit = (absval % 10) & 4'hf;
	  
	  
	  result_ten_digit = ((absval / 10) % 10) & 4'hf;
	  
	  
	  result_hund_digit = (absval / 100) & 4'hf;
	  
	  
	  result_is_negative = val[7];
end


/* instantiate the modules for each of the seven seg decoders including the negative one */
seven_segment useHex0(
	.i (result_one_digit),
	.o (seg7_lsb)
);
seven_segment useHex1(
	.i (result_ten_digit),
	.o (seg7_msb)
);
seven_segment useHex2(
	.i (result_hund_digit),
	.o (seg7_hmb)
);
seven_segment_negative useHex3(
	.i (result_is_negative),
	.o (seg7_neg_sign)
);

endmodule
