module FullAdder4Bits (A, B, Cin, S, Cout);

	input [3:0] A, B;
	input Cin;
	output [3:0] S;
	output Cout;

	wire [2:0] Wire;
 	
	FullAdder F1 (.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(Wire[0]));
	FullAdder F2 (.A(A[1]), .B(B[1]), .Cin(Wire[0]), .S(S[1]), .Cout(Wire[1]));
	FullAdder F3 (.A(A[2]), .B(B[2]), .Cin(Wire[1]), .S(S[2]), .Cout(Wire[2]));
	FullAdder F4 (.A(A[3]), .B(B[3]), .Cin(Wire[2]), .S(S[3]), .Cout(Cout));
	
endmodule 