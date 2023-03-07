module Multiplexer4X1 (In0, In1, In2, In3, S0, S1, Out);

	input In0, In1, In2, In3, S0, S1;
	output Out;
	
	wire NotS0 = ~S0;
	wire NotS1 = ~S1;
	
	assign Out = (NotS0 & NotS1 & In0) | 
				 (S0 & NotS1 & In1) | 
				 (NotS0 & S1 & In2) | 
				 (S0 & S1 & In3);

endmodule 