module Multiplexer2X1 (In0, In1, S, Out);

	input In0, In1, S;
	output Out;
	
	assign Out = (S & In0) | (~S & In1); 

endmodule 