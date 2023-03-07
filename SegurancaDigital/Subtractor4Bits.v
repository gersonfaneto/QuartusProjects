module Subtractor4Bits (
	// Declaration of I/O
	input [3:0] A, B,
	input Bin,
	output [3:0] D,
	output Bout
);

	// Declaration of Wires
	wire [2:0] T;
	
	/* Circuit Description
	(Using Instantiation)*/
	Subtractor1Bit D0 (.A(A[0]), .B(B[0]), .Bin(Bin), .D(D[0]), .Bout(T[0]));
	Subtractor1Bit D1 (.A(A[1]), .B(B[1]), .Bin(T[0]), .D(D[1]), .Bout(T[1]));
	Subtractor1Bit D2 (.A(A[2]), .B(B[2]), .Bin(T[1]), .D(D[2]), .Bout(T[2]));
	Subtractor1Bit D3 (.A(A[3]), .B(B[3]), .Bin(T[2]), .D(D[3]), .Bout(Bout));
	
endmodule	