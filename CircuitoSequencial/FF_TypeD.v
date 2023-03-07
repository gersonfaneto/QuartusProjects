module FF_TypeD (
	input wire Clk,
	input wire D,
	output reg Q,
	output reg NotQ
);

	always @(posedge Clk) begin
		Q <= D;
		NotQ <= ~Q;
	end

endmodule	