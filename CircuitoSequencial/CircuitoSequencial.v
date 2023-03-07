module CircuitoSequencial (
	input wire Clk,
	input wire SelectValue,
	input wire ConfirmButton,
	input wire ProximitySensor,
	input wire EntrySensor,
	output wire [3:0] Anodes,
	output wire [7:0] Cathodes,
	output wire BlinkBlueLED,
	output wire BlinkRedLED,
	output wire BlinkGreenLED,
	output wire [2:0] DisplayState
);

	wire [1:0] DisplayIndex;	
	wire DisplayValue;
	wire StartValidation, TimeOut;
	wire WrongPass, CurrPass;
	
	reg [2:0] DisplayMode;
	reg [3:0] QntSpots;
	reg [2:0] State;
	reg CurrSignal, WrongSignal;
	reg WaitSignal;
	
	initial begin
		State = 3'b000;
		WrongSignal = 1'b0;
		CurrSignal = 1'b0;
		WaitSignal = 1'b0;
		QntSpots = 4'b0000;
		DisplayMode = 3'b111;
	end

	assign StartValidation = ProximitySensor & ~EntrySensor & State[0];
	assign BlinkBlueLED = WaitSignal & DivClk & ~TimeOut & (State[1:0] == 2'b11);
	assign BlinkGreenLED = CurrSignal & CurrPass & ~TimeOut & ~WrongSignal;
	assign BlinkRedLED = (WrongSignal | WrongPass) & ~TimeOut & ~CurrSignal;
	
	assign DisplayState = State;
	
	PasswordCheck PC0 (
		.Clk(Clk),
		.StartValidation(StartValidation),
		.SelectValue(SelectValue),
		.ConfirmButton(ConfirmButton),
		.DisplayValue(DisplayValue),
		.DisplayIndex(DisplayIndex),
		.CurrPass(CurrPass),
		.WrongPass(WrongPass),
		.TimeOut(TimeOut)
	);
	
	DisplayControl DC (
		.Clk(Clk),
		.DisplayValue(DisplayValue),
		.DisplayIndex(DisplayIndex),
		.DisplayMode(DisplayMode),
		.Anodes(Anodes),
		.Cathodes(Cathodes)
	);
	
	ClockDivider #(.CounterMax(24999999), .CounterSize(25)) CD0 
	(
		.Clk(Clk),
		.DivClk(DivClk)
	);
	
	always @(posedge DivClk) begin
		case(State)
			3'b000:
				if (QntSpots == 4'b0100) begin
					State = 3'b100;
					WrongSignal = 1'b1;
				end
				else if (ProximitySensor == 1'b1 && EntrySensor == 1'b0) begin
					State = 3'b001;
					WrongSignal = 1'b0;
					CurrSignal = 1'b0;
					WaitSignal = 1'b0;
				end
			3'b001:
				if (ProximitySensor == 1'b0) begin
					State = 3'b000;
				end
				else if (ProximitySensor == 1'b1 && CurrPass == 1'b1) begin
					State = 3'b010;
					CurrSignal = 1'b1;
				end
			3'b010:
				if (ProximitySensor == 1'b0 && EntrySensor == 1'b1) begin
					State = 3'b000;
					QntSpots = QntSpots + 1'b1;
				end
				else if (ProximitySensor == 1'b1 && EntrySensor == 1'b1) begin
					State = 3'b011;
					WaitSignal = 1'b1;
				end
			3'b011:
				if (ProximitySensor == 1'b1 && EntrySensor == 1'b0) begin
					State = 3'b001;
				end
			3'b100:
				if (QntSpots != 4'b0100) begin
					State = 3'b000;
				end
		endcase
	end
	
	always @* begin
		if (State == 3'b000) begin
			DisplayMode <= 3'b100;
		end
		else if (State == 3'b001) begin
			DisplayMode <= 3'b000;
		end
		else if (QntSpots ==  4'b0100) begin
			DisplayMode <= 3'b001;
		end
		else if (WrongSignal == 1'b1) begin
			DisplayMode <= 3'b010;
		end
		else if (WaitSignal == 1'b1) begin
			DisplayMode <= 3'b011;
		end
		else begin
			DisplayMode <= 3'b111;
		end
	end
	
endmodule	