;
;	Calculator I/O module
;
	.ORIG	x3000
	AND	R0,R0,#0
	ADD	R0,R0,#10
	OUT			;Output Newline twice
	OUT
	LEA	R0,Prompt
	PUTS			;Output Prompt
	LD	R3,N
	AND	R3,R3,#0	;Reset N (place counter)
	ST	R3,N
	BRnzp	Input
;
Prompt		.STRINGZ	"Enter 2 numbers (plus the sign in front) in 4 digits. Use one of the following functions in between: +,-,*,^,r. Press = when done. Press x to exit. (Example: +0016r+0002= square root of 16) > "
N		.FILL	#0
;
Input	GETC
	OUT
	LD	R3,N
	ADD	R3,R3,#1	;Increment N (place counter)
	ST	R3,N
	ST	R0,Char
	LD	R2,FillE
	ADD	R0,R0,R2	;Check if input is =
	BRz	Equals
	LD	R0,Char
	LD	R2,Fill16
	ADD	R0,R0,R2	;Check if input is x
	BRz	Exit
	LD	R0,Char
	LD	R2,Fill0
	ADD	R0,R0,R2	;Check if input is 0
	BRz	Zero
	LD	R0,Char
	LD	R2,Fill1
	ADD	R0,R0,R2	;Check if input is 1
	BRz	One
	LD	R0,Char
	LD	R2,Fill2
	ADD	R0,R0,R2	;Check if input is 2
	BRz	Two
	LD	R0,Char
	LD	R2,Fill3
	ADD	R0,R0,R2	;Check if input is 3
	BRz	Three
	LD	R0,Char
	LD	R2,Fill4
	ADD	R0,R0,R2	;Check if input is 4
	BRz	Four
	LD	R0,Char
	LD	R2,Fill5
	ADD	R0,R0,R2	;Check if input is 5
	BRz	Five
	LD	R0,Char
	LD	R2,Fill6
	ADD	R0,R0,R2	;Check if input is 6
	BRz	Six
	LD	R0,Char
	LD	R2,Fill7
	ADD	R0,R0,R2	;Check if input is 7
	BRz	Seven
	LD	R0,Char
	LD	R2,Fill8
	ADD	R0,R0,R2	;Check if input is 8
	BRz	Eight
	LD	R0,Char
	LD	R2,Fill9
	ADD	R0,R0,R2	;Check if input is 9
	BRz	Nine
	LD	R0,Char
	LD	R2,Fill10
	ADD	R0,R0,R2	;Check if input is +
	BRz	Adds
	LD	R0,Char
	LD	R2,Fill11
	ADD	R0,R0,R2	;Check if input is -
	BRz	Subt
	LD	R0,Char
	LD	R2,Fill12
	ADD	R0,R0,R2	;Check if input is *
	BRz	Multi
	LD	R0,Char
	LD	R2,Fill13
	ADD	R0,R0,R2	;Check if input is /
	BRz	Divi
	LD	R0,Char
	LD	R2,Fill14
	ADD	R0,R0,R2	;Check if input is ^
	BRz	Expo
	LD	R0,Char
	LD	R2,Fill15
	ADD	R0,R0,R2	;Check if input is r
	BRz	Roots
	LEA	R0,Error
	PUTS			;Print an error because no other character is acceptable
	BRnzp	Start
;
Start	LD	R0,Beg
	JSRR	R0		;Jump to the start of the program
;
Char		.BLKW	1
FillE		.FILL	#-61	;Negative hex of characters
Fill0		.FILL	#-48
Fill1		.FILL	#-49
Fill2		.FILL	#-50
Fill3		.FILL	#-51
Fill4		.FILL	#-52
Fill5		.FILL	#-53
Fill6		.FILL	#-54
Fill7		.FILL	#-55
Fill8		.FILL	#-56
Fill9		.FILL	#-57
Fill10		.FILL	#-43
Fill11		.FILL	#-45
Fill12		.FILL	#-42
Fill13		.FILL	#-47
Fill14		.FILL	#-94
Fill15		.FILL	#-114
Fill16		.FILL	#-120
Beg		.FILL	x3000
Error		.STRINGZ	" ERROR: Invalid input."
;
Exit	HALT
Zero	LD 	R1,Num		;Load 0 in R1
	BRnzp	Place
One	LD 	R1,Num
	ADD	R1,R1,#1	;R1 = 1
	BRnzp	Place
Two	LD 	R1,Num
	ADD	R1,R1,#2	;R1 = 2
	BRnzp	Place
Three	LD 	R1,Num
	ADD	R1,R1,#3	;R1 = 3
	BRnzp	Place
Four	LD 	R1,Num
	ADD	R1,R1,#4	;R1 = 4
	BRnzp	Place
Five	LD 	R1,Num
	ADD	R1,R1,#5	;R1 = 5
	BRnzp	Place
Six	LD 	R1,Num
	ADD	R1,R1,#6	;R1 = 6
	BRnzp	Place
Seven	LD 	R1,Num
	ADD	R1,R1,#7	;R1 = 7
	BRnzp	Place
Eight	LD 	R1,Num
	ADD	R1,R1,#8	;R1 = 8
	BRnzp	Place
Nine	LD 	R1,Num
	ADD	R1,R1,#9	;R1 = 9
	BRnzp	Place
Adds	LD	R1,Num
	ADD	R1,R1,#1	;R1 = 1 (Value for add)
	BRnzp	Place
Subt	LD	R1,Num
	ADD	R1,R1,#2	;R1 = 2 (Value for subtract)
	BRnzp	Place
Multi	LD	R1,Num
	ADD	R1,R1,#3	;R1 = 3 (Value for multiply)
	BRnzp	Place
Divi	LD	R1,Num
	ADD	R1,R1,#4	;R1 = 4 (Value for divide)
	BRnzp	Place
Expo	LD	R1,Num
	ADD	R1,R1,#5	;R1 = 5 (Value for exponent)
	BRnzp	Place
Roots	LD	R1,Num
	ADD	R1,R1,#6	;R1 = 6 (Value for root)
	BRnzp	Place
;
Place	LD	R3,N		;This part of the program decrements N to find the place of the input
	ADD	R3,R3,#-1
	BRz	Num1Sign
	ADD	R3,R3,#-1
	BRz	One1
	ADD	R3,R3,#-1
	BRz	Two1
	ADD	R3,R3,#-1
	BRz	Three1
	ADD	R3,R3,#-1
	BRz	Four1
	ADD	R3,R3,#-1
	BRz	Sign
	ADD	R3,R3,#-1
	BRz	Num2Sign
	ADD	R3,R3,#-1
	BRz	One2
	ADD	R3,R3,#-1
	BRz	Two2
	ADD	R3,R3,#-1
	BRz	Three2
	ADD	R3,R3,#-1
	BRz	Four2
;
Num1Sign ST	R1,Sign1	;Store value in designated spot
	BRnzp	Input
One1	ST	R1,Num1
	BRnzp	Input
Two1	ST	R1,Num2
	BRnzp	Input
Three1	ST	R1,Num3
	BRnzp	Input
Four1	ST	R1,Num4
	BRnzp	Input
Num2Sign ST	R1,Sign2
	BRnzp	Input
One2	ST	R1,Num5
	BRnzp	Input
Two2	ST	R1,Num6
	BRnzp	Input
Three2	ST	R1,Num7
	BRnzp	Input
Four2	ST	R1,Num8
	BRnzp	Input
Sign	ST	R1,Funct
	BRnzp	Input
;
Num		.FILL	#0
;
Equals	LD	R2,Num1		;Load the value of each place into 4 different registers
	LD	R3,Num2
	LD	R4,Num3
	LD	R5,Num4
	JSR	Conv		;Convert those numbers into a decimal value
	LD	R7,Sign1
	ADD	R7,R7,#-1	;Check if the sign is positive, if so jump to next
	BRz	Next
	NOT	R0,R0
	ADD	R0,R0,#1	;Flipping the value because its negative
Next	ST	R0,Result1	;Store the result
	LD	R2,Num5		;Load the value of each place of the second number into 4 different registers
	LD	R3,Num6
	LD	R4,Num7
	LD	R5,Num8
	JSR	Conv		;Convert those numbers into a decimal digit
	LD	R7,Sign2
	ADD	R7,R7,#-1	;Check if sign is positive, if so jump to next1
	BRz	Next1
	NOT	R0,R0
	ADD	R0,R0,#1	;Flipping the value because its negative
Next1	ST	R0,Result2	;Store the result
	BRnzp	Final
;
Conv	ST	R7,ConvRet	;Store the return value
	LD	R1,OneTh	;Load 1000 in R1
	LD	R0,Mult		;Load the address of the multiply function
	JSRR	R0		;Jump to multiply
	ST	R0,Total	;Store the total
	LD	R1,OneHu	;Load 100 in R1
	AND	R2,R2,#0
	ADD	R2,R2,R3	;Move the second number to R2
	LD	R0,Mult
	JSRR	R0		;Jump to multiply
	LD	R1,Total	;Load the total
	ADD	R0,R0,R1	;Add the total to the multiply result
	ST	R0,Total	;Store the total
	LD	R1,Ten
	AND	R2,R2,#0
	ADD	R2,R2,R4
	LD	R0,Mult
	JSRR	R0
	LD	R1,Total
	ADD	R0,R0,R1
	ADD	R0,R0,R5	;Adding decimal place 1 to the total
	ST	R0,Total
	LD	R7,ConvRet	;Load return address
	RET
;
Final	LD	R6,Funct	;This part decrements the function value to jump to designated place
	ADD	R6,R6,#-1
	BRz	A
	ADD	R6,R6,#-1
	BRz	S
	ADD	R6,R6,#-1
	BRz	M
	ADD	R6,R6,#-1
	BRz	D
	ADD	R6,R6,#-1
	BRz	E
	ADD	R6,R6,#-1
	BRz	R
;
A	LD	R1,Result1	;This part loads the 2 results into their designated spot for the function to be executed
	LD	R2,Result2
	ADD	R0,R1,R2
	BRnzp	Output
S	LD	R1,Result1
	LD	R2,Result2
	LD	R3,Sub
	JSRR	R3
	BRnzp	Output
M	LD	R1,Result1
	LD	R2,Result2
	LD	R3,Mult
	JSRR	R3
	BRnzp	Output
D	LD	R3,Result1
	LD	R4,Result2
	LD	R5,Div
	JSRR	R5
	BRnzp	Output
E	LD	R3,Result1
	LD	R4,Result2
	LD	R5,Exp
	JSRR	R5
	BRnzp	Output
R	LD	R1,Result1
	LD	R2,Result2
	LD	R3,Root
	JSRR	R3
	BRnzp	Output
;
Output	ST	R0,Answer	;Convert back to ASCII
	AND	R0,R0,xFFFF
	BRzp	Next2		;Check to see if result is negative
	NOT	R0,R0
	ADD	R0,R0,#1	;Flip the result back to positive
	ST	R0,Answer
	AND	R0,R0,#0
	LD	R1,Neg		;Load ASCII for -
	ADD	R0,R0,R1
	OUT
	LD	R0,Answer
Next2	AND	R0,R0,#0
	ADD	R0,R0,#-1	;Set R0 to -1
	LD	R2,Neg10000	;Load -10000 in R2
	LD	R1,Answer	;Load answer in R1
Loop	ADD	R0,R0,#1	;Increment R0
	ADD	R1,R1,R2	;Add negative value to answer
	BRzp	Loop		;Loop until the answer goes negative
	LD	R4,Offset
	ADD	R0,R0,R4	;Add the ASCII offset to R0
	OUT			;Output final value
	LD	R2,TenTh
	ADD	R1,R1,R2	;Add 10000 to answer to make it positive again
	ST	R1,Answer
;				Routines to do the same thing for the rest of each decimal place
	AND	R0,R0,#0
	ADD	R0,R0,#-1
	LD	R2,Neg1000
	LD	R1,Answer
Loop1	ADD	R0,R0,#1
	ADD	R1,R1,R2
	BRzp	Loop1
	LD	R4,Offset
	ADD	R0,R0,R4
	OUT
	LD	R2,OneTh
	ADD	R1,R1,R2
	ST	R1,Answer
;
	AND	R0,R0,#0
	ADD	R0,R0,#-1
	LD	R2,Neg100
	LD	R1,Answer
Loop2	ADD	R0,R0,#1
	ADD	R1,R1,R2
	BRzp	Loop2
	LD	R4,Offset
	ADD	R0,R0,R4
	OUT
	LD	R2,OneHu
	ADD	R1,R1,R2
	ST	R1,Answer
;
	AND	R0,R0,#0
	ADD	R0,R0,#-1
	LD	R2,Neg10
	LD	R1,Answer
Loop3	ADD	R0,R0,#1
	ADD	R1,R1,R2
	BRzp	Loop3
	LD	R4,Offset
	ADD	R0,R0,R4
	OUT
	LD	R2,Ten
	ADD	R1,R1,R2
	ST	R1,Answer
;
	LD	R0,Answer	;Answer is only 1 decimal digit now so you can add the offset to get the output result
	ADD	R0,R0,R4
	OUT
;
	LD	R0,Beg2		;Load the address of the start of the program
	JSRR	R0
;
Num1		.BLKW	1	;Storage spots for decimal place values of the input
Num2		.BLKW	1
Num3		.BLKW	1
Num4		.BLKW	1
Num5		.BLKW	1
Num6		.BLKW	1
Num7		.BLKW	1
Num8		.BLKW	1
Sign1		.BLKW	1
Sign2		.BLKW	1
Funct		.BLKW	1
TenTh		.FILL	#10000
OneTh		.FILL	#1000
OneHu		.FILL	#100
Ten		.FILL	#10
Total		.FILL	#0
Result1		.BLKW	1	;Storage for first and second numbers
Result2		.BLKW	1
Sub		.FILL	x3300	;Addresses of function subroutines
Mult		.FILL	x3304
Div		.FILL	x3333
Exp		.FILL	x336D
Root		.FILL	x3387
ConvRet		.BLKW	1
Answer		.BLKW	1
Offset		.FILL	#48
Neg10000	.FILL	#-10000
Neg1000		.FILL	#-1000
Neg100		.FILL	#-100
Neg10		.FILL	#-10
Beg2		.FILL	x3000	;Address of the beginning of the program
Neg		.FILL	#45
	.END