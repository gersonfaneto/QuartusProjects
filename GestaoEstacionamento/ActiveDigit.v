module ActiveDigit (
	input [3:0] FirstDigit,  // (Right Most) Ones
	input [3:0] SecondDigit, // Tens
	input [3:0] ThirdDigit,  // Hundreds
	input [3:0] FourthDigit, // (Left Most) Thousands
	input [1:0] Counter,
	output reg [3:0] ActiveDigit
);

	always @(Counter) begin
		case(Counter)
			2'b00:
				ActiveDigit = FirstDigit; // 1º Digit ON (Right Most)
			2'b01:
				ActiveDigit = SecondDigit; // 2º Digit ON
			2'b10:
				ActiveDigit = ThirdDigit; // 3º Digit ON
			2'b11:
				ActiveDigit = FourthDigit; // 4º Digit ON (Left Most)
		endcase
	end 

endmodule	
