module BinaryToBCD (Binary, FirstDigit, SecondDigit);

	input [3:0] Binary;
	output reg [3:0] FirstDigit, SecondDigit;
	
	always @(Binary) begin
		if (Binary <= 4'b1001) begin
			SecondDigit = Binary;
			FirstDigit = 4'b0000;
		end
		else if (Binary <= 4'b1111) begin
			FirstDigit = 4'b0001;
			case (Binary)
				4'b1010: SecondDigit = 4'b0000;
				4'b1011: SecondDigit = 4'b0001;
				4'b1100: SecondDigit = 4'b0010;
				4'b1101: SecondDigit = 4'b0011;
				4'b1110: SecondDigit = 4'b0100;
				4'b1111: SecondDigit = 4'b0101;
			endcase
		end
		else begin
			FirstDigit = 4'b0000;
			SecondDigit = 4'b0000;
		end
	end

endmodule 