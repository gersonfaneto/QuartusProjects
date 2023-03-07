module UpdateCounter #(parameter CounterSize = 2)
(
	input wire Clk,
	output reg [(CounterSize - 1):0] Counter = 0
);
	
	always @(posedge Clk) begin
		Counter <= Counter + 1'b1;
	end

endmodule	
