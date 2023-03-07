module FullSubtractor4Bits (A, B, Bin, D, Bout);

	input [3:0] A, B;
	input Bin;
	output [3:0] D;
	output Bout;
	
	wire [2:0] Wire;
	
	FullSubtractor D1 (.A(A[0]), .B(B[0]), .Bin(Bin), .D(D[0]), .Bout(Wire[0]));
	FullSubtractor D2 (.A(A[1]), .B(B[1]), .Bin(Wire[0]), .D(D[1]), .Bout(Wire[1]));
	FullSubtractor D3 (.A(A[2]), .B(B[2]), .Bin(Wire[1]), .D(D[2]), .Bout(Wire[2]));
	FullSubtractor D4 (.A(A[3]), .B(B[3]), .Bin(Wire[2]), .D(D[3]), .Bout(Bout));	

endmodule 