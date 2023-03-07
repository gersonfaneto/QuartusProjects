module CathodesControl (
	input [3:0] Digit,
	output reg [7:0] Cathodes
);

	always @(Digit) begin
		case(Digit)
			4'b0000:
				Cathodes = 8'b00000010; // 0.
			4'b0001: 
				Cathodes = 8'b10011110; // 1.
			4'b0010:
				Cathodes = 8'b01110000; // F.
			4'b0011: 
				Cathodes = 8'b01100000; // E.
			4'b0100:
				Cathodes = 8'b01001000; // S.
			4'b0101:
				Cathodes = 8'b00000011; // 0
			4'b0110:
				Cathodes = 8'b10010000; // H.
			default:
				Cathodes = 8'b11111111; // OFF
		endcase
	end

endmodule	
