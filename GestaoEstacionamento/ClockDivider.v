module ClockDivider #(parameter CounterMax = 0)
(
	input wire Clk,
	output reg DivClk = 0
);

	reg [19:0] Counter = 0;

	always @(posedge Clk) begin
		if (Counter == CounterMax) begin
			Counter <= 0;
			DivClk <= ~DivClk;
		end
		else begin
			Counter <= Counter + 1;
		end
	end

endmodule	
