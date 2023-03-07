module BCDToDisplay (
	// Declaration of I/O
	input [3:0] BCD,
	output [6:0] Display
);

	// Declaration of Wires
	wire NotA, NotB, NotC, NotD;
	wire A, B, C, D;
	wire [6:0] Temp;
	wire [9:0] T;
	
	/* Circuit Description
	(Using Logic Gates Only) */
	not (NotA, BCD[3]);
	not (NotB, BCD[2]);
	not (NotC, BCD[1]);
	not (NotD, BCD[0]);
	
	or (A, 1'b0, BCD[3]);
	or (B, 1'b0, BCD[2]);
	or (C, 1'b0, BCD[1]);
	or (D, 1'b0, BCD[0]);
	
	and (T[0], B, D);
	and (T[1], NotB, NotD);
	and (T[2], C, D);
	and (T[3], NotC, NotD);
	and (T[4], NotB, NotD);
	and (T[5], NotB, C);
	and (T[6], C, NotD);
	and (T[7], B, NotC, D);
	and (T[8], B, NotC);
	and (T[9], B, NotD);
	
	/* Display[6] -> Display[0] == SegA -> SegG  (Inverted Logic)*/
	
	// SegA = A + C + (B & D) + (~B & ~D)
	or (Temp[6], A, C, T[0], T[1]);
	not (Display[6], Temp[6]);

	// SegB = ~B + (C & D) + (~C & ~D)
	or (Temp[5], NotB, T[2], T[3]);
	not (Display[5], Temp[5]);
	
	// SegC = B + ~C + D
	or (Temp[4], B, NotC, D);
	not (Display[4], Temp[4]);
	
	// SegD = A + (~B & ~D) + (~B & C) + (C & ~D) + (B & ~C & D) 
	or (Temp[3], A, T[4], T[5], T[6], T[7]);
	not (Display[3], Temp[3]);
	
	// SegE = (~B & ~D) + (C & ~D)
	or (Temp[2], T[1], T[6]);
	not (Display[2], Temp[2]);
	
	// SegF = A + (B & ~C) + (B & ~D)
	or (Temp[1], A, T[3], T[8], T[9]);
	not (Display[1], Temp[1]);
	
	// SegG = A + (~B & C) + (B & ~C) + (C & ~D)
	or (Temp[0], A, T[5], T[8], T[6]);
	not (Display[0], Temp[0]);
	
endmodule	