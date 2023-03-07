module FullAdder (A, B, Cin, S, Cout);

	input A, B, Cin;
	output S, Cout;
	
	assign S = A ^ B ^ Cin;
	assign Cout = (A&B) | (A&Cin) | (B&Cin);
	
endmodule 