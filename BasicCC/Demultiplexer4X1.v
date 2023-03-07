module Demultiplexer4X1 (In, S0, S1, Out0, Out1, Out2, Out3);

	input In, S0, S1;
	output Out0, Out1, Out2, Out3;
	
	wire NotS0 = ~S0;
	wire NotS1 = ~S1;
	
	assign Out0 = (NotS0 & NotS1 & In);
	assign Out1 = (S0 & NotS1 & In);
	assign Out2 = (NotS0 & S1 & In); 
	assign Out3 = (S0 & S1 & In);

endmodule 