module MagnitudeComparator (A, B, AeqB, AltB, AgtB);

	input [3:0] A, B;
	output AeqB, AltB, AgtB;
	
	wire Eq3, Eq2, Eq1, Eq0;
	
	assign Eq3 = A[3] ~^ B[3];
	assign Eq2 = A[2] ~^ B[2];
	assign Eq1 = A[1] ~^ B[1];
	assign Eq0 = A[0] ~^ B[0];

	assign AeqB = Eq3 & Eq2 & Eq1 & Eq0;
	
	assign AgtB = (A[3] & ~B[3]) |
				  (A[2] & ~B[2] & Eq3) |
				  (A[1] & ~B[1] & Eq3 & Eq2) |
				  (A[0] & ~B[0] & Eq3 & Eq2 & Eq1);
				  
	assign AltB = ~(AeqB | AgtB);
	
endmodule 