module BinaryToBCD (
	// Declaration of I/O
	input [3:0] Bin,
	output [4:0] BCD
);

	// Declaration of Wires
	wire NotA, NotB, NotC, NotD;
	wire A, B, C, D;
	wire [5:0] W;
	
	/* Circuit Description
	(Using Logic Gates Only) */
	or (A, 1'b0, Bin[3]);
	or (B, 1'b0, Bin[2]);
	or (C, 1'b0, Bin[1]);
	or (D, 1'b0, Bin[0]);
	
	not (NotA, A);
	not (NotB, B);
	not (NotC, C);
	not (NotD, D);
	
	// BCD[0] = Bin[0] - (LSB)
	or (BCD[0], 1'b0, D);
	
	// BCD[1] = (A & B & ~C) + (~A & C)
	and (W[0], A, B, NotC);
	and (W[1], NotA, C);
	
	or (BCD[1], W[0], W[1]);
	
	// BCD[2] = (~A & B) + (C & B)
	and (W[2], NotA, B);
	and (W[3], C, B);
	
	or (BCD[2], W[2], W[3]);
	
	// BCD[3] = A & ~B & ~C - (MSB)
	and (BCD[3], A, NotB, NotC);
	
	// BCD[4] = (A & B) + (A & C) ("Overflow")
	and (W[4], A, B);
	and (W[5], A, C);
	
	or (BCD[4], W[4], W[5]);
	
endmodule	