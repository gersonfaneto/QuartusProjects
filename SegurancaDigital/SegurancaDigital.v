module SegurancaDigital (
	// Declaration of I/O
	input [3:0] CorrectPasswd, UserTry,
	output [6:0] DiffDisplay,
	output [3:0] ShowDigit,
	output LRed, LBlue, LGreen,
	output IsNeg
);

	// Declaration of Wires
	wire Bin, Bout;
	wire [1:0] NotIsEqual, IsEqual, IsLower, IsGreater;
	wire [3:0] FirstOp, SecondOp, Diff;
	wire [4:0] DiffBCD;
	

	/* Circuit Declaration
	(Using Both Instantiation & 
	Logic Gates) */
	
	// 1º - Compare The CorrectPasswd & The UserTry
	MagnitudeComparator Comp0 (.A(CorrectPasswd), 
							   .B(UserTry), 
							   .AeqB(IsEqual[0]), 
							   .AltB(IsLower[0]), 
							   .AgtB(IsGreater[0]));
	
	// 2º - Swap The Values Before Subtracting (If CorrectPasswd < UserTry)
	ValueSwapper Swap0 (.A(CorrectPasswd), 
						.B(UserTry), 
						.X(FirstOp), 
						.Y(SecondOp), 
						.toSwap(IsLower));
	not (IsNeg, IsLower[0]);

	// 3º - Get The Difference Between Them
	Subtractor4Bits Sub0 (.A(FirstOp), 
						  .B(SecondOp), 
						  .Bin(Bin), 
						  .D(Diff), 
						  .Bout(Bout));
							
	// 4º - Compare If The Difference Is In Range (Diff < 3)
	MagnitudeComparator Comp1 (.A(Diff), 
							   .B(2'b11), 
							   .AeqB(IsEqual[1]), 
							   .AltB(IsLower[1]), 
							   .AgtB(IsGreater[1]));
					
	// 5º - Convert The Difference To BCD
	BinaryToBCD BCD0 (.Bin(Diff), 
					  .BCD(DiffBCD));
					  
	// 6º - Encode The BCD To Be Displayed
	BCDToDisplay Display0 (.BCD(DiffBCD), 
						   .Display(DiffDisplay));
	
	//  7º - (Output) Activate Each Led/Digit
	
	// Green -> All Okay
	or (LGreen, 1'b0, IsEqual[0]);
	
	// Red -> Diff Overflow
	or (LRed, 1'b0, IsGreater[1]);
	
	// Blue -> Diff (-3 ~ +3)
	not (NotIsEqual[0], IsEqual[0]);
	or (NotIsEqual[1], IsLower[1], IsEqual[1]);
	and (LBlue, NotIsEqual[0], NotIsEqual[1]);
	
	// Show Diff (Active/Deactivate Digits)
	not (ShowDigit[0], LBlue);
	not (ShowDigit[1], 1'b0);	
	not (ShowDigit[2], 1'b0);
	not (ShowDigit[3], 1'b0);
	
endmodule	