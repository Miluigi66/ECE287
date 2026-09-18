module add_4bits(input [3:0]a, input[3:0]b, output [3:0]c);
    wire [3:0] G; // Carry Generate
    wire [3:0] P; // Carry Propagate
    wire [3:1] C; // Internal Carries
	
		 // Calculate Propagate and Generate logic for each bit
		 assign P = a ^ b;
		 assign G = a & b;

		 // Carry Lookahead Logic (Flattened equations instead of rippling)
		 assign C[1] = G[0];
		 assign C[2] = G[1] | (P[1] & G[0]);
		 assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]);

		 // Calculate the final Sum bits
		 assign c[0] = P[0];
		 assign c[1] = P[1] ^ C[1];
		 assign c[2] = P[2] ^ C[2];
		 assign c[3] = P[3] ^ C[3];
	  
endmodule 