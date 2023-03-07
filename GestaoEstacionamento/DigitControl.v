module DigitControl (
	input wire [3:0] FiD,
	input wire [3:0] SeD,
	input wire [3:0] ThD,
	input wire [3:0] FoD,
	input wire [1:0] Counter,
	output reg [3:0] ActiveDigit = 0
);

	always @(Counter) begin
		case(Counter)
			2'b00:
				ActiveDigit = FiD;
			2'b01:
				ActiveDigit = SeD;
			2'b10:
				ActiveDigit = ThD;
			2'b11:
				ActiveDigit = FoD;
		endcase
	end

endmodule	