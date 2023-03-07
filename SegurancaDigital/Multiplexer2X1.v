module Multiplexer2X1 (
	// Declaration of I/O
	input In0, In1, S,
	output Out
);

	// Declaration of Wires
	wire [1:0] W;
	wire NotS;
	
	/* Circuit Description
	(Using Logic Gates Only) */

	/* If S Then 
		In0 
	   Else In1 */
	
	not (NotS, S);
	
	and (W[0], In0, S);
	and (W[1], In1, NotS);
	
	or (Out, W[0], W[1]);

endmodule	