module SpotControl (
	input wire [7:0] Selectors,
	output reg [3:0] CurrSpot
);
	
	integer i;
	
	always @(Selectors) begin
		CurrSpot = 4'b0000;
		for (i = 0; i < 8; i = i + 1) begin
			if (Selectors[i] == 1'b1) begin
				CurrSpot = CurrSpot + 1'b1;
			end
		end
	end
	
endmodule	