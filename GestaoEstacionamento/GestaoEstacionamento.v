module GestaoEstacionamento (
	input wire Clk,
	input wire InSensor,
	input wire OutSensor,
	input wire [7:0] DIP,
	output reg [2:0] TrafficSign,
	output wire [7:0] Cathodes, 
	output wire [3:0] Anodes,
	output wire [6:0] RowSignal,
	output wire [1:0] ColumnSignal
);

	reg SuccessIn, SuccessOut, DisplayMode;
	reg [3:0] QntFull, QntTotal;
	reg [7:0] CarSpots;
	wire [3:0] SelectedSpot;
	
	initial begin
		CarSpots = 8'b11111111;
		TrafficSign = 3'b001;
		DisplayMode = 1'b0;
		QntFull = 4'b0000;
		QntTotal = 4'b1000;
	end
	
	SpotControl SC0 (
		.Selectors(DIP),
		.CurrSpot(SelectedSpot)
	);

	always @(SelectedSpot) begin
		if (SelectedSpot != 4'b0000) begin
			DisplayMode = 1'b1;
		end
		else begin
			DisplayMode = 1'b0;
		end
	end

	always @(negedge InSensor) begin
		if (CarSpots[SelectedSpot - 1] == 1'b1) begin
			SuccessIn = 1'b1;
		end
		else begin
			SuccessIn = 1'b0;
		end
	end
	
	always @(negedge OutSensor) begin
		if (CarSpots[SelectedSpot - 1] == 1'b0) begin
			SuccessOut = 1'b1;
		end
		else begin
			SuccessOut = 1'b0;
		end
	end

	always @(SuccessIn or SuccessOut) begin
		if (SuccessIn != 1'b1 || SuccessOut != 1'b1) begin
			TrafficSign = 3'b100;
			if (SuccessIn == 1'b1) begin
				QntFull = QntFull + 1;
			end
			else begin
				QntFull = QntFull - 1;
			end
		end
		else begin
			TrafficSign = 3'b010;
		end
	end
	
	Display7Seg DS0 (
		.Clk(Clk),
		.Empty((QntTotal - QntFull)),
		.Full(QntFull),
		.SelectedSpot(SelectedSpot),
		.DisplayMode(DisplayMode),
		.Anodes(Anodes),
		.Cathodes(Cathodes)
	);
	
	MatrixControl MC0 (
		.Clk(Clk),
		.SpotsControl(SpotControl),
		.RowSignal(RowSignal),
		.ColumnSignal(ColumnSignal)
	);
					 
endmodule	