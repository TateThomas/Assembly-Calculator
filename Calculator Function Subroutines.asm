;
;	Calculator Functions Module
;
	.ORIG	x3300
;
;				Subtract Function
Sub	NOT 	R2,R2		;Num 1 in R1, Num 2 in R2, Result in R0
	ADD 	R2,R2,#1
	ADD 	R0,R1,R2
	RET
;
;				Multiply Function
Mult	AND	R0,R0,#0	;Num 1 in R1, Num 2 in R2, Result in R0
	AND 	R1,R1,xFFFF
	BRnp 	Next		;Checking if Num 1 is 0
	AND 	R0,R0,#0
	RET
Next	AND 	R2,R2,xFFFF	;Checking if Num 2 is 0
	BRnp 	Next1
	AND 	R0,R0,#0
	RET
Next1	AND 	R2,R2,xFFFF	;Checking if Num 2 is negative
	BRn 	MultN
Loop	ADD 	R0,R0,R1	;Main mult loop
	AND	R1,R1,xFFFF
	BRp	Pos
	BRn	Neg
Return	ADD 	R2,R2,#-1
	BRp 	Loop
	RET
MultN	ADD 	R0,R0,R1	;Mult negative loop
	AND	R1,R1,xFFFF
	BRp	Pos1
	BRn	Neg1
Return1	ADD 	R2,R2,#1
	BRn 	MultN
	NOT 	R0,R0
	ADD 	R0,R0,#1
	RET
Pos	AND	R0,R0,xFFFF
	BRn	MultE
	BRp	Return
	RET
Neg	AND	R0,R0,xFFFF
	BRp	MultE
	BRn	Return
	RET
Pos1	AND	R0,R0,xFFFF
	BRn	MultE
	BRp	Return1
	RET
Neg1	AND	R0,R0,xFFFF
	BRp	MultE
	BRn	Return1
	RET
MultE	LEA	R0,Error1
	PUTS
	LD	R0,Start
	JSRR	R0
;
;				Divide Function
Div	ST	R7,DivRet	;Numerator in R3, Denominator in R4, Result in R0
	AND 	R5,R5,#0	
	AND	R6,R6,#0
	AND 	R3,R3,xFFFF
	BRnp 	Next2
	AND 	R0,R0,#0
	RET			;Return 0 because Numerator is 0
Next2	AND 	R4,R4,xFFFF
	BRnp 	Next3
	LEA	R0,Error2
	PUTS
	LD	R0,Start
	JSRR	R0		;End Program because Denominator is 0
Next3	AND 	R3,R3,xFFFF	;Checking if Num1 is Negative
	BRzp	Next10
	NOT	R3,R3		;Flipping Num1 to Positive
	ADD	R3,R3,#1
	ADD	R6,R6,#1
Next10	AND 	R4,R4,xFFFF	;Checking if Num2 is Negative
	BRzp	Next11
	NOT	R4,R4		;Flipping Num2 to positive
	ADD	R4,R4,#1
	ADD	R6,R6,#1
Next11	AND 	R1,R1,#0	;Clear R1 and R2
	AND 	R2,R2,#0
	ADD 	R1,R1,R3	;Make R1 = R3 and R2 = R4
	ADD 	R2,R2,R4
	JSR 	Sub		;Subtract Funtion for R1 and R2
	ADD	R5,R5,#1
	AND	R3,R3,#0
	ADD	R3,R3,R0	;Set R3 to R0
	BRp	Next3
	BRzp	Next9
	ADD	R5,R5,#-1
Next9	AND	R0,R0,#0
	ADD	R0,R0,R5
	AND	R6,R6,xFFFF	;Checking if R6 is positive
	BRnz	Next12
	NOT	R0,R0		;Flipping the result to Negative because R6 was positive
	ADD	R0,R0,#1
Next12	LD	R7,DivRet
	RET
;
;				Floor Division Function
Floor	ST	R7,FloorRet	;Num1 in R1, Num2 in R2, Result in R0
	ST	R1,Floor1
	ST	R2,Floor2
	LD	R3,Floor1
	LD	R4,Floor2
	JSR	Div
	ST	R0,Floor3
	LD	R1,Floor3
	LD	R2,Floor2
	JSR	Mult
	ST	R0,Floor4
	LD	R1,Floor1
	LD	R2,Floor4
	JSR	Sub
	LD	R7,FloorRet
	Ret
;
;				Exponential Function
Exp	ST	R7,ExpRet	;Num in R3, Exp in R4, Result in R0
	AND	R0,R0,#0
	ADD	R0,R0,R3
	AND	R2,R2,#0
	ADD	R2,R2,R3	;Setting R2 to Num 1
	ADD	R4,R4,#-1
	BRp	Loop2		;Checking if Exponent is 1 or 0
	BRz	Next4		;Checking if the Exponent is 1
	ADD	R4,R4,#1
	BRn	Next16
	AND	R0,R0,#0
	ADD	R0,R0,#1	;Setting Result to 1 because Exponent is 0
	RET
Next4	RET
Next16	LEA	R0,Error3
	PUTS
	LD	R0,Start
	JSRR	R0
Loop2	AND	R1,R1,#0
	ADD	R1,R1,R0	;Setting R1 to the result
	ADD	R2,R3,#0
	JSR	Mult		;Multiplication function for R1 and R2
	ADD	R4,R4,#-1	;Decrement the exponent
	BRp	Loop2
	LD	R7,ExpRet
	RET
;
;				Root Function
Root	ST	R7,RootRet	;Num in R1, Root in R2, Result in R0
	AND	R3,R3,#0
	AND	R4,R4,#0	;Clearing R4 and R3
	AND	R5,R5,#0
	ST	R1,Root1
	ST	R2,Root2
	LD	R1,Root2
	AND	R2,R2,#0
	ADD	R2,R2,#2
	JSR	Floor
	AND	R0,R0,xFFFF
	BRp	Next15
	LD	R1,Root1
	BRzp	Next15
	LEA	R0,Error4
	PUTS
	LD	R0,Start
	JSRR	R0		;Halting because Num is Negative and Root is Even
Next15	LD	R6,Root1
	LD	R7,Root2
	ADD	R3,R3,R6	;Setting Numerator
	ADD	R4,R4,R7	;Setting Denominator
	JSR	Div
	ADD	R3,R0,#0
	LD	R4,Root2
	JSR	Div
	ADD	R3,R0,#0
	LD	R4,Root2
	JSR	Div
	ADD	R3,R0,#0
	LD	R4,Root2
	JSR	Div
	ADD	R3,R0,#0
	LD	R4,Root2
	JSR	Div
	ST	R0,RootAns
	AND	R3,R3,#0
	AND	R4,R4,#0	;Clearing R3 and R4 for Exponent Function
	ADD	R3,R3,R0	;Num = result from Divide function
	LD	R6,Root2
	ADD	R4,R4,R6	;Exponent = Root
	JSR	Exp
	AND	R1,R1,#0
	AND	R2,R2,#0	;Clearing R1 and R2 for Subtract function
	LD	R6,Root1
	ADD	R1,R1,R6	;Num = Num 1 for Sub
	ADD	R2,R2,R0	;Num2 = result from Exp
	JSR	Sub
	AND	R0,R0,xFFFF
	BRn	RootN
	BRp	RootP
	AND	R0,R0,#0	;Clearing Result Register
	LD	R6,RootAns
	ADD	R0,R0,R6	;Result = Result from Div
	LD	R7,RootRet
	RET
RootN	LD	R3,RootAns	;Root Negative Function
	ADD	R3,R3,#-1
	ST	R3,RootAns	;Setting Num = RootAns for Exp Function
	AND	R4,R4,#0	;Clearing R4
	LD	R7,Root2
	ADD	R4,R4,R7	;Setting Exponent to Root for Exp Function
	JSR	Exp
	AND	R1,R1,#0
	AND	R2,R2,#0	;Clearing R1 and R2 for Sub Function
	LD	R7,Root1
	ADD	R1,R1,R7	;Num1 = Root Num for Sub Function
	ADD	R2,R2,R0	;Num2 = Result of Exp Function
	JSR	Sub
	AND	R0,R0,xFFFF
	BRnz	Next5
	ADD	R6,R6,#1	;Adding 1 to register to check if the functions are looping
Next5	ADD	R6,R6,#-2
	BRnp	Next6
	LD	R0,RootAns	;Result is this functions answer because of a loop
	BRp	Next13
	ADD	R0,R0,#1
Next13	LD	R7,RootRet
	RET
Next6	AND	R0,R0,xFFFF
	BRp	RootP		;Branching to Root Positive Function because the dif is pos
	AND	R6,R6,#0
	AND	R0,R0,xFFFF
	BRn	RootN		;Branching to Root Negative Function because the dif is neg
	LD	R0,RootAns	;Result is this funcions answer
	LD	R7,RootRet
	RET
RootP	LD	R3,RootAns	;Root Positive Function
	ADD	R3,R3,#1
	ST	R3,RootAns
	AND	R4,R4,#0
	LD	R7,Root2
	ADD	R4,R4,R7
	JSR	Exp
	AND	R1,R1,#0
	AND	R2,R2,#0
	LD	R7,Root1
	ADD	R1,R1,R7
	ADD	R2,R2,R0
	JSR	Sub
	AND	R0,R0,xFFFF
	BRzp	Next7
	ADD	R6,R6,#1
Next7	ADD	R6,R6,#-2
	BRnp	Next8
	LD	R0,RootAns
	BRp	Next14
	ADD	R0,R0,#1
Next14	LD	R7,RootRet
	RET
Next8	AND	R0,R0,xFFFF
	BRn	RootN
	AND	R6,R6,#0
	AND	R0,R0,xFFFF
	BRp	RootP
	LD	R0,RootAns
	LD	R7,RootRet
	RET
;
DivRet		.BLKW	1
FloorRet	.BLKW	1
Floor1		.BLKW	1
Floor2		.BLKW	1
Floor3		.BLKW	1
Floor4		.BLKW	1
ExpRet		.BLKW	1
RootRet		.BLKW	1
Root1		.BLKW	1
Root2		.BLKW	1
RootAns		.BLKW	1
Start		.FILL	x3000
Error1		.STRINGZ	"ERROR: Number too large for LC3."
Error2		.STRINGZ	"ERROR: 0 in Denominator."
Error3		.STRINGZ	"ERROR: Unable to do negative exponents."
Error4		.STRINGZ	"ERROR: Negative value in even root."
;
	.END