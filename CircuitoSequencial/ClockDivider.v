module ClockDivider #(parameter CounterMax = 0, CounterSize = 0)
(
	input wire Clk,
	output reg DivClk = 0
);

	reg [(CounterSize - 1):0] Counter;
	
	always @(posedge Clk) begin
		if (Counter == CounterMax) begin
			Counter <= 0;
			DivClk <= ~DivClk;
		end
		else begin
			Counter <= Counter + 1'b1;
		end
	end

endmodule	