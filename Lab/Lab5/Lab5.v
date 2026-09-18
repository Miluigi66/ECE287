module Lab5 (

	//////////// ADC //////////
	//output		          		ADC_CONVST,
	//output		          		ADC_DIN,
	//input 		          		ADC_DOUT,
	//output		          		ADC_SCLK,

	//////////// Audio //////////
	//input 		          		AUD_ADCDAT,
	//inout 		          		AUD_ADCLRCK,
	//inout 		          		AUD_BCLK,
	//output		          		AUD_DACDAT,
	//inout 		          		AUD_DACLRCK,
	//output		          		AUD_XCK,

	//////////// CLOCK //////////
	//input 		          		CLOCK2_50,
	//input 		          		CLOCK3_50,
	//input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SDRAM //////////
	//output		    [12:0]		DRAM_ADDR,
	//output		     [1:0]		DRAM_BA,
	//output		          		DRAM_CAS_N,
	//output		          		DRAM_CKE,
	//output		          		DRAM_CLK,
	//output		          		DRAM_CS_N,
	//inout 		    [15:0]		DRAM_DQ,
	//output		          		DRAM_LDQM,
	//output		          		DRAM_RAS_N,
	//output		          		DRAM_UDQM,
	//output		          		DRAM_WE_N,

	//////////// I2C for Audio and Video-In //////////
	//output		          		FPGA_I2C_SCLK,
	//inout 		          		FPGA_I2C_SDAT,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	//output		     [6:0]		HEX4,
	//output		     [6:0]		HEX5,

	//////////// IR //////////
	//input 		          		IRDA_RXD,
	//output		          		IRDA_TXD,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	//output		     [9:0]		LEDR,

	//////////// PS2 //////////
	//inout 		          		PS2_CLK,
	//inout 		          		PS2_CLK2,
	//inout 		          		PS2_DAT,
	//inout 		          		PS2_DAT2,

	//////////// SW //////////
	input 		     [9:0]		SW

	//////////// Video-In //////////
	//input 		          		TD_CLK27,
	//input 		     [7:0]		TD_DATA,
	//input 		          		TD_HS,
	//output		          		TD_RESET_N,
	//input 		          		TD_VS,

	//////////// VGA //////////
	//output		          		VGA_BLANK_N,
	//output		     [7:0]		VGA_B,
	//output		          		VGA_CLK,
	//output		     [7:0]		VGA_G,
	//output		          		VGA_HS,
	//output		     [7:0]		VGA_R,
	//output		          		VGA_SYNC_N,
	//output		          		VGA_VS,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	//inout 		    [35:0]		GPIO_0,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	//inout 		    [35:0]		GPIO_1
);

//assign LEDR[9:0] = 10'hFFF;

wire [7:0]val;
assign val = SW[7:0];

wire [6:0]seg7_neg_sign;
wire [6:0]seg7_lsb;
wire [6:0]seg7_msb;
wire [6:0]seg7_hmb;

assign HEX3 = seg7_neg_sign; 
assign HEX2 = seg7_hmb; 
assign HEX1 = seg7_msb; 
assign HEX0 = seg7_lsb; 

reg [3:0] result_one_digit;
reg [3:0] result_ten_digit;
reg [3:0] result_hund_digit;
reg result_is_negative;

reg [7:0]twos_comp;





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