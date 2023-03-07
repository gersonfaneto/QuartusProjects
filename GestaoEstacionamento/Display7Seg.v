module Display7Seg (
	input wire Clk,
	input wire DisplayMode,
	input wire [3:0] Empty,
	input wire [3:0] Full,
	input wire [3:0] SelectedSpot,
	output wire [3:0] Anodes,
	output wire [7:0] Cathodes
);

	wire DivClk;
	wire [1:0] Counter;
	wire [3:0] Digit;
	reg [3:0] FiD, SeD, ThD, FoD;

	always @(DisplayMode) begin
		if (DisplayMode == 1'b1) begin
			FiD = SelectedSpot;
			SeD = 4'b1111;
			ThD = 4'b1111;
			FoD = 4'b1011;
		end
		else begin
			FiD = Empty;
			SeD = 4'b1010;
			ThD = Full;
			FoD = 4'b1001;
		end
	end

	ClockDivider #(.CounterMax(104165)) CD0 
	(
		.Clk(Clk), 
		.DivClk(DivClk)
	);
	
	UpdateCounter #(.CounterSize(2)) UC0
	(
		.Clk(DivClk),
		.Counter(Counter)
	);
	
	AnodeControl AC0 (
		.Counter(Counter),
		.Anodes(Anodes)
	);
	
	DigitControl DC0 (
		.Counter(Counter),
		.FiD(FiD),
		.SeD(SeD),
		.ThD(ThD),
		.FoD(FoD),
		.ActiveDigit(Digit)
	);	
	
	CathodesControl CC0 (
		.Digit(Digit),
		.Cathodes(Cathodes)
	);
						  
endmodule	
