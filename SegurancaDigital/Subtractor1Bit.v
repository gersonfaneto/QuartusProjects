module Subtractor1Bit (
	// Declaration of I/O
	input A, B, Bin,
	output D, Bout
);

	// Declaration of Wires
	wire [4:0] T;
	wire NotA;
	
	/* Circuit Description 
	(Using Logic Gates Only) */

	// Diff Bit Calculation
	xor (T[0], A, B);
	xor (D, T[0], Bin);
	
	// Borrow Bit Calculation
	not (NotA, A);
	
	and (T[1], NotA, B);
	and (T[2], NotA, Bin);
	and (T[3], B, Bin);
	
	or (Bout, T[1], T[2], T[3]);
	
endmodule	