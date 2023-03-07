module DisplayControl (
	input wire Clk,
	input wire DisplayValue,
	input wire [1:0] DisplayIndex,
	input wire [3:0] DisplayMode,
	output wire [3:0] Anodes,
	output wire [7:0] Cathodes
);

	wire DivClk;
	wire [1:0] Counter;
	wire [3:0] Digit;
	reg [3:0] FiD, SeD, ThD, FoD;

	always @(DisplayMode) begin
		if (DisplayMode == 3'b000) begin
			case(DisplayIndex)
				2'b00: begin
					FiD <= 4'b0000 + DisplayValue;
					SeD <= 4'b0101;
					ThD <= 4'b0101;
					FoD <= 4'b0101;
				end
				2'b01: begin
					SeD <= 4'b0000 + DisplayValue;
					FiD <= 4'b0101;
					ThD <= 4'b0101;
					FoD <= 4'b0101;
				end
				2'b10: begin
					ThD <= 4'b0000 + DisplayValue;
					FiD <= 4'b0101;
					SeD <= 4'b0101;
					FoD <= 4'b0101;
				end
				2'b11: begin
					FoD <= 4'b0000 + DisplayValue;
					FiD <= 4'b0101;
					SeD <= 4'b0101;
					ThD <= 4'b0101;
				end
			endcase
		end
		else if (DisplayMode == 3'b001) begin
					FiD <= 4'b0010;
					SeD <= 4'b1111;
					ThD <= 4'b1111;
					FoD <= 4'b1111;
		end
		else if (DisplayMode == 3'b010) begin
					FiD <= 4'b0011;
					SeD <= 4'b1111;
					ThD <= 4'b1111;
					FoD <= 4'b1111;
		end
		else if (DisplayMode == 3'b011) begin
					FiD <= 4'b0100;
					SeD <= 4'b1111;
					ThD <= 4'b1111;
					FoD <= 4'b1111;
		end
		else if (DisplayMode == 3'b100) begin
					FiD <= 4'b0110;
					SeD <= 4'b1111;
					ThD <= 4'b1111;
					FoD <= 4'b1111;
		end
		else begin
			FiD <= 4'b1111;
			SeD <= 4'b1111;
			ThD <= 4'b1111;
			FoD <= 4'b1111;
		end
	end

	ClockDivider #(.CounterMax(104165), .CounterSize(17)) CD0 
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
