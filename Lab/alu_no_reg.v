module add_sub (

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
	//input 		          		CLOCK_50,

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
	output		     [9:0]		LEDR,

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

//	Turn on all display
	//assign	HEX0		=	7'h00;
	//assign	HEX1		=	7'h00;
	//assign	HEX2		=	7'h00;
	//assign	HEX3		=	7'h00;
	//assign	HEX4		=	7'h00;
	//assign	HEX5		=	7'h00;
	//assign	GPIO_0		=	36'hzzzzzzzzz;
	//assign	GPIO_1		=	36'hzzzzzzzzz;
	//assign LEDR[9:0] = 10'd0;

wire [4:0]input_a;
wire [4:0]input_b;
wire [6:0]seg7_neg_sign;
wire [6:0]seg7_lsb;
wire [6:0]seg7_msb;


reg [4:0]result;

assign HEX0 = seg7_lsb;
assign HEX1 = seg7_msb;
assign HEX3 = seg7_neg_sign;
	
assign input_a = SW[4:0];
assign input_b = SW[9:5];
	
/* create the module to display the 8 bit result */
always @(*) begin
	case(~KEY)
		3'b000: result = input_a + input_b;
		3'b001: result = input_a - input_b;
		3'b010: result = ((input_a[4] == input_b[4]) ?
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


assign LEDR[4:0] = result;
two_decimals_vals_w_neg pos(
		.val (result),
		.seg7_neg_sign (seg7_neg_sign),
		.seg7_lsb(seg7_lsb),
		.seg7_msb(seg7_msb),
		.seg7_hmb(HEX2)
	);
	

endmodule