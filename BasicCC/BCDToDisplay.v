module BCDToDisplay (BCD, IsNeg, Signal, FirstDigit, SecondDigit);
	
	input [7:0] BCD;
	input IsNeg;
	output [6:0] FirstDigit, SecondDigit, Signal;

	always @(BCD) begin
		if (IsNeg == 1b'1)
			Signal = 7'b1000000;
		else
			Signal = 7'b0000000;

		if (BCD <= 8'b00001001) begin
			FirstDigit = 7'b0000000;
			case (BCD[3:0]) begin
				4'b0000: SecondDigit = 7'b0111111;
				4'b0001: SecondDigit = 7'b0000110;
				4'b0010: SecondDigit = 7'b1011011;
				4'b0011: SecondDigit = 7'b1001111;
				4'b0100: SecondDigit = 7'b1100110;
				4'b0101: SecondDigit = 7'b1101101;
				4'b0110: SecondDigit = 7'b1111101;
				4'b0111: SecondDigit = 7'b0000111;
				4'b1000: SecondDigit = 7'b1111111;
				4'b1001: SecondDigit = 7'b1101111;
			endcase
		end
		else if (BCD <= 8'b00011001) begin
			FirstDigit = 7'b0000110;
			case (BCD[7:4]) begin
				4'b0000: FirstDigit = 7'b0111111;
				4'b0001: FirstDigit = 7'b0000110;
				4'b0010: FirstDigit = 7'b1011011;
				4'b0011: FirstDigit = 7'b1001111;
				4'b0100: FirstDigit = 7'b1100110;
				4'b0101: FirstDigit = 7'b1101101;
				4'b0110: FirstDigit = 7'b1111101;
				4'b0111: FirstDigit = 7'b0000111;
				4'b1000: FirstDigit = 7'b1111111;
				4'b1001: FirstDigit = 7'b1101111;				
			end
		end
		else begin
			FirstDigit = 7'b0000000;
			SecondDigit = 7'b0000000;
		end
	end
	
endmodule 