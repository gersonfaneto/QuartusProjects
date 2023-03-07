module ButtonDebouncer (
	input wire ButtonIn,
	input wire Clk,
	output wire ButtonOut
);
	
	wire DivClk;
	wire Q0, Q1, Q2;
	wire NotQ0, NotQ1, NotQ2;

	ClockDivider #(.CounterMax(124999), .CounterSize(17))
	(
		.Clk(Clk),
		.DivClk(DivClk)
	);

	FF_TypeD FF_TD0 (
		.Clk(DivClk),
		.D(ButtonIn),
		.Q(Q0),
		.NotQ(NotQ0)
	);

	FF_TypeD FF_TD1 (
		.Clk(DivClk),
		.D(Q0),
		.Q(Q1),
		.NotQ(NotQ1)
	);

	FF_TypeD FF_TD2 (
		.Clk(DivClk),
		.D(Q1),
		.Q(Q2),
		.NotQ(NotQ2)
	);

	assign ButtonOut = Q1 & NotQ2;
	
endmodule	