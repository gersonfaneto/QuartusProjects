module PasswordCheck (
	input wire Clk,
	input wire SelectValue,
	input wire ConfirmButton,
	input wire StartValidation,
	output reg DisplayValue,
	output reg [1:0] DisplayIndex,
	output reg CurrPass,
	output reg WrongPass,
	output reg TimeOut
);

	parameter CorrectPassword = 4'b1001;
	
	reg [5:0] Timer;
	reg [1:0] State;
	reg CurrValue;
	
	wire DB_SelectValue, DB_ConfirmButton, DivClk;
	
	initial begin
		Timer = 6'b000000;
		State = 2'b00;
		CurrValue = 1'b0;
		DisplayValue = 1'b0;
		DisplayIndex = 2'b00;
		CurrPass = 1'b0;
		WrongPass = 1'b0;
		TimeOut = 1'b0;
	end
	
	ClockDivider #(.CounterMax(24999999), .CounterSize(25)) CD0 
	(
		.Clk(Clk),
		.DivClk(DivClk)
	);
		
	ButtonDebouncer BD0 (
		.ButtonIn(SelectValue),
		.Clk(Clk),
		.ButtonOut(DB_SelectValue)
	);

	ButtonDebouncer BD1 (
		.ButtonIn(ConfirmButton),
		.Clk(Clk),
		.ButtonOut(DB_ConfirmButton)
	);
	
	always @(posedge DivClk) begin
		if (StartValidation == 1'b1 && State != 2'b00) begin
			if (Timer == 6'b010100) begin
				Timer <= 0;
				TimeOut <= 1'b1;
			end
			else begin
				Timer <= Timer + 1'b1;
			end
		end
		else begin
			TimeOut <= 1'b0;
			Timer <= 6'b000000;
		end
	end

	always @(posedge Clk) begin
		if (StartValidation == 1'b1) begin
			DisplayIndex <= State;
			DisplayValue <= CurrValue;
		end
		else begin
			DisplayIndex <= 2'b00;
			DisplayValue <= 1'b0;
		end
	end
	
	always @(posedge DB_SelectValue) begin
		if (StartValidation == 1'b1) begin
			CurrValue <= ~CurrValue;
		end
		else begin
			CurrValue <= 1'b0;
		end
	end
	
	always @(posedge DB_ConfirmButton) begin
		if (StartValidation == 1'b1) begin
			if (CurrPass == 1'b1 || WrongPass == 1'b1 || TimeOut == 1'b1) begin
				State <= 2'b00;
			end
			case(State)
				2'b00:
					if (CurrValue == CorrectPassword[0]) begin
						State <= 2'b01;
					end
					else begin
						WrongPass <= (Timer == 6'b000000) ? 1'b0 : 1'b1;
					end
				2'b01:
					if (CurrValue == CorrectPassword[1]) begin
						State <= 2'b10;
					end
					else begin
						WrongPass <= (TimeOut == 1'b1) ? 1'b0 : 1'b1;
					end
				2'b10:
					if (CurrValue == CorrectPassword[2]) begin
						State <= 2'b11;
					end
					else begin
						WrongPass <= (TimeOut == 1'b1) ? 1'b0 : 1'b1;
					end
				2'b11:
					if (CurrValue == CorrectPassword[3]) begin
						CurrPass <= 1'b1;
					end
					else begin
						WrongPass <= (TimeOut == 1'b1) ? 1'b0 : 1'b1;
					end
			endcase
		end
		else begin
			State <= 2'b00;
			WrongPass <= 1'b0;
			CurrPass <= 1'b0;
		end
	end
	
endmodule	
