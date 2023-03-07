module CathodesControl (
	input [3:0] Digit,
	output reg [7:0] Cathodes
);

	always @(Digit) begin
		case(Digit)
			4'b0000:
				Cathodes = 8'b00000011; // 0
			4'b0001:
				Cathodes = 8'b10011111; // 1
			4'b0010: 
				Cathodes = 8'b00100101; // 2
			4'b0011:
				Cathodes = 8'b00001101; // 3
			4'b0100:
				Cathodes = 8'b10011001; // 4
			4'b0101:
				Cathodes = 8'b01001001; // 5
			4'b0110:
				Cathodes = 8'b01000001; // 6
			4'b0111:
				Cathodes = 8'b00011111; // 7
			4'b1000:
				Cathodes = 8'b00000001; // 8
			4'b1001:
				Cathodes = 8'b01110000; // F.
			4'b1010: 
				Cathodes = 8'b01100000; // E.
			4'b1011:
				Cathodes = 8'b01001000; // S.
			default:
				Cathodes = 8'b11111111; // OFF
		endcase
	end

endmodule	
