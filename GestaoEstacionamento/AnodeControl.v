module AnodeControl (
	input wire [1:0] Counter,
	output reg [3:0] Anodes = 0
);

	always @(Counter) begin
		case(Counter)
			2'b00:
				Anodes = 4'b1110;
			2'b01:
				Anodes = 4'b1101;
			2'b10:
				Anodes = 4'b1011;
			2'b11:
				Anodes = 4'b0111;
		endcase
	end 

endmodule	
