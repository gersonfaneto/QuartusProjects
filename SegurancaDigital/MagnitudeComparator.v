module MagnitudeComparator (
	// Declaration of I/O
	input [3:0] A, B,
	output AeqB, AltB, AgtB
);

	// Declaration of Wires
	wire [3:0] NotB;
	wire [7:0] T;
	
	/* Circuit Description
	(Using Logic Gates Only) */
	
	// First Case: A == B
	xnor (T[3], A[3], B[3]);
	xnor (T[2], A[2], B[2]);
	xnor (T[1], A[1], B[1]);
	xnor (T[0], A[0], B[0]);
	
	and (AeqB, T[3], T[2], T[1], T[0]);
	
	// Second Case: A > B
	not (NotB[3], B[3]);
	not (NotB[2], B[2]);
	not (NotB[1], B[1]);
	not (NotB[0], B[0]);
	
	and (T[4], A[3], NotB[3]);
	and (T[5], A[2], NotB[2], T[3]);
	and (T[6], A[1], NotB[1], T[3], T[2]);
	and (T[7], A[0], NotB[0], T[3], T[2], T[1]);
	
	or (AgtB, T[4], T[5], T[6], T[7]);
	
	// Third Case: A < B
	nor (AltB, AeqB, AgtB);
	
endmodule	