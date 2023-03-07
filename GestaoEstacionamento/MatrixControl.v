module MatrixControl (
	input wire Clk,
	input wire [7:0] SpotsControl,
	output reg [6:0] RowSignal,
	output reg [1:0] ColumnSignal
);
	
	wire DivClk;
	reg Control;
	
	initial begin
		RowSignal = 7'b1001001;
		ColumnSignal = 2'b11;
		Control = 1'b0;
	end
	
	ClockDivider #(.CounterMax(166665)) CD0 
	(
		.Clk(Clk),
		.DivClk(DivClk)
	);
	
	always @(posedge DivClk) begin
		ColumnSignal[0] <= |(SpotsControl[3:0]);
		ColumnSignal[1] <= |(SpotsControl[7:4]);
		case (Control)
			1'b0: begin
				RowSignal[1] <= ~SpotsControl[0];
				RowSignal[2] <= ~SpotsControl[1];
				RowSignal[4] <= ~SpotsControl[2];
				RowSignal[5] <= ~SpotsControl[3];
			end
			1'b1: begin
				RowSignal[1] <= ~SpotsControl[4];
				RowSignal[2] <= ~SpotsControl[5];
				RowSignal[4] <= ~SpotsControl[6];
				RowSignal[5] <= ~SpotsControl[7];
			end
		endcase
		Control <= Control + 1;
	end

endmodule	
