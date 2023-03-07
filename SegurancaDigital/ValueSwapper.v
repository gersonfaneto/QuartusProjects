module ValueSwapper (
	// Declaration of I/O
	input toSwap,
	input [3:0] A, B,
	output [3:0] X, Y
);

	/* Circuit Description
	(Using Instantiation) */
	
	/* If toSwap then
	     X, Y = B, A
	   Else
		 X, Y = A, B */
		 
	Multiplexer2X1 Mux0 (.In0(B[3]), .In1(A[3]), .S(toSwap), .Out(X[3]));
	Multiplexer2X1 Mux1 (.In0(B[2]), .In1(A[2]), .S(toSwap), .Out(X[2]));
	Multiplexer2X1 Mux2 (.In0(B[1]), .In1(A[1]), .S(toSwap), .Out(X[1]));
	Multiplexer2X1 Mux3 (.In0(B[0]), .In1(A[0]), .S(toSwap), .Out(X[0]));

	Multiplexer2X1 Mux4 (.In0(A[3]), .In1(B[3]), .S(toSwap), .Out(Y[3]));
	Multiplexer2X1 Mux5 (.In0(A[2]), .In1(B[2]), .S(toSwap), .Out(Y[2]));
	Multiplexer2X1 Mux6 (.In0(A[1]), .In1(B[1]), .S(toSwap), .Out(Y[1]));	
	Multiplexer2X1 Mux7 (.In0(A[0]), .In1(B[0]), .S(toSwap), .Out(Y[0]));	

endmodule	